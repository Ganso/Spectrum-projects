   1 DIM m(22,32): DIM c(10,3): DIM z(10,6): DIM l(20,3): DIM t(10,6): LET r=20: LET cx=7: LET cy=10
   2 LET te=0: LET k$="": LET ox=0: LET oy=0: LET o=0: LET nz=0: LET nl=0: LET nt=0: LET nc=0: LET tir=0: LET tiz=0: LET tit=0: LET cm=0: LET cc=0: LET w=0: LET x=0: LET y=0: LET z=0: LET sp=0
  10 BORDER 7: PAPER 0: INK 7: CLS
  15 PAPER 7: INK 0: PRINT AT 10,7;"  INICIALIZANDO  "
  20 GO SUB 9060: REM Definir UDG
  25 RANDOMIZE : GO SUB 1000: GO SUB 2000: GO SUB 2050: GO SUB 8700: GO TO 6000
1000 REM Inicializar pantalla
1005 INK 4
1010 FOR y=0 TO 21
1020 PAPER 4: PRINT AT y,0;"      "
1030 PAPER 0: PRINT AT y,6;CHR$ 160
1060 NEXT y
1070 PRINT AT 10,7;"                     "
1080 RETURN
2000 REM Colocar ciudadanos inicialmente
2001 FOR b=1 TO 10
2002 LET c(b,1)=INT (RND*5)+1: LET c(b,2)=INT (RND*20)+1: LET c(b,3)=5
2010 IF m(c(b,2),c(b,1))>0 OR m(c(b,2)+1,c(b,1))>0 THEN GO TO 2002
2020 PAPER 4: INK 0: PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2),c(b,1))=b*2-1: LET m(c(b,2)+1,c(b,1))=b*2: LET nc=nc+1: NEXT b: RETURN
2050 REM Colocar ladrillos inicialmente
2051 LET nl=0
2052 FOR b=1 TO 10
2053 LET l(b,1)=INT (RND*5)+8: LET l(b,2)=INT (RND*20)+1: LET l(b,3)=3
2054 IF m(l(b,2),l(b,1))>0 THEN GO TO 2053
2055 PAPER 0: INK 4: PRINT AT l(b,2),l(b,1);CHR$ 146
2056 LET m(l(b,2),l(b,1))=20+b: LET nl=nl+1
2057 NEXT b
2058 RETURN
3000 REM Comprobar si podemos colocar objeto
3010 IF (te=0 AND r<2) OR (te>0 AND r<10) THEN RETURN: REM Ladrillo 2, Torreta 10
3020 GO SUB 8600: IF o=0 THEN GO SUB 3100
3030 RETURN
3100 REM Colocar objeto en el mapa
3110 IF te=0 AND nl<20 THEN LET r=r-2: INK 4: PRINT AT cy,cx;CHR$ 146: LET m(cy,cx)=20+nl+1: LET nl=nl+1: LET l(nl,1)=cx: LET l(nl,2)=cy: LET l(nl,3)=3
3120 IF te>0 AND nt<10 AND oy<20 THEN GO SUB 3200: IF o=0 THEN GO SUB 3300
3130 GO SUB 7240: BEEP 0.1,50: RETURN
3200 REM Comprobar si las celdas adyacentes estan libres para colocar torreta
3210 LET o=0: IF cx+1>31 OR cy+1>21 THEN LET o=1: RETURN
3220 IF m(cy,cx)>0 OR m(cy,cx+1)>0 OR m(cy+1,cx)>0 OR m(cy+1,cx+1)>0 THEN LET o=1
3230 RETURN
3300 REM Colocar torreta
3310 LET r=r-10: INK te: PRINT AT cy,cx;CHR$ 153;CHR$ 155;AT cy+1,cx;CHR$ 154;CHR$ 156
3320 LET m(cy,cx)=40+(nt*4)+1: LET m(cy+1,cx)=40+(nt*4)+2: LET m(cy,cx+1)=40+(nt*4)+3: LET m(cy+1,cx+1)=40+(nt*4)+4
3330 LET nt=nt+1: LET t(nt,1)=cx: LET t(nt,2)=cy: LET t(nt,3)=te: LET t(nt,4)=1: LET t(nt,5)=0: LET t(nt,6)=8: REM Inicializa torreta con vida 1 y 8 usos
3340 RETURN
5000 REM Generar zombie
5010 IF nz>=10 THEN RETURN
5020 LET nz=nz+1: LET z(nz,1)=31: LET z(nz,2)=INT (RND*19)+1: LET z(nz,3)=INT (RND*3)+1: LET z(nz,4)=10: LET z(nz,5)=0: LET z(nz,6)=3: REM Inicializa zombie (al principo se queda un rato parado)
5030 IF m(z(nz,2),z(nz,1))>0 OR m(z(nz,2)+1,z(nz,1))>0 THEN LET nz=nz-1: RETURN
5040 LET g=nz: GO SUB 8150: LET m(z(nz,2),z(nz,1))=80+(nz*2)-1: LET m(z(nz,2)+1,z(nz,1))=80+(nz*2)
5050 BEEP 0.1,20: RETURN
6000 REM Bucle principal del juego
6010 IF cm=0 THEN GO SUB 7000: GO SUB 7200: GO SUB 7500
6020 IF cm=1 THEN BORDER INT (RND*6): LET cc=cc+1: IF cc=100 THEN GO SUB 8050: LET cm=0: LET cc=0: BORDER 7: REM ESTO DEBERIA HACERSE EN LA RUTINA DE MOVIMIENTO
6030 GO SUB 7300
6040 GO TO 6000
7000 REM Mover zombies
7010 FOR g=1 TO nz
7015 IF INKEY$=" " THEN LET sp=1
7020 IF z(g,4)>0 THEN LET z(g,4)=z(g,4)-1: IF z(g,4)>0 THEN GO TO 7050: REM Decrementa el contador de movimientos. Si no es cero no hace nada.
7030 IF z(g,1)<=1 THEN GO SUB 7080: GO TO 7050: REM Si está a la izquierda, lo hace invencible y parpadea
7031 IF m(z(g,2),z(g,1)-1)>0 OR m(z(g,2)+1,z(g,1)-1)>0 THEN GO TO 7040: REM Si hay un objeto a la izquierda, va la deteccion de colisiones
7032 LET ox=z(g,1): LET oy=z(g,2): LET m(oy,ox)=0: LET m(oy+1,ox)=0: REM Vacia en el mapa la casilla actual
7033 GO SUB 8400: LET oy=oy+1: GO SUB 8400: REM Repinta las casillas actuales
7034 LET z(g,1)=z(g,1)-1: REM Decrementa la X
7035 LET z(g,5)=z(g,5)+1: IF z(g,5)=3 THEN LET z(g,5)=0: REM Cambia el paso de animacion
7036 GO SUB 8150: LET m(z(g,2),z(g,1))=80+(g*2)-1: LET m(z(g,2)+1,z(g,1))=80+(g*2): BEEP 0.05,10: REM Dibuja de nuevo el zombie y da un pitido
7037 GO TO 7050: REM Salta al NEXT
7040 GO SUB 7100: GO TO 7050: REM Procesa colisiones
7050 NEXT g: REM Siguiente zombie
7060 RETURN
7080 REM Hacer zombie invencible y parpadear
7082 LET z(g,6)=-1: REM Marcar como invencible
7084 FLASH 1: PAPER 4: INK z(g,3): PRINT AT z(g,2),z(g,1);CHR$ (147+z(g,5)*2);AT z(g,2)+1,z(g,1);CHR$ (148+z(g,5)*2): FLASH 0
7086 RETURN
7100 REM Zombie encuentra objeto
7110 LET col=7: LET matado=0: LET ob=m(z(g,2),z(g,1)-1): IF ob=0 OR ob>80 THEN LET ob=m(z(g,2)+1,z(g,1)-1): REM ob = objeto colisionado
7115 IF ob=0 OR ob>80 THEN RETURN: REM No colisiona con otros zombies
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
7205 IF INKEY$=" " THEN LET sp=1
7210 IF tir>=2 THEN LET r=r+1: LET tir=0: IF r>100 THEN LET r=100: REM cada 2 ticks suben los recursos
7220 IF tiz>=20 THEN LET tiz=0: GO SUB 5000: RETURN : REM cada 20 ticks sale un zombie
7230 IF tit>=6 THEN LET tit=0: GO SUB 7500: RETURN : REM cada 6 ticks las torretas intentan disparar
7240 INK 0: PAPER 7: PRINT AT 0,10;r;"   ": PAPER 0: LET tir=tir+1: LET tiz=tiz+1: LET tit=tit+1
7250 FOR i=1 TO nt: LET t(i,5)=t(i,5)+1: NEXT i: RETURN
7300 REM Controles del jugador
7305 LET k$=INKEY$: IF k$="" AND sp=0 THEN RETURN
7320 IF k$=" " OR sp=1 THEN IF cm=0 THEN LET cm=1: LET cc=0: LET sp=0: GO SUB 8000: RETURN
7321 IF k$=" " OR sp=1 THEN IF cm=1 AND cc>5 THEN GO SUB 8050: LET cm=0: LET cc=0: LET sp=0: PAPER 7: PRINT AT 0,19;"             ": PAPER 0: PRINT AT oy,ox;" ": GO SUB 8400: BORDER 7: RETURN
7330 IF cm=0 THEN RETURN
7335 PAPER 7: INK 2: PRINT AT 0,19;"("; FLASH 1;"C"; FLASH 0;") ";CHR$ (146);"=2, "+CHR$ (157)+"=20": PAPER 0
7350 LET ox=cx: LET oy=cy
7360 IF k$="q" AND cy>1 THEN LET cy=cy-1
7370 IF k$="a" AND cy<20 THEN LET cy=cy+1
7380 IF k$="o" AND cx>7 THEN LET cx=cx-1
7390 IF k$="p" AND cx<30 THEN LET cx=cx+1
7400 IF k$>="0" AND k$<="3" THEN LET te=VAL k$: GO SUB 3000
7410 IF ox<>cx OR oy<>cy THEN GO SUB 8050: GO SUB 8400: GO SUB 8000: LET ox=cx: LET oy=cy: REM Si hemos movido el cursor, redibuja
7420 GO TO 7300
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
7610 IF ob<=20 THEN LET m(c(t,2),c(t,1))=0: LET m(c(t,2)+1,c(t,1))=0: LET ox=c(t,1): LET oy=c(t,2): GO SUB 8400: LET oy=oy+1: GO SUB 8400: LET c(t,3)=0: LET nc=nc-1: GO SUB 9100
7620 IF ob>20 AND ob<=40 THEN LET m(l(t,2),l(t,1))=0: LET ox=l(t,1): LET oy=l(t,2): GO SUB 8400: LET l(t,3)=0: GO SUB 9200
7630 IF ob<=40 OR ob>80 THEN GO TO 7660: REM Procesamos torretas
7640 LET m(t(t,2),t(t,1))=0: LET m(t(t,2)+1,t(t,1))=0: LET m(t(t,2),t(t,1)+1)=0: LET m(t(t,2)+1,t(t,1)+1)=0: LET ox=t(t,1): LET oy=t(t,2): LET t(t,4)=0: GO SUB 9300
7650 INK 6: PAPER 2: FLASH 1: PRINT AT t(t,2),t(t,1);chr$(161);chr$(162); AT t(t,2)+1,t(t,1);chr$(163);chr$(164)
7655 FOR x=1 TO 10:BEEP 0.02,INT (RND*20):NEXT X
7658 INK 7: PAPER 0: FLASH 0:PRINT AT t(t,2),t(t,1);"  "; AT t(t,2)+1,t(t,1);"  "
7660 BEEP 0.5,0: RETURN
7700 REM Disparo de torreta
7705 FOR w=1 TO 2
7710 FLASH 1: OVER 1: PAPER 0
7720 INK t(i,3): PRINT AT t(i,2),t(i,1);"OO";AT t(i,2)+1,t(i,1);"OO"
7725 IF z(j,1)<6 THEN PAPER 4
7730 INK z(j,3): PRINT AT z(j,2),z(j,1);"O";AT z(j,2)+1,z(j,1);"O"
7740 BEEP 0.1,50: BEEP 0.1,40
7750 FLASH 0: PAPER 0
7760 INK t(i,3): PRINT AT t(i,2),t(i,1);"OO";AT t(i,2)+1,t(i,1);"OO"
7765 IF z(j,1)<6 THEN PAPER 4
7770 INK z(j,3): PRINT AT z(j,2),z(j,1);"O";AT z(j,2)+1,z(j,1);"O"
7771 NEXT w
7775 OVER 0: PAPER 0
7780 LET z(j,6)=z(j,6)-1
7785 LET t(i,6)=t(i,6)-1: IF t(i,6)=0 THEN LET t=i: GO SUB 7640
7790 IF z(j,6)>0 THEN GO TO 7800
7791 IF z(j,1)<6 THEN PAPER 4
7795 PRINT AT z(j,2),z(j,1);" ";AT z(j,2)+1,z(j,1);" ": LET m(z(j,2),z(j,1))=0: LET m(z(j,2)+1,z(j,1))=0: GO SUB 9400: REM Recolocar zombie
7800 PAPER 0: RETURN
8000 REM Dibujar cursor en cy,cx
8010 IF cx<7 THEN PAPER 4: INK 6: GO TO 8030
8020 PAPER 0: INK 6
8030 FLASH 1: PRINT AT cy,cx;CHR$ (159): FLASH 0: RETURN
8050 REM Borrar cursor
8060 PRINT AT oy,ox;" ": RETURN
8150 REM Dibujar zombie numero g
8160 IF z(g,1)<6 THEN PAPER 4: GO TO 8162: REM Fondo segun si esta o no a la izquierda
8161 PAPER 0
8162 INK z(g,3): LET zc=147+z(g,5)*2: REM Calcula tinta y animacion
8163 PRINT AT z(g,2),z(g,1);CHR$ zc;AT z(g,2)+1,z(g,1);CHR$ (zc+1): REM Imprime
8164 RETURN
8400 REM Comprobar y redibujar objeto en oy, ox
8410 LET op=m(oy,ox)
8420 IF ox<6 THEN PAPER 4: GO TO 8430
8421 PAPER 0: IF ox=6 THEN INK 4: PRINT AT oy,ox;CHR$ 160: RETURN
8430 IF op=0 THEN PRINT AT oy,ox;" ": RETURN
8440 IF op<=20 THEN LET ci=INT ((op+1)/2): IF c(ci,3)>0 THEN INK 0: PRINT AT oy,ox;CHR$ (143+op): RETURN
8450 IF op<=40 THEN LET li=op-20: IF l(li,3)>0 THEN INK 4: PRINT AT oy,ox;CHR$ 146: RETURN
8460 IF op<=80 THEN GO TO 8480
8470 LET zn=INT ((op-81)/2)+1: IF z(zn,6)>0 THEN INK z(zn,3): LET zp=op-80-(zn-1)*2: PRINT AT oy,ox;CHR$ (147+2*z(zn,5)+zp-1): RETURN
8480 LET tn=INT ((op-41)/4)+1: IF t(tn,4)>0 THEN INK t(tn,3): LET opt=op-40-(tn-1)*4: PRINT AT oy,ox;CHR$ (152+opt)
8510 RETURN
8600 REM Comprobar si la celda esta ocupada en cy, cx
8610 LET o=m(cy,cx): RETURN
8700 REM Dibujar interfaz
8710 INK 0: PAPER 7: PRINT AT 0,0;"Recursos:                       ";AT 21,0;"Movimiento: "+CHR$ (158)+"QAOP               "
8720 INK 4: PRINT AT 21,20;"0";CHR$ 146: INK 1: PRINT AT 21,23;"1";CHR$ 157: INK 2: PRINT AT 21,26;"2";CHR$ 157: INK 3: PRINT AT 21,29;"3";CHR$ 157: PAPER 0: RETURN
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
9061 RESTORE 9062: FOR F=65368 TO 65535: READ A: POKE F,A: NEXT F
9062 DATA 56,68,68,68,56,124,186,186: REM 144 ciudadano
9063 DATA 186,186,170,170,170,168,40,108
9064 DATA 255,129,129,255,255,129,129,255: REM 146 Ladrillo
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
9079 DATA 1, 226, 90, 36, 16, 16, 96, 128: REM 161-164 Explosion
9080 DATA 4, 138, 178, 68, 8, 8, 6, 1
9081 DATA 64, 48, 8, 16, 16, 39, 72, 48
9082 DATA 6, 8, 8, 4, 20, 42, 166, 64
9090 RETURN
9100 REM Reindexar ciudadanos
9105 LET nc=5: REM Número máximo de ciudadanos
9110 LET j=1
9115 FOR i=1 TO nc
9120 IF c(i,3)>0 THEN LET c(j,1)=c(i,1): LET c(j,2)=c(i,2): LET c(j,3)=c(i,3): LET m(c(j,2),c(j,1))=j*2-1: LET m(c(j,2)+1,c(j,1))=j*2: LET j=j+1
9125 NEXT i
9130 FOR i=j TO nc: LET c(i,1)=0: LET c(i,2)=0: LET c(i,3)=0: NEXT i
9135 LET nc=j-1: REM Actualiza el número de ciudadanos vivos
9140 RETURN
9200 REM Reindexar ladrillos
9210 LET j=1
9220 FOR i=1 TO nl
9230 IF l(i,3)>0 THEN LET l(j,1)=l(i,1): LET l(j,2)=l(i,2): LET l(j,3)=l(i,3): LET m(l(j,2),l(j,1))=20+j: LET j=j+1
9240 NEXT i
9250 FOR i=j TO 20: LET l(i,1)=0: LET l(i,2)=0: LET l(i,3)=0: NEXT i
9260 LET nl=j-1: REM Actualiza el número de ladrillos
9270 RETURN
9300 REM Reindexar torretas
9310 LET j=1
9320 FOR i=1 TO nt
9330 IF t(i,4)>0 THEN LET t(j,1)=t(i,1): LET t(j,2)=t(i,2): LET t(j,3)=t(i,3): LET t(j,4)=t(i,4): LET t(j,5)=t(i,5): LET t(j,6)=t(i,6): LET m(t(j,2),t(j,1))=40+(j*4)+1: LET m(t(j,2)+1,t(j,1))=40+(j*4)+2: LET m(t(j,2),t(j,1)+1)=40+(j*4)+3: LET m(t(j,2)+1,t(j,1)+1)=40+(j*4)+4: LET j=j+1
9340 NEXT i
9350 FOR i=j TO 10: LET t(i,1)=0: LET t(i,2)=0: LET t(i,3)=0: LET t(i,4)=0: LET t(i,5)=0: LET t(i,6)=0: NEXT i
9360 LET nt=j-1: REM Actualiza el número de torretas
9370 RETURN
9400 REM Recolocar zombie
9410 LET attempts=0
9420 LET z(j,1)=31: LET z(j,2)=INT (RND*19)+1: LET z(j,3)=INT (RND*3)+1: LET z(j,4)=10: LET z(j,6)=3
9430 IF m(z(j,2),z(j,1))>0 OR m(z(j,2)+1,z(j,1))>0 THEN LET attempts=attempts+1: IF attempts<10 THEN GO TO 9420
9440 IF attempts>=10 THEN LET z(j,1)=31: LET z(j,2)=0: LET z(j,3)=0: LET z(j,4)=0: LET z(j,6)=0: RETURN
9450 LET m(z(j,2),z(j,1))=80+(j*2)-1: LET m(z(j,2)+1,z(j,1))=80+(j*2): LET g=j: GO SUB 8150
9460 RETURN
9994 REM
9995 REM El programa utiliza BASIC de ZX Spectrum, con lo cual no puede utilizar las ordenes ELSE, END IF, o el operador MOD
9996 REM Se debe optimizar al maximo el uso de CPU, reduciendo los ciclos de reloj
9997 REM El uso de memoria no es problema, asi que se pueden crear variables auxiliares si asi se optimiza el codigo
9998 REM Es preferible tener menos lineas aunque sean muy largas. Igualmente, es mejor que los REM esten siempre acompanando a otra linea, no solos
9999 REM No se pueden crear lineas mas alla de la 9999. Siempre que pida cambios, solo se devuelven los bloques de lineas que han cambiado
