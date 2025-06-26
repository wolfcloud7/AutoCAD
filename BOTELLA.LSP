(defun c:BOTELLA (/ p cuerpo cuello rebaje tapa ranura rebajeTapa piquito)

  ;; Punto de inserción
  (setq p (getpoint "\nPunto de inserción: "))

  ;; --- 1. Cuerpo principal (64 x 100) ---
  (command "_CYLINDER" p 32 100)
  (setq cuerpo (entlast))

  ;; --- 2. Rebaje superior (64 x 10) ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 100)) 32 10)
  (setq rebaje (entlast))

  ;; --- 3. Cuello (70 x 10) ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 110)) 35 10)
  (setq cuello (entlast))

  ;; --- 4. Tapa exterior (70 x 20.5) ---
  (command "_CYLINDER"
           (list (car p) (cadr p) (+ (caddr p) 120)) 35 20.5)
  (setq tapa (entlast))

  ;; --- 5. Rebaje interior en la t
