(defun c:LAMINA (/ ancho alto ptInsercion rotulo)
  (setq ancho (getdist "\nAncho: "))
  (setq alto (getdist "\nAlto: "))
  (setq ptInsercion (getpoint "\nPunto de inserción (esquina inferior izquierda): "))
  
  (command "_RECTANG" ptInsercion (list (+ (car ptInsercion) ancho) (+ (cadr ptInsercion) alto))) 
  (princ)
)