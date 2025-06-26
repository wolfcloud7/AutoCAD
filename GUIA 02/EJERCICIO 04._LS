(defun c:roldana (/ pt D anchobase alturabase soporte espesor dist
                  centroX centroY r_ext r_int ancho_roldana)

  ;; Ingreso de punto y diámetro
  (setq pt (getpoint "\nInserción: "))
  (setq D  (getreal  "\nDiámetro: "))

  ;; Cálculo de proporciones
  (setq baseWidth (* 1.5 D))
  (setq baseHeight D)
  (setq soporteEsp (* 0.2 D))
  (setq distSoportes (* 0.6 D))
  (setq anchoRoldana (* 0.3 D))

  ;; Coordenadas de partes
  (setq centroX (+ (car pt) (/ baseWidth 2.0)))
  (setq centroY (+ (cadr pt) baseHeight (/ soporteEsp 2)))

  ;; Crear base
  (command "RECTANG" pt (list (+ (car pt) baseWidth) (+ (cadr pt) baseHeight)))

  ;; Crear soportes (2 lados)
  (foreach x (list (car pt) (+ (car pt) baseWidth (- soporteEsp)))
    (command "RECTANG"
             (list x (+ (cadr pt) baseHeight))
             (list (+ x soporteEsp) (+ (cadr pt) baseHeight D))))

  ;; Crear roldana (círculos concéntricos)
  (command "CIRCLE" (list centroX (+ (cadr pt) baseHeight D)) (/ D 2))       ;; exterior
  (command "CIRCLE" (list centroX (+ (cadr pt) baseHeight D)) (* 0.2 D))     ;; interior

  ;; Crear centro de eje (línea horizontal)
  (command "LINE"
           (list (- centroX (/ distSoportes 2)) (+ (cadr pt) baseHeight D))
           (list (+ centroX (/ distSoportes 2)) (+ (cadr pt) baseHeight D))
           "")
  (princ)
)
