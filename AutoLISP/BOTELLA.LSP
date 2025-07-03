(defun C:BOTELLA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 20)

;PUNTOS
  (setq center(getpoint "Ingrese el punto central: "))
  (setq radius(getdist "Ingrese el radio: "))
  (setq height(getdist "Ingrese la altura: "))

;CUERPO
  (command "_LAYER" "_M" "CUERPO" "_C" 1 "" "")
  (command "_LAYER" "_S" "CUERPO" "")  
  (command "_CYLINDER" center (* 40 radius) (* 100 height))
  (setq body(entlast))

;CUELLO
  (command "_LAYER" "_M" "CUELLO" "_C" 2 "" "")
  (command "_LAYER" "_S" "CUELLO" "")
  (setq n_center(list(nth 0 center)(nth 1 center)(+(nth 2 center)(* 100 height))))
  (command "_CYLINDER" n_center (* 25 radius) (* 20 height))

;TAPA
  (command "_LAYER" "_M" "TAPA" "_C" 3 "" "")
  (command "_LAYER" "_S" "TAPA" "")
  (setq c_center(list(nth 0 n_center)(nth 1 n_center)(+(nth 2 n_center)(* 20 height))))
  (command "_CYLINDER" c_center (* 35 radius) (* 25 height))
  (setq cap(entlast))

;MANIJA
  (setq h_corner(list(nth 0 c_center)(- (nth 1 c_center) 2.5)(nth 2 c_center)))
  (command "_BOX" h_corner (list (+ (nth 0 h_corner) (+ 10 (* 40 radius))) (+ (nth 1 h_corner) 5) (nth 2 h_corner))(* 25 height))
  (setq handle(entlast))
  
;SUBTRACT
  (setq p_aux_1(list(nth 0 c_center)(nth 1 c_center)(+(nth 2 c_center)(* 20 height))))
  (command "_CYLINDER" p_aux_1 (* 32 radius) (* 10 height))
  (setq c_aux_1(entlast))
  (command "_SUBTRACT" cap handle "" c_aux_1 "")

  (princ)
  )

