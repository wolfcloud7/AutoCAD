(defun c:ZMENU (/ opcion)
  (princ "\nOpciones de Zoom: [ZA]ll / [ZE]xtents (80%) / [ZW]indow / [ZP]revious")
  (setq opcion (getstring "\nElige una opción (ZA/ZE/ZW/ZP): "))
  (cond
    ((= (strcase opcion) "ZA") (command "._ZOOM" "_A"))     ; Zoom All
    ((= (strcase opcion) "ZE") (command "._ZOOM" "_E" "0.8X")) ; Zoom Extents al 80%
    ((= (strcase opcion) "ZW") (command "._ZOOM" "_W"))     ; Zoom Window
    ((= (strcase opcion) "ZP") (command "._ZOOM" "_P"))     ; Zoom Previous
    )
)