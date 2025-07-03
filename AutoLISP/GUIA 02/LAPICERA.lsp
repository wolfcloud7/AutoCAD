(defun C:LAPICERA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 25)
  (command "_UCS" "_WORLD")

;PUNTOS
  (setq center(getpoint "Ingresar punto central: "))
  (setq size(getdist "Ingresar tamaño: "))

;PUNTA LAPICERA
  (command "_LAYER" "_C" 5 "0" "")
  (command "_LAYER" "_S" "0" "")
  
  (setq c_cone (list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 13 size))))
  (command "_CONE" c_cone (* 3.5 size) (* -13 size))

;GOMA DE AGARRE
  (command "_LAYER" "_M" "AGARRADERA" "_C" 6 "" "")
  (command "_LAYER" "_S" "AGARRADERA" "")
  
  (command "_CYLINDER" c_cone (* 4 size) (* 30 size))
  (setq cyl_1(entlast))
  
  (setq c_cyl_aux_1(list(+(nth 0 c_cone)(* 4 size))(nth 1 c_cone)(nth 2 c_cone)))
  (command "_CYLINDER" c_cyl_aux_1 (* 0.5 size) (* 30 size))

  (setq cyl_aux_1(entlast))
  (command "_ARRAYPOLAR" cyl_aux_1 "" center "_I" 10 "" "_EXIT" "")

  (setq cyl_aux_2(entlast))
  (command "_EXPLODE" cyl_aux_2)

  (setq cyl_aux_3(ssget "_P"))
  (command "_SUBTRACT" cyl_1 "" cyl_aux_3 "")

;CUERPO
  (command "_LAYER" "_S" "0" "")
  
  (setq c_body(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 33 size))))
  (command "_CYLINDER" c_body (* 3.3 size) (* 48 size))
  
;BOTON
  (setq c_button(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 81 size))))
  (command "_CYLINDER" c_button (* 2 size) (* 7 size))
  
  (setq c_sph(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 88 size))))
  (command "_SPHERE" c_sph (* 2 size))

;MANIJA
  (setq corner_handle_1(list(+(nth 0 center)size)(-(nth 1 center)size)(+(nth 2 center)(* 81 size))))
  (setq corner_handle_2(list(+(nth 0 center)(* 5 size))(+(nth 1 center)size)(+(nth 2 center)(* 80 size))))
  (command "_BOX" corner_handle_1 corner_handle_2)

  (setq corner_handle_3(list(+(nth 0 center)(* 4 size))(-(nth 1 center)size)(+(nth 2 center)(* 81 size))))
  (setq corner_handle_4(list(+(nth 0 center)(* 5 size))(+(nth 1 center)size)(+(nth 2 center)(* 60 size))))
  (command "_BOX" corner_handle_3 corner_handle_4)
 
(princ)
 )