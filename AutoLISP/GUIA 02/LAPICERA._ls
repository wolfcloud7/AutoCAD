(defun C:LAPICERA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 25)
  (command "_UCS" "_WORLD")

;PUNTOS
  (setq center(getpoint "Ingresar punto central: "))
  (setq size(getdist "Ingresar tamaño: "))

;CONO
  (command "_CONE" center (* 3.5 size) (* 13 size))
  
 )