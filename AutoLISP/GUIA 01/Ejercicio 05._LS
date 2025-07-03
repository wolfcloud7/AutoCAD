(defun c:ZIGZAG (/ pInicio nReps distancia angulo pActual i)
  (setq p_inicio (getpoint "\nPunto inicial: "))
  (setq rep (getint "\nRepeticiones: "))
  (setq dist (getdist p_nicio "\nDistancia: "))
  (setq ang (* pi 0.25))
  (setq p_actual p_inicio)
  (repeat rep
    (command "_LINE" p_actual 
             (setq p_actual (polar p_actual ang dist))
    (command "_LINE" p_actual 
             (setq p_actual (polar p_actual (- angulo) distancia)))
  (princ)
)