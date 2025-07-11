(defun c:FIGGEOM (/ opcion lado base altura radio centro)
  (princ "\nMen�:")
  (princ "\n1. Tri�ngulo equil�tero")
  (princ "\n2. Cuadrado")
  (princ "\n3. Rect�ngulo")
  (princ "\n4. Pent�gono")
  (princ "\n5. Hex�gono")
  
  (initget 1 "1 2 3 4 5")
  (setq opcion (getkword "\nSeleccione una opci�n: "))
  
  (cond
    ;Tri�ngulo equil�tero
    ((= opcion "1")
     (setq centro (getpoint "\nCentro del tri�ngulo: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 3 centro "I" (/ lado (* 2 (sin (/ pi 3)))) ;F�rmula para radio circunscrito
    )
    
    ;Cuadrado
    ((= opcion "2")
     (setq centro (getpoint "\nCentro del cuadrado: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 4 centro "I" (/ lado (sqrt 2))) ;Radio = lado/sqrt(2)
    )
    
    ;Rect�ngulo
    ((= opcion "3")
     (setq p1 (getpoint "\nEsquina inferior izquierda: ")
           base (getdist p1 "\nBase: ")
           altura (getdist p1 "\nAltura: "))
     (command "_RECTANG" "_non" p1 "_non" (list (+ (car p1) base) (+ (cadr p1) altura)))
    )
    
    ;Pent�gono
    ((= opcion "4")
     (setq centro (getpoint "\nCentro del pent�gono: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 5 centro "I" (/ lado (* 2 (sin (/ pi 5))))) ;Radio circunscrito
    )
    
    ;Hex�gono
    ((= opcion "5")
     (setq centro (getpoint "\nCentro del hex�gono: ")
           lado (getdist centro "\nLongitud del lado: "))
     (command "_POLYGON" 6 centro "I" lado) ;Radio = lado en hex�gono
    )
  )
  (princ)