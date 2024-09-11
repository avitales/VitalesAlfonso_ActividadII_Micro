; Programa RAÍZ CUADRADA

; Declaro las variables de los registros a usar
	LD A, B  ; Cargo el valor de B (número en BCD) en A.
	LD C, 0  ; Inicio en 0 al registro C (que contendrá el resultado)
	LD E, 0  ; Inicio en 0 al registro R (Este será el que se compare
		 ; con el original, y fungirá como una estimación a la
		 ; raíz cuadrada)

; Subrutina que comienza el loop del programa
LOOP:
	LD D, A  ; Cargo D en A. D será útil después en el programa.
	LD A, E  ; Cargo  el valor de mi estimación en A
	ADD A, A ; Sumo lo que hay en A (en este caso, el registro R) en A.
	ADD A, E ; Sumo lo que hay en R a A. Esto me generará que A valga
		 ; 3 veces lo que hay en el estimador (A = 3R).
	LD L, A  ; Guardo el valor actual de A (3R) en este registro (L)
	LD H, 0  ; Se inicializa en 0 el registro H. Esto para evitar errores
		 ; ya que estamos utilizando el registro HL. Y según entendí, se
		 ; hace para evitar errores
	LD A, D  ; Cargo el valor D que guardé al inicio (representando mi valor
		 ; original)
	CP L	 ; Comparo lo que hay en mi registro actual (A) con lo que hay en L.
		 ; En este caso, 3R.
	JR C, END; Si el D es menor que L (3R), ejecuta END.
		 ; O lo que es lo mismo, si el flag de acarreo (C) está
		 ; encendido, termina el programa. Si D NO es menor que L,
		 ; entonces continuará con la siguiente instrucción.
	INC E
	JR LOOP  ; Este par de instrucciones incrementar mi estimación de la raíz
		 ; cuadrada, y luego repite todo el ciclo.

; Subrutina que terminará mi programa
END:
	LD C, E  ; Para terminar, guarda el valor de R en el registro C.
	RET
