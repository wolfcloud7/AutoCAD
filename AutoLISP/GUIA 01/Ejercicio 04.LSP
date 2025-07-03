(defun c:ARO (/ centro radioExt radioInt relleno circExt circInt)
  ; CIRCULOS
  (setq centro (getpoint "\nCentro del aro: "))
  (setq rext   (getdist centro "\nRadio exterior: "))
  (setq rint   (getdist centro "\nRadio interior: "))
  
  ; Valida que el radio interior sea menor
  (while (>= radioInt radioExt)
    (princ "\nEl radio interior debe ser MENOR que el exterior")
    (setq rint (getdist centro "\nNuevo radio interior: "))
  )
  
  (command "_CIRCLE" centro radioExt)
  (setq circExt (entlast))
  (command "_CIRCLE" centro radioInt)
  (setq circInt (entlast))
  
  ; Pregunta si quiere relleno
  (initget "Si No")
  (setq relleno (getkword "\nRelleno [Si/No] <No>: "))
  
  ; Aplica hatch al ÁREA ENTRE los círculos (seleccionando ambos)
  (if (eq relleno "Si")
    (command 
      "_HATCH" "_P" "SOLID" "_S" circExt circInt ""
      "" )
  )
  (princ)
)