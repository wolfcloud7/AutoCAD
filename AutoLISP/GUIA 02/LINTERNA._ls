(defun C:LINTERNA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 25)
  (command "_UCS" "_WORLD")

  (setq center(getpoint "Ingresar punto central: "))
  (setq size (getdist "Ingresar tamaño: "))

  (command "_CYLINDER" center (* 20 size) (* 20 size))
  (setq light(entlast))

  (setq p_cyl_aux (list(+(nth 0 center)(* 20 size)(nth 1 center)(nth 2 center))))
  (command "_CYLINDER" )
  (command "_ARRAYPOLAR" )


  
 )