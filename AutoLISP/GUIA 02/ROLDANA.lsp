(defun C:ROLDANA()
  (command "_OSMODE" 0)
  (command "_ISOLINES" 20)
  (command "_UCS" "_WORLD")

  (setq BASE (getpoint "vertice inferior izquierdo: "))
  (setq DIAM (getdist "Diámetro: "))

; PUNTOS
  (setq P1 (list (+ (nth 0 BASE)(* 0.2 DIAM))(+ (nth 1 BASE) (* 0.2 DIAM))(nth 2 BASE)))

;CUERPO
  (command "_LAYER" "_M" "CUERPO" "_C" "5" "CUERPO" "")
  (command "_LAYER" "_S" "CUERPO" "")
  
  ;CILINDROS BASE
  (command "_CYLINDER" P1 (* 0.2 DIAM) (* 0.1 DIAM))
  (setq CYL0 (entlast))
  (command "_ARRAYRECT" CYL0 "" (list (* 0.5 DIAM) 0) (list (* 0.5 DIAM) 0) "_R" 2 (* 0.6 DIAM) 0 "_C" 2 (* 1.1 DIAM) "_EXIT")
  (setq CYL1 (entlast))
  (command "_EXPLODE" CYL1)
  (setq CYLAR (ssget "_P"))

  ;CAJAS
  (setq P2 (list (+ (nth 0 BASE) (* 0.2 DIAM)) (nth 1 BASE) (nth 2 BASE)))
  (setq P3 (list (+ (nth 0 P2) (* 1.1 DIAM)) (+ (nth 1 P2) DIAM) (+ (nth 2 P2) (* 0.1 DIAM))))
  (setq P4 (list (nth 0 BASE) (+ (nth 1 BASE) (* 0.2 DIAM)) (nth 2 BASE)))
  (setq P5 (list (+ (nth 0 P4) (* 1.5 DIAM)) (+ (nth 1 P4) (* 0.6 DIAM)) (+ (nth 2 P4) (* 0.1 DIAM))))

  ;UNION
  (command "_BOX" P2 P3)
  (setq BOX1 (entlast))
  (command "_BOX" P4 P5)
  (setq BOX2 (entlast))
  (command "_UNION" CYLAR BOX1 BOX2 "")
  (setq CUERPO1 (entlast))

  ;AGUJEROS
  (command "_CYLINDER" P1 (* 0.04 DIAM) (* 0.1 DIAM))
  (setq CYL2 (entlast))
  (setq P6 (list (nth 0 P1) (nth 1 P1) (+ (nth 2 P1) (* 0.1 DIAM))))
  (command "_CONE" P6 (* 0.08 DIAM) (* -0.1 DIAM))
  (setq CONO (entlast))
  (command "_UNION" CYL2 CONO "")
  (setq AGUJERO (entlast))

  ;ARRAY
  (command "_ARRAYRECT" AGUJERO "" (list (* 0.5 DIAM) 0) (list (* 0.5 DIAM) 0) "_R" 2 (* 0.6 DIAM) 0 "_C" 2 (* 1.1 DIAM) "_EXIT")
  (setq AR (entlast))
  (command "_EXPLODE" AR)
  (setq AGUJERITOS (ssget "_P"))
  (command "_SUBTRACT" CUERPO1 "" AGUJERITOS "")
  (setq CUERPO2 (entlast))

  ;CUERPO MEDIO
  (setq P7 (list (+ (nth 0 BASE) (* 0.5 DIAM)) (+ (nth 1 BASE) (* 0.2 DIAM)) (+ (nth 2 BASE) (* 0.1 DIAM))))
  (setq P8 (list (+ (nth 0 P7) (* 0.5 DIAM)) (+ (nth 1 P7) (* 0.6 DIAM)) (+ (nth 2 P7) DIAM)))
  (command "_BOX" P7 P8)
  (setq BOX3 (entlast))
  
  (setq P9 (list (+ (nth 0 BASE) (* 0.5 DIAM)) (nth 1 BASE) (nth 2 BASE)))
  (setq P10 (list (+ (nth 0 P9) (* 0.5 DIAM)) (+ (nth 1 P9) DIAM) (+ (nth 2 P9) (* 0.9 DIAM))))
  (command "_BOX" P9 P10)
  (setq BOX4 (entlast))

  (setq P9 (list (+ (nth 0 BASE) (* 0.6 DIAM)) (nth 1 BASE) (+ (nth 2 BASE) (* 0.1 DIAM))))
  (setq P10 (list (+ (nth 0 P9) (* 0.3 DIAM)) (+ (nth 1 P9) DIAM) (+ (nth 2 P9) DIAM)))
  (command "_BOX" P9 P10)
  (setq BOX5 (entlast))
  
  ;UCS
  (command "_UCS" "_ZA" BASE (list (+ (nth 0 BASE) (* 0.7 DIAM)) (nth 1 BASE) (nth 2 BASE)))
  (setq P11 (list (+ 0 (* 0.2 DIAM)) (+ 0 (* 0.9 DIAM)) (+ 0 (* 0.5 DIAM))))
  (command "_CYLINDER" P11 (* 0.2 DIAM) (* 0.5 DIAM))
  (setq CYL3 (entlast))
  (command "_CYLINDER" (list (+ (nth 0 P11) (* 0.6 DIAM)) (nth 1 P11) (nth 2 P11)) (* 0.2 DIAM) (* 0.5 DIAM))
  (setq CYL4 (entlast))

  ;UNION FINAL
  (command "_UNION" CYL3 CYL4 BOX3 BOX4 CUERPO2 "")
  (setq AUX (entlast))
  (command "_SUBTRACT" AUX "" BOX5 "")
  (setq CUERPO3 (entlast))

  ;AGUJERO FINAL
  (setq P11 (list (+ 0 (* 0.5 DIAM)) (+ 0 (* 0.85 DIAM)) (+ 0 (* 0.5 DIAM))))
  (command "_CYLINDER" P11 (* 0.1 DIAM) (* 0.5 DIAM))
  (setq CYL5 (entlast))
  (command "_SUBTRACT" CUERPO3 "" CYL5 "")
  (setq CUERPO4 (entlast))

  ;CAPA 0
  (command "_LAYER" "_S" "0" "")
  (command "_CYLINDER" P11 (* 0.1 DIAM) (* 0.5 DIAM))
  (setq CYL5 (entlast))

;ROLDANA
  (command "_LAYER" "_M" "CILINDRO" "_C" "1" "CILINDRO" "")
  (command "_LAYER" "_S" "CILINDRO" "")
  (setq P12 (list (nth 0 P11) (nth 1 P11) (+ (nth 2 P11) (* 0.1 DIAM))))
  (setq P13 (list (nth 0 P12) (nth 1 P12) (+ (nth 2 P12) (* 0.3 DIAM))))
  (command "_CYLINDER" P12 (* 0.2 DIAM) (* 0.03 DIAM))
  (setq CYL6 (entlast))
  (command "_CYLINDER" P13 (* 0.2 DIAM) (* -0.03 DIAM))
  (setq CYL7 (entlast))

  (command "_CYLINDER" (list (nth 0 P12) (nth 1 P12) (+ (nth 2 P12) (* 0.03 DIAM))) (* 0.5 DIAM) (* 0.24 DIAM))
  (setq CYL8 (entlast))
  (command "_TORUS" (list (nth 0 P11) (nth 1 P11) (+ (nth 2 P11) (* 0.25 DIAM))) (* 0.5 DIAM) (* 0.1 DIAM))
  (setq TOR (entlast))
  (command "_SUBTRACT" CYL8 "" TOR "")
  (setq ROLINT (entlast))
  (command "_UNION" ROLINT CYL6 CYL7 "")
  (setq ROL (entlast))

; SUBTRACT
  (command "_LAYER" "_S" "0" "")
  (command "_SUBTRACT" ROL "" CYL5 "")
  (setq ROLAND (entlast))
  (command "_CYLINDER" P11 (* 0.1 DIAM) (* 0.5 DIAM))

  (command "_UCS" "_WORLD")
  
  (princ)
)