(defun C:LINTERNA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 25)
  (command "_UCS" "_WORLD")

;PUNTOS
  (setq center(getpoint "Ingresar punto central: "))
  (setq size (getdist "Ingresar tamaño: "))

;CABEZA
  (command "_LAYER" "_M" "CABEZA" "_C" 5 "" "")
  (command "_LAYER" "_S" "CABEZA" "")
  (command "_CYLINDER" center (* 20 size) (* 20 size))
  (setq light_aux_1(entlast))
  
  (setq p_sph_aux_1(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 20 size))))
  (command "_SPHERE" p_sph_aux_1 (* 20 size))

  (setq head(entlast))
  (command "_SUBTRACT" head "" light_aux_1 "")

;LUZ (ARRAYPOLAR)
  (command "_LAYER" "_M" "LUZ" "_C" 4 "" "")
  (command "_LAYER" "_S" "LUZ" "")

  (command "_CYLINDER" center (* 20 size) (* 20 size))
  (setq light(entlast))

  (setq p_cyl_aux_1 (list(+(nth 0 center)(* 20 size))(nth 1 center)(nth 2 center)))
  (command "_CYLINDER" p_cyl_aux_1 (* 3 size) (* 20 size))
  (setq cyl_aux_1(entlast))

  (command "_ARRAYPOLAR" cyl_aux_1 "" center "_I" 15 "" "_EXIT" "")
  (setq cyl_aux_2(entlast))

  (command "_EXPLODE" cyl_aux_2)
  (setq cyl_aux_3(ssget "_P"))
 
  (command "_SUBTRACT" light "" cyl_aux_3 "")

;MANGO
  (command "_LAYER" "_M" "MANGO" "_C" 6 "" "")
  (command "_LAYER" "_S" "MANGO" "")
  
  (command "_CYLINDER" center (* 10 size) (* 80 size))
  (setq handle(entlast))
  (setq c_sph_aux_1(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 80 size))))
  (command "_SPHERE" c_sph_aux_1 (* 10 size))

;COLA DEL MANGO
  (setq c_cyl_aux_1(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 80 size))))
  (command "_CYLINDER" c_cyl_aux_1 (* 2 size)(* 18 size))
  
  (setq c_sph_aux_2(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 98 size))))
  (command "_SPHERE" c_sph_aux_2 (* 2 size))

;MANIJA
  (setq handle_box_superior(list(+(nth 0 center)(* 5 size))(-(nth 1 center)(* 2.5 size))(+(nth 2 center)(* 75 size))))
  (command "_BOX" handle_box_superior (list(+(nth 0 handle_box_superior)(+ 10 (* 2 size)))(+ (nth 1 handle_box_superior)5)(nth 2 handle_box_superior)) (* 2 size))

  (setq handle_box_inferior(list(+(nth 0 center)(* 14 size))(-(nth 1 center)(* 2.5 size))(+(nth 2 center)(* 55 size))))
  (command "_BOX" handle_box_inferior (list(+(nth 0 handle_box_inferior)(* 3 size))(+ (nth 1 handle_box_inferior)5)(nth 2 handle_box_inferior)) (* 20 size))
  
  (princ)
 )