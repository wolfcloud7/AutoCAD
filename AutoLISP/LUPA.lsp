(defun C:LUPA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 20)
  (command "_UCS" "WORLD")

;PUNTOS
  (setq center (getpoint "Ingrese el punto central: "))
  (setq size (getdist "Ingrese el tamaño: "))
  
;MANIJA INFERIOR
  (command "_LAYER" "_M" "MANIJA" "_C" 5 "" "")
  (command "_LAYER" "_S" "MANIJA" "")
  
 ;CILINDRO PRINCIPAL
  (command "_CYLINDER" center (* 5 size) (* 25 size))
  (setq inferior_handle(entlast))

 ;CILINDROS AUXILIARES (ARRAY)
  (setq c_cyl_aux_1 (list(+(nth 0 center)(* 5 size))(nth 1 center)(nth 2 center)))
  
  (command "_CYLINDER" c_cyl_aux_1 size (* 25 size))
  (setq cyl_aux_1(entlast))
  
  (command "_ARRAYPOLAR" cyl_aux_1 "" center "_I" 10 "" "_EXIT" "")
  (setq cyl_aux_2(entlast))
  (command "_EXPLODE" cyl_aux_2)

  (setq cyl_aux_3(ssget "_P"))
  (command "_SUBTRACT" inferior_handle "" cyl_aux_3 "")

;MANIJA SUPERIOR
  (setq center_aux_1 (list(nth 0 center) (nth 1 center) (+(nth 2 center)(* 25 size))))
  (command "_CYLINDER" center_aux_1 (* 5 size) (* 15 size))

;CUELLO
  (setq center_aux_2 (list(nth 0 center_aux_1) (nth 1 center_aux_1) (+(nth 2 center_aux_1)(* 15 size))))
  (command "_CYLINDER" center_aux_2 (* 2 size) (* 10 size))

;LENTE
  (command "_LAYER" "_M" "LENTE" "_C" 4 "" "")
  (command "_LAYER" "_S" "LENTE" "")
  
  (command "_UCS" "_X" 90)
  (setq center_len (list(nth 0 center_aux_1)(+(nth 1 center_aux_1)(* 75 size))(* -5 size)))
  (command "_CYLINDER" center_len (* 25 size) (* 10 size))
  (setq lens(entlast))

;CILINDROS AUXILIARES SUBTRACT
  (setq c_cyl_aux_2 (list(nth 0 center_len)(nth 1 center_len)(+(nth 2 center_len)(* -1 size))))
  (command "_CYLINDER" c_cyl_aux_2 (* 23 size) (* 5 size))
  (setq cyl_aux_4(entlast))
  
  (setq c_cyl_aux_3 (list(nth 0 center_len)(nth 1 center_len)(+(nth 2 center_len)(* 6 size))))
  (command "_CYLINDER" c_cyl_aux_3 (* 23 size) (* 5 size))
  (setq cyl_aux_5(entlast))
  
;SUBTRACT
  (command "_SUBTRACT" lens "" cyl_aux_4 cyl_aux_5 "")	

;UCS WORLD
  (command "_UCS" "WORLD")
 (princ) 
 )