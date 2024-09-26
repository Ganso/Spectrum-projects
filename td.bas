   1 CLEAR 65367: DIM m(23,32): DIM c(10,3): DIM z(10,6): DIM l(20,3): DIM t(10,6): LET r=20: LET cx=7: LET cy=10: LET tiempo=0
   2 LET te=0: LET k$="": LET ox=0: LET oy=0: LET o=0: LET nz=0: LET nl=0: LET nt=0: LET nc=0: LET tir=0: LET tiz=0: LET tit=0: LET cm=0: LET cc=0: LET w=0: LET x=0: LET y=0: LET z=0: LET sp=0
   3 LET maxc=5: LET maxz=10: LET tv=3: LET lv=3: LET rcl=2: LET rct=10: LET nivel=1: LET maxtiempo=60
  10 BORDER 7: PAPER 0: INK 7: CLS
  15 PAPER 7: INK 0: PRINT AT 10,7;"  INICIALIZANDO  ": GO SUB 1100
  20 GO SUB 9500:GO SUB 9600: GO SUB 9060:  REM Definir UDG
  25 RANDOMIZE 0: GO SUB 1000: GO SUB 2000: GO SUB 2050: GO SUB 8700: GO TO 6000
1000 REM Inicializar pantalla
1005 INK 5
1010 FOR y=0 TO 21
1020 PAPER 5: PRINT AT y,0;"      "
1030 PAPER 0: PRINT AT y,6;CHR$ 160
1060 NEXT y
1070 PAPER 7: INK 0: FLASH 1: PRINT AT 10,7;"   PULSA UNA TECLA   ": FLASH 0: PAUSE 0
1075 PAPER 0: INK 7: PRINT AT 10,7;"                     "
1080 FOR y=2 TO 7: PRINT AT y,7;"                       ": NEXT y
1090 RETURN
1100 REM Mostrar informacion del nivel
1110 PAPER 1: INK 7
1120 PRINT AT 2,7;"NIVEL ";nivel;"                "
1130 PRINT AT 3,7;"CIUDADANOS: ";maxc;"          "
1140 PRINT AT 4,7;"ZOMBIES: ";maxz;"            "
1180 PRINT AT 6,7;"PRECIOS: ";
1190 IF rcl=2 THEN PRINT "BAJOS         "
1200 IF rcl=4 THEN PRINT "ALTOS         "
1210 PRINT AT 7,7;"TIEMPO A AGUANTAR: ";maxtiempo;"  "
1220 PAPER 0: RETURN
2000 REM Colocar ciudadanos inicialmente
2001 FOR b=1 TO maxc
2002 LET c(b,1)=INT (RND*5)+1: LET c(b,2)=INT (RND*19)+1: LET c(b,3)=5
2010 IF m(c(b,2)+1,c(b,1))>0 OR m(c(b,2)+2,c(b,1))>0 THEN GO TO 2002
2020 PAPER 5: INK 0: PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2)+1,c(b,1))=b*2-1: LET m(c(b,2)+2,c(b,1))=b*2: LET nc=nc+1: NEXT b: RETURN
2050 REM Colocar ladrillos inicialmente
2051 LET nl=0
2052 FOR b=1 TO 10
2053 LET l(b,1)=INT (RND*3)+8: LET l(b,2)=INT (RND*20)+1: LET l(b,3)=3
2054 IF m(l(b,2)+1,l(b,1))>0 THEN GO TO 2053
2055 PAPER 0: INK 6: BRIGHT 1: PRINT AT l(b,2),l(b,1);CHR$ 146: BRIGHT 0
2056 LET m(l(b,2)+1,l(b,1))=20+b: LET nl=nl+1
2057 NEXT b
2058 RETURN
3000 REM Comprobar si podemos colocar objeto
3010 IF (te=0 AND r<rcl) OR (te>0 AND r<rct) THEN RETURN
3020 GO SUB 8600: IF o=0 THEN GO SUB 3100
3030 RETURN
3100 REM Colocar objeto en el mapa
3110 IF te=0 AND nl<20 THEN LET r=r-rcl: INK 6: BRIGHT 1: PRINT AT cy,cx;CHR$ 146: BRIGHT 0: LET m(cy+1,cx)=20+nl+1: LET nl=nl+1: LET l(nl,1)=cx: LET l(nl,2)=cy: LET l(nl,3)=lv
3120 IF te>0 AND nt<10 AND oy<20 THEN GO SUB 3200: IF o=0 THEN GO SUB 3300
3130 GO SUB 7240: BEEP 0.1,50: RETURN
3200 REM Comprobar si las celdas adyacentes estan libres para colocar torreta
3210 LET o=0: IF cx+1>31 OR cy+1>21 THEN LET o=1: RETURN
3220 IF m(cy+1,cx)>0 OR m(cy+1,cx+1)>0 OR m(cy+2,cx)>0 OR m(cy+2,cx+1)>0 THEN LET o=1
3230 RETURN
3300 REM Colocar torreta
3310 LET m(cy+1,cx)=40+(nt*4)+1: LET m(cy+2,cx)=40+(nt*4)+2: LET m(cy+1,cx+1)=40+(nt*4)+3: LET m(cy+2,cx+1)=40+(nt*4)+4
3320 LET r=r-rct: LET nt=nt+1: LET j=nt: LET t(nt,1)=cx: LET t(nt,2)=cy: LET t(nt,3)=te: LET t(nt,4)=tv: LET t(nt,5)=0: LET t(nt,6)=8: REM Inicializa torreta con vida tv y 8 usos
3330 POKE 23675,176: POKE 23676,254
3331 LET i=(t(j,3)-1)*4
3332 INK j: PRINT AT t(j,2),t(j,1);CHR$ (144+i);CHR$ (145+i);AT t(j,2)+1,t(j,1);CHR$ (146+i);CHR$ (147+i)
3333 POKE 23675,88: POKE 23676,255
3340 RETURN
5000 REM Generar zombie
5010 IF nz>=maxz THEN RETURN
5020 LET nz=nz+1: LET z(nz,1)=31: LET z(nz,2)=INT (RND*19)+1: LET z(nz,3)=INT (RND*3)+1: LET z(nz,4)=0: LET z(nz,5)=0: LET z(nz,6)=1+(3*(z(nz,3)=2))+(3*(z(nz,3)=3))
5030 IF m(z(nz,2)+1,z(nz,1))>0 OR m(z(nz,2)+2,z(nz,1))>0 THEN LET nz=nz-1: RETURN
5040 LET g=nz: GO SUB 8150: LET m(z(nz,2)+1,z(nz,1))=80+(nz*2)-1: LET m(z(nz,2)+2,z(nz,1))=80+(nz*2)
5050 BEEP 0.1,20: RETURN
6000 REM Bucle principal del juego
6010 IF cm=0 THEN GO SUB 7000: GO SUB 7200: GO SUB 7500
6030 GO SUB 7300
6040 GO TO 6000
7000 REM Mover zombies
7010 FOR g=1 TO nz
7011 IF INKEY$=" " THEN LET sp=1
7012 IF z(g,1)=1 THEN GO TO 7050: REM Si ya esta a la izquierda no hace nada
7013 IF m(z(g,2)+1,z(g,1)-1)>0 OR m(z(g,2)+2,z(g,1)-1)>0 THEN GO TO 7040: REM Si hay un objeto a la izquierda, va la deteccion de colisiones en vez de intentar mover
7020 IF z(g,3)=2 THEN GO TO 7030: REM Los zombies rapidos mueven cada turno
7021 LET z(g,4)=z(g,4)+2
7022 IF z(g,3)<>3 THEN LET z(g,4)=z(g,4)+2: REM Suma 2 a los lentos, 4 a los normales
7023 IF z(g,4)<8 THEN GO TO 7050: REM Si no toca turno, pasa al siguiente
7030 IF z(g,1)=1 THEN LET z(g,6)=-1: GO TO 7050: REM Si esta la izquierda, lo hace invencible
7032 LET ox=z(g,1): LET oy=z(g,2): LET m(oy+1,ox)=0: LET m(oy+2,ox)=0: REM Vacia en el mapa la casilla actual
7033 GO SUB 8400: LET oy=oy+1: GO SUB 8400: REM Repinta las casillas actuales
7034 LET z(g,1)=z(g,1)-1:LET z(g,4)=0: REM Decrementa la X y resetea el contador de movimiento
7036 GO SUB 8170: GO SUB 8150: PRINT AT z(g,2),z(g,1)+1;" ";AT z(g,2)+1,z(g,1)+1;" ":BEEP 0.1,5: LET m(z(g,2)+1,z(g,1))=80+(g*2)-1: LET m(z(g,2)+2,z(g,1))=80+(g*2): REM Dibuja de nuevo el zombie y da un pitido
7037 GO TO 7050: REM Salta al NEXT
7040 GO SUB 7100: GO TO 7050: REM Procesa colisiones
7050 NEXT g: REM Siguiente zombie
7060 RETURN
7100 REM Zombie encuentra objeto
7110 LET col=7: LET matado=0: LET ob=m(z(g,2)+1,z(g,1)-1): IF ob=0 OR ob>80 THEN LET ob=m(z(g,2)+2,z(g,1)-1): REM ob = objeto colisionado
7115 IF ob=0 OR ob>80 THEN RETURN : REM No colisiona con otros zombies
7120 IF ob<=20 THEN LET t=INT ((ob+1)/2): LET c(t,3)=c(t,3)-1: LET col=0: GO TO 7150: REM Ciudadano
7130 IF ob<=40 THEN LET t=ob-20: LET l(t,3)=l(t,3)-1: LET col=4: GO TO 7150: REM Ladrillo
7140 IF ob<=80 THEN LET t=INT ((ob-41)/4)+1: LET t(t,4)=t(t,4)-1: LET col=t(t,3): GO TO 7150: REM Torreta
7150 FLASH 1: OVER 1: INK z(g,3): PAPER 0: PRINT AT z(g,2),z(g,1);" ";AT z(g,2)+1,z(g,1);" ": FLASH 0: OVER 0: REM Indica el zombie con un flash
7155 FOR w=1 TO 10: BORDER z(g,3): BEEP 0.01,50: BORDER col: BEEP 0.01,60: NEXT w: BORDER 7: REM Animacion de "pelea"
7156 IF (ob<=20) THEN IF c(t,3)<=0 THEN LET matado=1: LET c(t,3)=0: REM Asegura que la vida no sea negativa
7157 IF (ob>20 AND ob<=40) THEN IF l(t,3)<=0 THEN LET matado=1: LET l(t,3)=0: REM Asegura que la vida no sea negativa
7158 IF (ob>40 AND ob<=80) THEN IF t(t,4)<=0 THEN LET matado=1: LET t(t,4)=0: REM Asegura que la vida no sea negativa
7160 IF matado=1 THEN GO SUB 7600: REM Elimina objeto si ya no tiene vida
7165 FLASH 0: OVER 1: INK z(g,3): PRINT AT z(g,2),z(g,1);" ";AT z(g,2)+1,z(g,1);" ": OVER 0: REM Quita el flash
7170 RETURN
7200 REM Actualizar puntuacion, recursos y tiempo
7201 LET tiempo=tiempo+1
7205 IF INKEY$=" " THEN LET sp=1
7210 IF tir>=2 THEN LET r=r+1: LET tir=0: IF r>100 THEN LET r=100: REM cada 2 ticks suben los recursos
7220 IF tiz>=20 THEN LET tiz=0: GO SUB 5000: RETURN : REM cada 20 ticks sale un zombie
7230 IF tit>=6 THEN LET tit=0: GO SUB 7500: RETURN : REM cada 6 ticks las torretas intentan disparar
7240 INK 0: PAPER 7: PRINT #0;AT 0,9;r;AT 0,15;"Tiempo:";tiempo: PAPER 0: LET tir=tir+1: LET tiz=tiz+1: LET tit=tit+1
7250 FOR i=1 TO nt: LET t(i,5)=t(i,5)+1: NEXT i: RETURN
7300 REM Controles del jugador
7305 LET k$=INKEY$: IF k$="" AND sp=0 THEN RETURN
7320 IF k$=" " OR sp=1 THEN IF cm=0 THEN LET cm=1: LET cc=0: LET sp=0: GO SUB 8000: RETURN
7330 IF cm=0 THEN RETURN
7331 REM Modo de construccion
7332 LET k$=INKEY$
7334 BORDER INT (RND*6): LET cc=cc+1: IF cc=100 THEN GO SUB 8050: LET cm=0: LET cc=0: BORDER 7: RETURN
7335 PRINT #0;AT 0,0; PAPER 2; INK 7;"CONSTRUCION"; PAPER 7; INK 0;" - R: ";r;"   ";CHR$ (146);"=2, "+CHR$ (157)+"=20"; PAPER 0; INK 7;
7350 LET ox=cx: LET oy=cy
7351 IF k$=" " THEN IF cc>5 THEN GO SUB 8050: LET cm=0: LET cc=0: LET sp=0: PRINT #0;AT 0,0; PAPER 7; INK 0;"Recursos:                       "; PAPER 0; INK 7: PRINT AT oy,ox;" ": GO SUB 8400: BORDER 7: RETURN : REM Salida del modo de construccion
7360 IF k$="q" AND cy>0 THEN LET cy=cy-1
7370 IF k$="a" AND cy<20 THEN LET cy=cy+1
7380 IF k$="o" AND cx>1 THEN LET cx=cx-1
7390 IF k$="p" AND cx<30 THEN LET cx=cx+1
7400 IF k$>="0" AND k$<="3" THEN LET te=VAL k$: GO SUB 3000
7410 IF ox<>cx OR oy<>cy THEN GO SUB 8050: GO SUB 8400: GO SUB 8000: LET ox=cx: LET oy=cy: REM Si hemos movido el cursor, redibuja
7420 GO TO 7331
7500 REM Torretas disparan
7510 FOR i=1 TO nt
7515 IF INKEY$=" " THEN LET sp=1
7520 IF t(i,5)<10 OR t(i,4)<=0 THEN GO TO 7590: REM Las torretas disparan cada 10 ticks y si tienen vida > 0
7530 LET t(i,5)=0: LET tx=t(i,1)+1: LET ty=t(i,2)+1
7540 FOR j=1 TO nz
7541 IF INKEY$=" " THEN LET sp=1
7550 IF z(j,3)=t(i,3) AND z(j,6)>0 THEN GO SUB 7700: REM Solo dispara a zombies no invencibles
7560 NEXT j
7590 NEXT i
7592 RETURN
7600 REM Eliminar objeto
7610 IF ob<=20 THEN LET m(c(t,2)+1,c(t,1))=0: LET m(c(t,2)+2,c(t,1))=0: LET ox=c(t,1): LET oy=c(t,2): GO SUB 8400: LET oy=oy+1: GO SUB 8400: LET c(t,3)=0: LET nc=nc-1: GO SUB 9100: REM Eliminar ciudadano
7620 IF ob>20 AND ob<=40 THEN LET m(l(t,2)+1,l(t,1))=0: LET ox=l(t,1): LET oy=l(t,2): GO SUB 8400: LET l(t,3)=0: GO SUB 9200: REM Eliminar ladrillo
7630 IF ob<=40 OR ob>80 THEN GO TO 7660: REM Si no es torreta, termina
7640 LET m(t(t,2)+1,t(t,1))=0: LET m(t(t,2)+2,t(t,1))=0: LET m(t(t,2)+1,t(t,1)+1)=0: LET m(t(t,2)+2,t(t,1)+1)=0: LET ox=t(t,1): LET oy=t(t,2)
7650 INK 6: PAPER 2: FLASH 1: PRINT AT t(t,2),t(t,1);CHR$ (161);CHR$ (162);AT t(t,2)+1,t(t,1);CHR$ (163);CHR$ (164): REM Explosion
7655 FOR x=1 TO 10: BEEP 0.02,INT (RND*20): NEXT X
7658 INK 7: PAPER 0: FLASH 0: PRINT AT t(t,2),t(t,1);"  ";AT t(t,2)+1,t(t,1);"  ": LET t(t,4)=0: GO SUB 9300
7660 BEEP 0.05,0: RETURN
7700 REM Disparo de torreta
7705 FOR w=1 TO 2
7710 FLASH 1: OVER 1: PAPER 0
7720 INK t(i,3): PRINT AT t(i,2),t(i,1);"OO";AT t(i,2)+1,t(i,1);"OO"
7725 IF z(j,1)<6 THEN PAPER 5
7730 INK z(j,3): PRINT AT z(j,2),z(j,1);"O";AT z(j,2)+1,z(j,1);"O"
7740 BEEP 0.1,50: BEEP 0.1,40
7750 FLASH 0: PAPER 0
7760 INK t(i,3): PRINT AT t(i,2),t(i,1);"OO";AT t(i,2)+1,t(i,1);"OO"
7765 IF z(j,1)<6 THEN PAPER 5
7770 INK z(j,3): PRINT AT z(j,2),z(j,1);"O";AT z(j,2)+1,z(j,1);"O"
7771 NEXT w
7775 OVER 0: PAPER 0
7780 LET z(j,6)=z(j,6)-1
7785 LET t(i,6)=t(i,6)-1: IF t(i,6)=0 THEN LET t=i: GO SUB 7640
7790 IF z(j,6)>0 THEN GO TO 7800
7791 IF z(j,1)<6 THEN PAPER 5
7795 PRINT AT z(j,2),z(j,1);" ";AT z(j,2)+1,z(j,1);" ": LET m(z(j,2),z(j,1))=0: LET m(z(j,2)+1,z(j,1))=0: GO SUB 9400: REM Recolocar zombie
7800 PAPER 0: RETURN
8000 REM Dibujar cursor en cy,cx
8020 PAPER 0: INK 7
8030 FLASH 1: PRINT AT cy,cx;CHR$ (159): FLASH 0: RETURN
8050 REM Borrar cursor
8060 PRINT AT oy,ox;" ": RETURN
8150 REM Dibujar zombie numero g
8155 POKE 23675,8: POKE 23676,254
8160 IF z(g,1)<6 THEN PAPER 5: GO TO 8162: REM Fondo segun si esta o no a la izquierda
8161 PAPER 0
8163 INK 4: PRINT AT z(g,2),z(g,1);CHR$ (144+(8*(z(g,3)=2))+(16*(z(g,3)=3)))
8164 INK z(g,3): PRINT AT z(g,2)+1,z(g,1);CHR$ (145+(8*(z(g,3)=2)))
8165 POKE 23675,88: POKE 23676,255
8166 RETURN
8170 REM Dibujar zombia numero g andando
8175 POKE 23675,8: POKE 23676,254
8180 IF z(g,1)<6 THEN PAPER 5: GO TO 8162: REM Fondo segun si esta o no a la izquierda
8181 PAPER 0: INK 4
8182 IF z(g,3)=1 THEN PRINT AT z(g,2),z(g,1);CHR$ 146;CHR$ 147;INK 1;AT z(g,2)+1,z(g,1);CHR$ 148;CHR$ 149
8183 IF z(g,3)=2 THEN PRINT AT z(g,2),z(g,1);CHR$ 154;CHR$ 156;INK 2;AT z(g,2)+1,z(g,1);CHR$ 155;CHR$ 157
8184 IF z(g,3)=3 THEN PRINT AT z(g,2),z(g,1);CHR$ 161;CHR$ 162;INK 3;AT z(g,2)+1,z(g,1);CHR$ 148;CHR$ 149
8185 BEEP 0.1,10
8187 POKE 23675,88: POKE 23676,255
8188 RETURN
8400 REM Comprobar y redibujar objeto en oy, ox
8410 LET op=m(oy+1,ox)
8420 IF ox<6 THEN PAPER 5: GO TO 8430
8421 PAPER 0: IF ox=6 THEN INK 5: PRINT AT oy,ox;CHR$ 160: RETURN
8430 IF op=0 THEN PRINT AT oy,ox;" ": RETURN
8440 IF op<=20 THEN LET ci=INT ((op+1)/2): IF c(ci,3)>0 THEN INK 0: PRINT AT oy,ox;CHR$ (144+1*(c(ci,2)<>oy)): RETURN
8450 IF op<=40 THEN LET li=op-20: IF l(li,3)>0 THEN INK 6: BRIGHT 1: PRINT AT oy,ox;CHR$ 146: BRIGHT 0: RETURN
8460 IF op<=80 THEN GO TO 8480
8470 LET g=INT ((op-81)/2)+1: GO SUB 8150: RETURN
8480 LET j=INT ((op-41)/4)+1: IF t(j,4)>0 THEN GO SUB 3330: RETURN
8600 REM Comprobar si la celda esta ocupada en cy, cx
8610 LET o=m(cy+1,cx): RETURN
8700 REM Dibujar interfaz
8710 INK 0: PAPER 7: PRINT #0;AT 0,0;"Recursos:                       "
8715 PRINT #0;AT 1,0;"Controles: "+CHR$ (158)+"QAOP     0"; INK 6; PAPER 0; BRIGHT 1;CHR$ 146; INK 1; PAPER 7; BRIGHT 0;" 1";CHR$ 157; INK 2;" 2";CHR$ 157; INK 3;" 3";CHR$ 157
8717 PAPER 0: RETURN
9000 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, z-zombies, l-ladrillos, t-torretas
9010 REM g-bucle mover zombies, k-tecla pulsada, ox,oy-posicion anterior, m-mapa del juego
9020 REM te-tipo de torreta, r-recursos, tir-tiempo (recursos), tiz-tiempo (zombies), tit-tiempo (torretas), cx,cy-posicion cursor, o-ocupado
9030 REM nz-numero de zombies, nl-numero de ladrillos, nt-numero de torretas, nc-numero de ciudadanos, cm-modo construccion, cc-contador de ciclos, z-temporizador
9035 REM cm=0 modo normal, cm=1 modo contruccion
9040 REM Mapa (m): 0=vacio, 1-20=ciudadano, 21-40=ladrillo, 41-80=torreta, 81-100=zombie
9041 REM Para torretas y zombies, el valor de m tambien codifica el color:
9042 REM Torretas: m = 40 + (nt*4) + (1-4), donde nt es el numero de torreta (0-9) y (1-4) es la parte de la torreta (2x2)
9043 REM El color de la torreta se almacena en t(nt,3) y puede ser 1, 2 o 3
9044 REM Zombies: m = 80 + (nz*2) + (0-1), donde nz es el numero de zombie (1-10) y (0-1) es la parte superior/inferior
9045 REM El color del zombie se almacena en z(nz,3) y puede ser 1, 2 o 3
9046 REM La animacion del zombie se almacena en z(nz,5), con valores 0, 1 o 2
9047 REM La vida de los objetos se almacena en: c(b,3) para ciudadanos, l(nl,3) para ladrillos, t(nt,4) para torretas
9048 REM Ciudadanos: c(b,1)=x, c(b,2)=y, c(b,3)=vida
9049 REM Torretas: t(nt,1)=x, t(nt,2)=y, t(nt,3)=color, t(nt,4)=vida, t(nt,5)=contador de disparo
9050 REM Ladrillos: l(nl,1)=x, l(nl,2)=y, l(nl,3)=vida
9051 REM Zombies: z(nz,1)=x, z(nz,2)=y, z(nz,3)=color, z(nz,4)=contador de movimiento, z(nz,5)=animacion, z(nz,6)=vida
9060 REM UDGs: 144-145 Ciudadano, 146 Ladrillo, 147-152 Zombies (2 chars por animacion), 153-156 Torreta (2x2), 157 Torreta pequena
9061 RESTORE 9062: FOR F=65368 TO 65535: READ A: POKE F,A: NEXT F: RETURN
9062 DATA 56,68,68,68,56,124,186,186: REM 144 ciudadano
9063 DATA 186,186,170,170,170,168,40,108
9064 DATA 255,129,165,153,153,165,129,255: REM 146 Ladrillo
9065 DATA 12,18,114,18,12,252,12,12: REM 147 Zombie 1
9066 DATA 12,12,20,36,68,68,36,116
9067 DATA 12,18,114,18,12,252,12,12: REM 149 Zombie 2
9068 DATA 12,12,12,12,12,12,10,63
9069 DATA 12,18,114,18,12,252,12,12: REM 151 Zombie 3
9070 DATA 12,12,12,10,10,9,9,54
9071 DATA 127,128,128,128,143,136,136,136: REM 153 Torreta
9072 DATA 136,136,136,143,128,128,128,127
9073 DATA 254,1,1,1,241,17,17,17
9074 DATA 17,17,17,241,1,1,1,254
9075 DATA 126,129,129,153,153,129,129,126: REM 157 Torreta pequena
9076 DATA 0,0,0,0,0,0,66,126: REM 158 Espacio
9077 DATA 129,90,36,90,90,36,90,129: REM 159 Cursor
9078 DATA 240,248,248,240,240,248,248,240: REM 160 Separador
9079 DATA 1,226,90,36,16,16,96,128: REM 161-164 Explosion
9080 DATA 4,138,178,68,8,8,6,1
9081 DATA 64,48,8,16,16,39,72,48
9082 DATA 6,8,8,4,20,42,166,64
9100 REM Reindexar ciudadanos
9110 LET i=1
9120 IF c(i,3)=0 THEN LET c(i,1)=c(nc,1):LET c(i,2)=c(nc,2):LET c(i,3)=c(nc,3):LET nc=nc-1:RETURN
9130 LET i=i+1
9140 IF i<=nc THEN GOTO 9120
9150 RETURN
9200 REM Reindexar ladrillos
9210 LET i=1
9220 IF l(i,3)=0 THEN LET l(i,1)=l(nl,1):LET l(i,2)=l(nl,2):LET l(i,3)=l(nl,3):LET nl=nl-1:RETURN
9230 LET i=i+1
9240 IF i<=nl THEN GOTO 9220
9250 RETURN
9300 REM Reindexar torretas
9310 LET i=1
9320 IF t(i,4)=0 THEN LET t(i,1)=t(nt,1):LET t(i,2)=t(nt,2):LET t(i,3)=l(nt,3):LET t(i,4)=t(nt,4):LET t(i,5)=t(nt,5):LET nt=nt-1:RETURN
9330 LET i=i+1
9340 IF i<=nt THEN GOTO 9320
9350 RETURN
9400 REM Recolocar zombie
9420 LET z(j,1)=31: LET z(j,2)=INT (RND*19)+1: LET z(j,4)=0: LET z(j,6)=z(nz,6)=1+(3*(z(j,3)=2))+(3*(z(j,3)=3))
9430 IF m(z(j,2)+1,z(j,1))>0 OR m(z(j,2)+2,z(j,1))>0 THEN GO TO 9420
9450 LET m(z(j,2)+1,z(j,1))=80+(j*2)-1: LET m(z(j,2)+2,z(j,1))=80+(j*2): LET g=j: GO SUB 8150
9460 RETURN
9500 RESTORE 9501: FOR F=65032 TO 65199: READ A: POKE F,A: NEXT F: RETURN
9501 DATA 28,62,46,126,30,12,252,156
9502 DATA 28,28,28,44,44,44,44,124
9503 DATA 1,3,2,7,1,0,15,8
9504 DATA 192,224,224,224,224,192,192,192
9505 DATA 1,1,3,7,12,44,56,24
9506 DATA 192,192,192,96,112,56,24,48
9507 DATA 56,124,92,252,24,184,88,56
9508 DATA 24,24,56,56,44,102,99,198
9509 DATA 0,0,0,12,22,30,12,124
9510 DATA 12,12,12,12,20,18,18,54
9511 DATA 0,0,0,1,2,3,1,15
9512 DATA 1,1,1,3,4,4,2,6
9513 DATA 0,0,0,128,192,192,128,128
9514 DATA 128,128,128,128,192,96,48,16
9515 DATA 0,0,0,24,44,188,88,56
9516 DATA 24,24,24,24,40,76,38,98
9517 DATA 60,94,126,126,60,60,28,252
9518 DATA 3,5,7,7,3,7,15,25
9519 DATA 192,192,192,224,224,240,216,196
9520 DATA 60,94,126,126,28,62,254,219
9521 DATA 0,0,0,0,0,0,0,0
9522 REM UDG en 65032 - Zombies - Uso: POKE 23675,8: POKE 23676,254 == POKE 23675,V-256*INT (V/256): POKE 23676,INT (V/256)
9523 REM Zombie 1 - Quieto: 144/145 - Andar 146-147/148-149 - Morder 150/151 - Color 4/1
9524 REM Zombie 2 - Quieto: 152/153 - Andar 154-156/155-157 - Morder 158/159 - Color 4/2
9525 REM Zombie 3 - Quiero: 160/145 - Andar 161-162/148-149 - Morder 163/151 - Color 4/3
9600 RESTORE 9601: FOR F=65200 TO 65295: READ A: POKE F,A: NEXT F:RETURN
9601 DATA 255,128,128,129,131,133,129,129
9602 DATA 255,1,1,1,1,1,1,1
9603 DATA 129,129,129,129,129,128,128,255
9604 DATA 1,1,1,1,1,1,1,255
9605 DATA 255,128,128,129,130,128,128,128
9606 DATA 255,1,1,193,33,33,65,129
9607 DATA 129,130,132,136,143,128,128,255
9608 DATA 1,1,1,1,225,1,1,255
9609 DATA 255,128,128,129,130,128,128,128
9610 DATA 255,1,1,193,33,33,65,129
9611 DATA 129,128,128,130,129,128,128,255
9612 DATA 193,33,33,33,193,1,1,255
9620 REM UDG en 65200 - Torretas - Uso: POKE 23675,176: POKE 23676,254
9621 REM Torreta 1 - 144-145/146-147
9621 REM Torreta 2 - 148-149/150-151
9621 REM Torreta 3 - 152-153/154-155
9994 REM .....................................................
9995 REM El programa utiliza BASIC de ZX Spectrum, con lo cual no puede utilizar las ordenes ELSE, END IF, o el operador MOD
9996 REM Se debe optimizar al maximo el uso de CPU, reduciendo los ciclos de reloj
9997 REM El uso de memoria no es problema, asi que se pueden crear variables auxiliares si asi se optimiza el codigo
9998 REM Es preferible tener menos lineas aunque sean muy largas. Igualmente, es mejor que los REM esten siempre acompanando a otra linea, no solos
9999 REM No se pueden crear lineas mas alla de la 9999. Siempre que pida cambios, solo se devuelven los bloques de lineas que han cambiado
