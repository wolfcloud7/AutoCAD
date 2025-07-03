(defun c:RECTANGULO ()
  (command "_RECTANG" (getpoint "\nPrimer punto: ") (getpoint "\nSegundo punto: "))
  (princ)
)