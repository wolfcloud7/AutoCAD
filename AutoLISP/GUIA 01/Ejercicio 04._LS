(defun c:ARO (/ centro radio relleno)
  (setq centro (getpoint "\nCentro del aro: "))
  (setq radio (getdist centro "\nRadio del aro: "))
  ;Relleno
  (initget "Si No")
  (setq relleno (getkword "\n¿Quieres rellenar el aro? [Si/No] <No>: "))
  (command "_CIRCLE" centro radio)
  ;Aplica relleno
  (if (eq relleno "Si")
    (command "_HATCH" "_P" "SOLID" "_S" (entlast) "" ""))
  (princ)
)