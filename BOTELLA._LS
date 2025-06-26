(defun c:BOTELLA (/ p cuerpo cuello rebaje tapa ranura)

  ;; Punto de inserción
  (setq p (getpoint "\nPunto de inserción: "))

  ;; --- 1. Cuerpo principal (cilindro de 64x100) ---
  (command "_CYLINDER" p 32 100)
  (setq cuerpo (entlast))

  ;; --- 2. Rebaje superior (cilindro de 64x10) para simular reducción arriba ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 100)) 32 10)
  (setq rebaje (entlast))

  ;; --- 3. Cuello más ancho (70x10) ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 110)) 35 10)
  (setq cuello (entlast))

  ;; --- 4. Tapa (gris oscuro, 70x20.5) encima del cuello ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 120)) 35 20.5)
  (setq tapa (entlast))

  ;; --- 5. Ranura/corte rectangular en la tapa ---
  (command "_BOX"
           (list (+ (car p) 35) (- (cadr p) 2.5) (+ (caddr p) 120))  ; esquina inferior-izquierda
           (list (+ (car p) 40) (+ (cadr p) 2.5) (+ (caddr p) 140.5))) ; 5x5x20.5
  (setq ranura (entlast))

  ;; --- 6. Restar ranura a la tapa ---
  (command "_SUBTRACT" tapa "" ranura "")

  (prompt "\nBotella 3D generada.")
  (princ)
)
