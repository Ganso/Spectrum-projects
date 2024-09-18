   1 REM Tower Defense ZX Spectrum 48K
   2 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, d-bucle ladrillos
   3 REM e-bucle torretas, f-bucle zombies, g-bucle mover zombies, h-bucle comprobar ladrillos
   4 REM j-bucle comprobar torretas, k-tecla pulsada, l-ladrillos, n-bucle UDGs
   5 REM oldx,oldy-posicion anterior zombie, score-puntuacion, t-torretas, z-zombies
  10 DIM c(10,2): DIM l(20,2): DIM t(3,3): DIM z(10,3): LET score=0: LET level=1
 100 REM Definicion de UDGs
 110 FOR n=0 TO 7: READ a: POKE USR "a"+n,a: NEXT n: DATA 60,126,219,255,189,189,126,60: REM Ciudadano superior
 120 FOR n=0 TO 7: READ a: POKE USR "b"+n,a: NEXT n: DATA 60,36,36,24,60,90,129,66: REM Ciudadano inferior
 130 FOR n=0 TO 7: READ a: POKE USR "c"+n,a: NEXT n: DATA 255,219,255,219,255,219,255,219: REM Ladrillo
 140 FOR n=0 TO 7: READ a: POKE USR "d"+n,a: NEXT n: DATA 60,126,219,255,255,219,126,60: REM Zombie 1 superior
 150 FOR n=0 TO 7: READ a: POKE USR "e"+n,a: NEXT n: DATA 60,90,90,60,36,36,102,66: REM Zombie 1 inferior
 160 FOR n=0 TO 7: READ a: POKE USR "f"+n,a: NEXT n: DATA 60,126,195,255,255,195,126,60: REM Zombie 2 superior
 170 FOR n=0 TO 7: READ a: POKE USR "g"+n,a: NEXT n: DATA 60,66,66,60,36,36,102,66: REM Zombie 2 inferior
 180 FOR n=0 TO 7: READ a: POKE USR "h"+n,a: NEXT n: DATA 60,126,231,255,255,231,126,60: REM Zombie 3 superior
 190 FOR n=0 TO 7: READ a: POKE USR "i"+n,a: NEXT n: DATA 60,102,102,60,36,36,102,66: REM Zombie 3 inferior
 200 FOR n=0 TO 7: READ a: POKE USR "j"+n,a: NEXT n: DATA 24,60,126,255,255,126,60,24: REM Torreta 1
 210 FOR n=0 TO 7: READ a: POKE USR "k"+n,a: NEXT n: DATA 24,60,102,255,255,102,60,24: REM Torreta 2
 220 FOR n=0 TO 7: READ a: POKE USR "l"+n,a: NEXT n: DATA 24,60,90,255,255,90,60,24: REM Torreta 3
1000 REM Inicializacion del juego
1010 GO SUB 2000: REM Colocar ciudadanos
1020 GO SUB 3000: REM Colocar ladrillos
1030 GO SUB 4000: REM Colocar torretas
1040 GO SUB 5000: REM Generar zombies
1050 GO TO 6000: REM Ir al bucle principal
2000 REM Colocar ciudadanos
2010 CLS : INK 0: FOR b=1 TO 10
2020 LET c(b,1)=INT (RND*10)+1: LET c(b,2)=INT (RND*20)+1
2030 PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2040 NEXT b
2050 RETURN
3000 REM Colocar ladrillos
3010 INK 4: LET cursorx=10: LET cursory=10
3020 FOR d=1 TO 5
3030 PRINT AT 0,0;"Coloca ladrillo ";d
3040 GO SUB 8000: REM Dibujar cursor
3050 GO SUB 8200: REM Manejar pulsaciones de teclas
3060 IF k$=" " THEN GO SUB 8600: IF ocupado=0 THEN LET l(d,1)=cursorx: LET l(d,2)=cursory: INK 4: PRINT AT cursory,cursorx;CHR$ 146: GO TO 3080
3070 GO TO 3040
3080 NEXT d
3090 RETURN
4000 REM Colocar torretas
4010 INK 5: REM Cambiar color si es necesario
4020 LET e=1
4030 PRINT AT 0,0;"Coloca torreta ";e;"     "
4040 GO SUB 8000: REM Dibujar cursor
4050 GO SUB 8200: REM Manejar pulsaciones de teclas
4060 IF k$=" " THEN GO SUB 8600: IF ocupado=0 THEN LET t(e,1)=cursorx: LET t(e,2)=cursory: LET t(e,3)=e: GO SUB 8100: GO TO 4080
4070 GO TO 4040
4080 LET e=e+1
4085 IF e<=3 THEN GOTO 4030
4090 RETURN
5000 REM Generar zombies
5010 FOR f=1 TO 10
5020 LET z(f,1)=31: LET z(f,2)=INT (RND*20)+1: LET z(f,3)=INT (RND*3)+1
5030 GO SUB 8150: REM Dibujar zombie
5040 NEXT f
5050 RETURN
6000 REM Bucle principal del juego
6010 GO SUB 7000: GO SUB 7100: GO SUB 7200: GO SUB 7300
6020 IF score>1000 THEN GO TO 9000: REM Ir a Fin del juego
6030 GO TO 6000: REM Volver al inicio del bucle principal
7000 REM Mover zombies
7010 FOR g=1 TO 10
7020 IF z(g,1)>1 THEN GO SUB 8400: LET oldx=z(g,1): LET oldy=z(g,2): LET z(g,1)=z(g,1)-1: GO SUB 8150: REM Dibujar zombie
7030 NEXT g
7040 RETURN
7100 REM Comprobar colisiones
7110 REM Implementar deteccion de colisiones
7120 RETURN
7200 REM Actualizar puntuacion
7210 PRINT AT 0,0;"Score: ";score;"         ": RETURN
7300 REM Controles del jugador
7310 LET k$=INKEY$
7320 IF k$="q" THEN REM Mover arriba
7330 IF k$="a" THEN REM Mover abajo
7340 IF k$="o" THEN REM Mover izquierda
7350 IF k$="p" THEN REM Mover derecha
7360 IF k$=" " THEN REM Accion
7370 RETURN
8000 REM Dibujar cursor
8010 INK 2: PRINT AT cursory,cursorx;"+"
8020 RETURN
8050 REM Borrar cursor
8060 GO SUB 8400: REM Comprobar y redibujar ladrillo o torreta si es necesario
8070 RETURN
8100 REM Dibujar torreta
8110 INK t(e,3): PRINT AT t(e,2),t(e,1);CHR$ (149+t(e,3)-1)
8120 RETURN
8150 REM Dibujar zombie
8160 INK z(g,3): PRINT AT z(g,2),z(g,1);CHR$ (148+z(g,3)*2-2);AT z(g,2)+1,z(g,1);CHR$ (149+z(g,3)*2-2)
8170 RETURN
8200 REM Manejar pulsaciones de teclas
8210 LET k$=INKEY$
8220 IF k$="q" AND cursory>0 THEN GO SUB 8050: LET cursory=cursory-1
8230 IF k$="a" AND cursory<21 THEN GO SUB 8050: LET cursory=cursory+1
8240 IF k$="o" AND cursorx>0 THEN GO SUB 8050: LET cursorx=cursorx-1
8250 IF k$="p" AND cursorx<31 THEN GO SUB 8050: LET cursorx=cursorx+1
8260 RETURN
8400 REM Comprobar y redibujar ladrillo o torreta
8410 LET cx=cursorx: LET cy=cursory: REM Guardar posici\#1953n actual del cursor
8420 FOR h=1 TO 20: REM Comprobar ladrillos
8430 IF l(h,1)=cx AND l(h,2)=cy THEN INK 4: PRINT AT cy,cx;CHR$ 146: RETURN
8440 NEXT h
8450 FOR j=1 TO 3: REM Comprobar torretas
8460 IF t(j,1)=cx AND t(j,2)=cy THEN LET e=j: GO SUB 8100: RETURN
8470 NEXT j
8480 PRINT AT cy,cx;" ": REM Si no hay ladrillo ni torreta, imprimir espacio
8490 RETURN
8600 REM Comprobar si la celda est\#195\r ocupada
8610 LET ocupado=0
8620 FOR h=1 TO 20: IF l(h,1)=cursorx AND l(h,2)=cursory THEN LET ocupado=1: RETURN
8630 NEXT h
8640 FOR j=1 TO 3: IF t(j,1)=cursorx AND t(j,2)=cursory THEN LET ocupado=1: RETURN
8650 NEXT j
8660 RETURN
9000 REM Fin del juego
9010 PRINT AT 10,10;"GAME OVER";AT 12,10;"Score: ";score;AT 14,10;"Pulsa una tecla"
9020 PAUSE 0: RUN
