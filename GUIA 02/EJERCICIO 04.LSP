(defun C:ROLDANA (/ p D anchobase alturabase soporte espesor dist
                  centroX centroY centroZ r_ext r_int ancho_roldana
                  base sup1 sup2 roldana eje taladro)

  ;; Solicita punto de inserción y diámetro
  (setq p (getpoint "\nInserción: "))
  (setq D (getreal "\nDiámetro de la roldana: "))

  ;; Cálculo de proporciones
  (setq anchobase (* 1.5 D))
  (setq alturabase D)
  (setq espesor (* 0.1 D))       ; espesor de la base
  (setq soporte (* 0.2 D))       ; grosor de cada soporte
  (setq dist (* 0.6 D))          ; distancia entre soportes (hueco)
  (setq ancho_roldana (* 0.3 D)) ; espesor de la roldana (cilindro)

  ;; Radios roldana
  (setq r_ext (/ D 2.0))
  (setq r_int (* 0.2 D))

  ;; Centro de la roldana (entre los soportes, en la parte superior)
  (setq centroX (+ (car p) (/ anchobase 2.0)))
  (setq centroY (+ (cadr p) (/ alturabase 2.0)))
  (setq centroZ (+ (caddr p) espesor soporte))

  ;; --- BASE ---
  (command "_BOX"
           p
           (list (+ (car p) anchobase)
                 (+ (cadr p) alturabase)
                 (+ (caddr p) espesor)))
  (setq base (entlast))

  ;; --- SOPORTES (izquierdo y derecho) ---
  ;; Soporte izquierdo
  (command "_BOX"
           (list (+ (car p) (* 0.3 D)) (cadr p) (+ (caddr p) espesor))
           (list (+ (car p) (* 0.3 D) soporte) (+ (cadr p) alturabase) (+ (caddr p) espesor soporte)))
  (setq sup1 (entlast))

  ;; Soporte derecho
  (command "_BOX"
           (list (- (+ (car p) anchobase) (* 0.3 D) soporte) (cadr p) (+ (caddr p) espesor))
           (list (- (+ (car p) anchobase) (* 0.3 D)) (+ (cadr p) alturabase) (+ (caddr p) espesor soporte)))
  (setq sup2 (entlast))

  ;; --- ROLDANA ---
  ;; Crear cilindro vertical (eje Z)
  (command "_CYLINDER"
           (list centroX centroY (- centroZ (/ ancho_roldana 2.0)))
           r_ext
           ancho_roldana)
  (setq roldana (entlast))
  ;; Rotar -90° en eje X ? queda en eje Y
  (command "_ROTATE3D" roldana "" "_XAxis" "" -90)
  ;; Mover al centro correcto
  (command "_MOVE" roldana "" (list centroX centroY centroZ) (list centroX centroY centroZ))

  ;; --- AGUJERO INTERIOR DE ROLDANA ---
  (command "_CYLINDER"
           (list centroX centroY (- centroZ (/ ancho_roldana 2.0)))
           r_int
           ancho_roldana)
  (setq eje (entlast))
  (command "_ROTATE3D" eje "" "_XAxis" "" -90)
  (command "_MOVE" eje "" (list centroX centroY centroZ) (list centroX centroY centroZ))
  (command "_SUBTRACT" roldana "" eje "")

  ;; --- TALADROS EN LA BASE ---
  (setq taladro '())  ; lista vacía

  (foreach punto
    (list
      (list (+ (car p) (* 0.2 D)) (+ (cadr p) (* 0.2 D)) (+ (caddr p) espesor))
      (list (- (+ (car p) anchobase) (* 0.2 D)) (+ (cadr p) (* 0.2 D)) (+ (caddr p) espesor))
      (list (+ (car p) (* 0.2 D)) (- (+ (cadr p) alturabase) (* 0.2 D)) (+ (caddr p) espesor))
      (list (- (+ (car p) anchobase) (* 0.2 D)) (- (+ (cadr p) alturabase) (* 0.2 D)) (+ (caddr p) espesor))
    )
    (progn
      (command "_CYLINDER" punto (* 0.08 D) (+ espesor 1.0))
      (setq taladro (cons (entlast) taladro)))
  )

  ;; SUBTRACT único con todos los agujeros
  (command "_SUBTRACT" base "")
  (foreach t taladro (command t))
  (command "")

  (prompt "\nRoldana 3D creada correctamente.")
  (princ)
)
