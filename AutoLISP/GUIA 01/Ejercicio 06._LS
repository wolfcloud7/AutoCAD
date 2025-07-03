(defun c:FIGGEOM (/ opcion lado base altura radio centro)
  (princ "\nMenú:")
  (princ "\n1. Triángulo equilátero")
  (princ "\n2. Cuadrado")
  (princ "\n3. Rectángulo")
  (princ "\n4. Pentágono")
  (princ "\n5. Hexágono")
  
  (initget 1 "1 2 3 4 5")
  (setq opcion (getkword "\nSeleccione una opción: "))
  
  (cond
    ;Triángulo equilátero
    ((= opcion "1")
     (setq centro (getpoint "\nCentro del triángulo: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 3 centro "I" (/ lado (* 2 (sin (/ pi 3)))) ;Fórmula para radio circunscrito
    )
    
    ;Cuadrado
    ((= opcion "2")
     (setq centro (getpoint "\nCentro del cuadrado: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 4 centro "I" (/ lado (sqrt 2))) ;Radio = lado/sqrt(2)
    )
    
    ;Rectángulo
    ((= opcion "3")
     (setq p1 (getpoint "\nEsquina inferior izquierda: ")
           base (getdist p1 "\nBase: ")
           altura (getdist p1 "\nAltura: "))
     (command "_RECTANG" "_non" p1 "_non" (list (+ (car p1) base) (+ (cadr p1) altura)))
    )
    
    ;Pentágono
    ((= opcion "4")
     (setq centro (getpoint "\nCentro del pentágono: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 5 centro "I" (/ lado (* 2 (sin (/ pi 5))))) ;Radio circunscrito
    )
    
    ;Hexágono
    ((= opcion "5")
     (setq centro (getpoint "\nCentro del hexágono: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 6 centro "I" lado) ;Radio = lado en hexágono
    )
  )
  (princ)