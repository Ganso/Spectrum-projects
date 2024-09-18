1 REM Tower Defense ZX Spectrum 48K
   2 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos
   3 REM f-indice zombie, g-bucle mover zombies, k-tecla pulsada
   4 REM oldx,oldy-posicion anterior zombie, score-puntuacion, z-zombies
   5 REM m-mapa del juego (0=vacio, 1=ciudadano, 2=ladrillo, 3-5=torreta, 6-8=zombie)
   6 REM te-tipo de torreta, recursos-contador de recursos, tiempo-control de tiempo
   7 REM tiemporecurso-tiempo para nuevo recurso, tiempozombie-tiempo para nuevo zombie
  10 DIM m(22,32): DIM c(10,2): DIM z(10,3): LET score=0: LET level=1: LET recursos=40: LET tiempo=0: LET tiemporecurso=0: LET tiempozombie=0: LET cursorx=10: LET cursory=10
  20 BORDER 0: PAPER 0: INK 7: CLS : REM Configurar colores
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
1020 GO TO 6000: REM Ir al bucle principal
2000 REM Colocar ciudadanos
2010 CLS : INK 7: FOR b=1 TO 10
2020 LET c(b,1)=INT (RND*10)+1: LET c(b,2)=INT (RND*20)+1
2030 PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2040 LET m(c(b,2)+1,c(b,1))=1: LET m(c(b,2)+2,c(b,1))=1: REM Actualizar mapa
2050 NEXT b
2060 RETURN
3000 REM Colocar objeto (ladrillo o torreta)
3010 IF te=0 AND recursos<5 THEN RETURN
3020 IF te>0 AND recursos<20 THEN RETURN
3030 GO SUB 8600: IF ocupado=0 THEN GO SUB 3100: RETURN
3040 RETURN
3100 REM Colocar objeto en el mapa
3110 IF te=0 THEN LET recursos=recursos-5: INK 4: PRINT AT cursory,cursorx;CHR$ 146: LET m(cursory+1,cursorx)=2
3120 IF te>0 THEN LET recursos=recursos-20: INK 5: PRINT AT cursory,cursorx;CHR$ (149+te): LET m(cursory+1,cursorx)=te+2
3130 RETURN
5000 REM Generar zombie
5010 LET f=1
5020 LET z(f,1)=31: LET z(f,2)=INT (RND*20)+1: LET z(f,3)=INT (RND*3)+1
5030 LET g=f: GO SUB 8150: REM Dibujar zombie
5040 LET m(z(f,2)+1,z(f,1))=z(f,3)+5: LET m(z(f,2)+2,z(f,1))=z(f,3)+5: REM Actualizar mapa
5050 RETURN
6000 REM Bucle principal del juego
6010 GO SUB 7000: GO SUB 7100: GO SUB 7200: GO SUB 7300
6020 IF score>1000 THEN GO TO 9000: REM Ir a Fin del juego
6030 GO TO 6000: REM Volver al inicio del bucle principal
7000 REM Mover zombies
7010 FOR g=1 TO 10
7020 IF z(g,1)>1 THEN GO SUB 8400: LET oldx=z(g,1): LET oldy=z(g,2): LET m(oldy+1,oldx)=0: LET m(oldy+2,oldx)=0: LET z(g,1)=z(g,1)-1: GO SUB 8150: LET m(z(g,2)+1,z(g,1))=z(g,3)+5: LET m(z(g,2)+2,z(g,1))=z(g,3)+5: REM Actualizar mapa
7030 NEXT g
7040 RETURN
7100 REM Comprobar colisiones
7110 REM Implementar deteccion de colisiones usando el mapa m
7120 RETURN
7200 REM Actualizar puntuación, recursos y tiempo
7210 PRINT AT 0,0;"Score: ";score;" Recursos: ";recursos;" t:",tiempo
7220 LET tiempo=tiempo+1: LET tiemporecurso=tiemporecurso+1: LET tiempozombie=tiempozombie+1
7230 IF tiemporecurso=5 THEN LET recursos=recursos+1: IF recursos>100 THEN LET recursos=100: LET tiemporecurso=0
7240 IF tiempozombie=25 THEN GO SUB 5000: LET tiempozombie=0
7250 RETURN
7300 REM Controles del jugador
7310 LET k$=INKEY$
7320 IF k$="q" AND cursory>0 THEN LET cursory=cursory-1
7330 IF k$="a" AND cursory<21 THEN LET cursory=cursory+1
7340 IF k$="o" AND cursorx>0 THEN LET cursorx=cursorx-1
7350 IF k$="p" AND cursorx<31 THEN LET cursorx=cursorx+1
7360 IF k$="0" THEN LET te=0: GO SUB 3000: REM Colocar ladrillo
7370 IF k$="1" THEN LET te=1: GO SUB 3000: REM Colocar torreta tipo 1
7380 IF k$="2" THEN LET te=2: GO SUB 3000: REM Colocar torreta tipo 2
7390 IF k$="3" THEN LET te=3: GO SUB 3000: REM Colocar torreta tipo 3
7400 GO SUB 8000: REM Dibujar cursor
7410 RETURN
8000 REM Dibujar cursor
8010 FLASH 1: INK 2: PRINT AT cursory,cursorx;"+": FLASH 0
8020 RETURN
8150 REM Dibujar zombie
8160 INK z(g,3): PRINT AT z(g,2),z(g,1);CHR$ (148+z(g,3)*2-2);AT z(g,2)+1,z(g,1);CHR$ (149+z(g,3)*2-2)
8170 RETURN
8400 REM Comprobar y redibujar objeto
8410 LET cx=cursorx: LET cy=cursory: REM Guardar posición actual del cursor
8420 LET ocupante=m(cy+1,cx): REM Obtener ocupante de la celda del mapa
8430 IF ocupante=2 THEN INK 4: PRINT AT cy,cx;CHR$ 146: RETURN
8440 IF ocupante>=3 AND ocupante<=5 THEN INK 5: PRINT AT cy,cx;CHR$ (149+ocupante-3): RETURN
8520 PRINT AT cy,cx;" ": REM Si no hay objeto, imprimir espacio
8530 RETURN
8600 REM Comprobar si la celda está ocupada
8610 LET ocupado=m(cursory+1,cursorx)
8620 RETURN
9000 REM Fin del juego
9010 PRINT AT 10,10;"GAME OVER";AT 12,10;"Score: ";score;AT 14,10;"Pulsa una tecla"
9020 PAUSE 0: RUN