; Programa RAÍZ CUADRADA
; Registro de entrada:
;   B: número en BCD (de 00 a 99)
; Registro de salida:
;   C: raíz cuadrada entera en BCD

        org 000h          ; Inicio del programa

START:  ld a, b           ; Carga lo que hay en B, en A
        call BCD_2_BIN
        ld b, a           ; Guardo el binario en B
        xor a             ; Borra lo que hay en A
        ld c, a
        ld d, 1

LOOP:   ld a, d           ; Carga lo que hay en D en A
        call ROOT
        cp b              ; Compara con B
        jr c, DONE        ; Si el cuadrado de D < B, terminará el ciclo
        inc c
        inc d
        jr ROOT

DONE:   call BIN_2_BCD
        ld c, a           ; Guarda el valor de la raíz en C
        ret               ; Termina el programa

	;SUBRUTINA PARA CONVERTIR DE BCD A BINARIO
BCD_2_BIN:
        ld a, b           ; Guarda lo que hay en B (Valor en BCD) en A
        ld e, a           ; Guardar el valor original en E
        and 0Fh
        ld d, a
        ld a, e
        srl a
        srl a
        srl a
        srl a
        ld e, a           ; Guarda las decenas en E
        ld a, e           ; Multplica por 10
        add a, a          ; A = E * 2
        add a, a          ; A = E * 4
        add a, a          ; A = E * 8
        add a, e          ; A = E * 8 + E = E * 9
        add a, d          ; Sumar las unidades a A
        ret               ; Devuelve el valor binario en A

	;SUBRUTINA PARA CONVERTIR BINARIO A BCD
BIN_2_BCD:
        ld e, a           ; Guarda el valor binario en E
        ld d, 10          ; Carga 10 en D
        xor a             ; Borra lo que hay en A
DIV:
        sub d             ; Resta 10 de lo que hay en A
        jr c, CONVERT     ; Si el resultado es negativo, continúa con la conversión
        inc a             ; Incrementa el número de decenas en A
        jr DIV 	          ; REPITE EL CICLO

CONVERT:
        add a, e          ; Sumar las unidades restantes en A
        ret               ; Devuelve el valor BCD en A

	;SUBRUTINA PARA LA RAÍZ CUADRADA
ROOT:
        ld e, a           ; Guardar el valor de A (D) en E
        ld a, 0           ; Inicializar A en 0 para almacenar el resultado
        ld l, e           ; Cargar el valor de E en L para el ciclo
MUL:
        add a, e          ; Sumar E a A
        dec l             ; Decrementar L
        jr nz, MUL   ; Repetir hasta que L sea 0 (A = E * E)
        ret               ; Devuelve el cuadrado en A