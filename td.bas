1 DIM m(22,32): DIM c(10,3): DIM z(10,5): DIM l(20,3): DIM t(10,4): LET r=40: LET cx=7: LET cy=10
2 LET te=0: LET k$="": LET ox=0: LET oy=0: LET o=0: LET nz=0: LET nl=0: LET nt=0: LET tir=0: LET tiz=0: LET tit=0: LET cm=0: LET cc=0
10 BORDER 7: PAPER 0: INK 7: CLS
15 PAPER 7: INK 0: PRINT AT 10,7;"INICIALIZANDO PARTIDA"
20 GO SUB 9050: REM Definir UDG
25 GO SUB 1000: GO SUB 2000: GO SUB 8700: GO TO 6000
1000 REM Inicializar pantalla
1010 FOR y=0 TO 21
1020 FOR x=0 TO 6
1030 IF x<6 THEN PAPER 1: INK 1: PRINT AT y,x;" "
1040 IF x=6 THEN PAPER 0: INK 1: PRINT AT y,x;CHR$ 160
1050 NEXT x
1060 NEXT y
1070 PRINT AT 10,7;"                     "
1080 RETURN
2000 REM Colocar ciudadanos
2001 FOR b=1 TO 5
2002 LET c(b,1)=INT (RND*5)+1: LET c(b,2)=INT (RND*20)+1: LET c(b,3)=5
2010 IF m(c(b,2),c(b,1))>0 OR m(c(b,2)+1,c(b,1))>0 THEN GO TO 2002
2020 PAPER 1: INK 7: PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2),c(b,1))=b*2-1: LET m(c(b,2)+1,c(b,1))=b*2: NEXT b: RETURN
3000 REM Comprobar si podemos colocar objeto
3010 IF (te=0 AND r<5) OR (te>0 AND r<20) THEN RETURN
3020 GO SUB 8600: IF o=0 THEN GO SUB 3100
3030 RETURN
3100 REM Colocar objeto en el mapa
3110 IF te=0 AND nl<20 THEN LET r=r-5: INK 4: PRINT AT cy,cx;CHR$ 146: LET m(cy,cx)=20+nl+1: LET nl=nl+1: LET l(nl,1)=cx: LET l(nl,2)=cy: LET l(nl,3)=2
3120 IF te>0 AND nt<10 AND oy<20 THEN GO SUB 3200: IF o=0 THEN GO SUB 3300
3130 GO SUB 7240: BEEP 0.1,50: RETURN
3200 REM Comprobar si las celdas adyacentes están libres para colocar torreta
3210 LET o=0: IF cx+1>31 OR cy+1>21 THEN LET o=1: RETURN
3220 IF m(cy,cx)>0 OR m(cy,cx+1)>0 OR m(cy+1,cx)>0 OR m(cy+1,cx+1)>0 THEN LET o=1
3230 RETURN
3300 REM Colocar torreta
3310 LET r=r-20: INK te: PRINT AT cy,cx;CHR$ 153;CHR$ 154;AT cy+1,cx;CHR$ 155;CHR$ 156
3320 LET m(cy,cx)=40+(nt*4)+1: LET m(cy+1,cx)=40+(nt*4)+2: LET m(cy,cx+1)=40+(nt*4)+3: LET m(cy+1,cx+1)=40+(nt*4)+4
3330 LET nt=nt+1: LET t(nt,1)=cx: LET t(nt,2)=cy: LET t(nt,3)=te: LET t(nt,4)=3
3340 RETURN
5000 REM Generar zombie
5010 IF nz>=10 THEN RETURN
5020 LET nz=nz+1: LET z(nz,1)=31: LET z(nz,2)=INT (RND*19)+1: LET z(nz,3)=INT (RND*3)+1: LET z(nz,4)=5: LET z(nz,5)=0
5030 IF m(z(nz,2),z(nz,1))>0 OR m(z(nz,2)+1,z(nz,1))>0 THEN LET nz=nz-1: RETURN
5040 GO SUB 8150: LET m(z(nz,2),z(nz,1))=80+(nz*2)-1: LET m(z(nz,2)+1,z(nz,1))=80+(nz*2)
5050 BEEP 0.1,20: RETURN
6000 REM Bucle principal del juego
6010 IF cm=0 THEN GO SUB 7000: GO SUB 7200: GO SUB 7500
6020 IF cm=1 THEN BORDER INT (RND*6): LET cc=cc+1: IF cc=100 THEN GO SUB 8050: LET cm=0: LET cc=0: BORDER 7
6030 GO SUB 7300
6040 GO TO 6000
7000 REM Mover zombies
7010 FOR g=1 TO nz
7020 IF z(g,4)>0 THEN LET z(g,4)=z(g,4)-1: IF z(g,4)>0 THEN GO TO 7050
7030 IF z(g,1)<=1 THEN GO TO 7050
7031 IF m(z(g,2),z(g,1)-1)>0 OR m(z(g,2)+1,z(g,1)-1)>0 THEN GO TO 7040
7032 LET ox=z(g,1): LET oy=z(g,2): LET m(oy,ox)=0: LET m(oy+1,ox)=0
7033 GO SUB 8400: GO SUB 8400: LET oy=oy+1: GO SUB 8400
7034 LET z(g,1)=z(g,1)-1
7035 LET z(g,5)=z(g,5)+1: IF z(g,5)=3 THEN LET z(g,5)=0
7036 GO SUB 8150: LET m(z(g,2),z(g,1))=80+(g*2)-1: LET m(z(g,2)+1,z(g,1))=80+(g*2): BEEP 0.05,10
7037 GO TO 7050
7040 GO SUB 7100
7050 NEXT g: RETURN
7100 REM Zombie encuentra objeto
7110 REM Aqui iria la logica para la interaccion del zombie con el objeto
7120 RETURN
7200 REM Actualizar puntuacion, recursos y tiempo
7210 IF tir>=3 THEN LET r=r+1: LET tir=0: IF r>100 THEN LET r=100: REM cada 3 ticks suben los recursos
7220 IF tiz>=20 THEN LET tiz=0: GO SUB 5000: RETURN : REM cada 20 ticks sale un zombie
7230 IF tit>=6 THEN LET tit=0: GO SUB 7500: RETURN : REM cada 6 ticks las torretas intentan disparar
7240 INK 0: PAPER 7: PRINT AT 0,10;r;"   ": PAPER 0: LET tir=tir+1: LET tiz=tiz+1: LET tit=tit+1
7300 REM Controles del jugador
7310 LET k$=INKEY$: IF k$="" THEN RETURN
7320 IF k$=" " THEN IF cm=0 THEN LET cm=1: LET cc=0: GO SUB 8000: RETURN
7321 IF k$=" " THEN IF cm=1 AND cc>5 THEN GO SUB 8050: LET cm=0: LET cc=0: BORDER 7: RETURN
7330 IF cm=0 THEN RETURN
7350 LET ox=cx: LET oy=cy
7360 IF k$="q" AND cy>1 THEN LET cy=cy-1
7370 IF k$="a" AND cy<20 THEN LET cy=cy+1
7380 IF k$="o" AND cx>7 THEN LET cx=cx-1
7390 IF k$="p" AND cx<30 THEN LET cx=cx+1
7400 IF k$>="0" AND k$<="3" THEN LET te=VAL k$: GO SUB 3000
7410 IF ox<>cx OR oy<>cy THEN GO SUB 8050: GO SUB 8400: GO SUB 8000
7420 RETURN
7500 REM Torretas disparan
7510 REM Aqui iria la logica para que las torretas disparen a los zombies
7520 RETURN
8000 REM Dibujar cursor en cy,cx
8010 REM IF m(cy,cx)>0 AND m(cy,cx)<81 THEN RETURN
8020 IF cx<6 THEN PAPER 1: INK 6: GO TO 8030
8021 PAPER 0: INK 6
8030 FLASH 1: PRINT AT cy,cx;CHR$(159): FLASH 0: RETURN
8050 REM Borrar cursor
8060 GO SUB 8400: RETURN
8150 REM Dibujar zombie numero g
8160 PAPER 0: INK z(g,3)
8161 LET zc=147+z(g,5)*2
8162 PRINT AT z(g,2),z(g,1);CHR$ zc;AT z(g,2)+1,z(g,1);CHR$ (zc+1)
8163 RETURN
8400 REM Comprobar y redibujar objeto en oy, ox
8410 LET op=m(oy,ox)
8420 IF ox<6 THEN PAPER 1: GO TO 8430
8421 PAPER 0: IF ox=6 THEN INK 1: GO TO 8430
8430 IF op=0 THEN PRINT AT oy,ox;" ": RETURN
8440 IF op<=20 THEN INK 7: PRINT AT oy,ox;CHR$ (143+op): RETURN: REM Ciudadano
8450 IF op<=40 THEN INK 4: PRINT AT oy,ox;CHR$ 146: RETURN: REM Ladrillo
8460 IF op<=80 THEN GO TO 8480: REM Torreta
8470 LET zn=INT((op-81)/2)+1: INK z(zn,3): LET zp=op-80-(zn-1)*2: PRINT AT oy,ox;CHR$ (147+2*z(zn,5)+zp-1): RETURN: REM Zombie
8480 LET tn=INT ((op-41)/4)+1: INK t(tn,3)
8490 LET opt=op-40-(tn-1)*4
8500 PRINT AT oy,ox;CHR$ (152+opt)
8510 RETURN
8600 REM Comprobar si la celda esta ocupada en cy, cx
8610 LET o=m(cy,cx): RETURN
8700 REM Dibujar interfaz
8710 INK 0: PAPER 7: PRINT AT 0,0;"Recursos:                       ": INK 5: PRINT AT 0,19;"(";CHR$ (146);"=5, "+CHR$ (157)+"=10)": INK 0: PRINT AT 21,0;"Movimiento: QAOP"+CHR$(158)+"               "
8720 INK 4: PRINT AT 21,18;"0";CHR$ 146: INK 1: PRINT AT 21,21;"1";CHR$ 157: INK 2: PRINT AT 21,24;"2";CHR$ 157: INK 3: PRINT AT 21,27;"3";CHR$ 157: PAPER 0: RETURN
9000 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, z-zombies, l-ladrillos, t-torretas
9010 REM g-bucle mover zombies, k-tecla pulsada, ox,oy-posicion anterior, m-mapa del juego
9020 REM te-tipo de torreta, r-recursos, tir-tiempo (recursos), tiz-tiempo (zombies), tit-tiempo (torretas), cx,cy-posicion cursor, o-ocupado
9030 REM nz-numero de zombies, nl-numero de ladrillos, nt-numero de torretas, cm-modo construccion, cc-contador de ciclos
9035 REM cm=0 modo normal, cm=1 modo contruccion
9040 REM Mapa (m): 0=vacio, 1-20=ciudadano, 21-40=ladrillo, 41-80=torreta, 81-100=zombie
9041 REM Para torretas y zombies, el valor de m tambien codifica el color:
9042 REM Torretas: m = 40 + (nt*4) + (1-4), donde nt es el numero de torreta (0-9) y (1-4) es la parte de la torreta (2x2)
9043 REM El color de la torreta se almacena en t(nt,3) y puede ser 1, 2 o 3
9044 REM Zombies: m = 80 + (nz*2) + (0-1), donde nz es el numero de zombie (1-10) y (0-1) es la parte superior/inferior
9045 REM El color del zombie se almacena en z(nz,3) y puede ser 1, 2 o 3
9046 REM La animacion del zombie se almacena en z(nz,5), con valores 0, 1 o 2
9050 REM UDGs: 144-145 Ciudadano, 146 Ladrillo, 147-152 Zombies (2 chars por animacion), 153-156 Torreta (2x2), 157 Torreta pequena
9051 RESTORE 9052: FOR F=65368 TO 65503: READ A: POKE F,A: NEXT F
9052 DATA 56,68,68,68,56,124,186,186: REM 144 ciudadano
9053 DATA 186,186,170,170,170,168,40,108
9054 DATA 255,129,129,255,255,129,129,255: REM 146 Ladrillo
9055 DATA 12,18,114,18,12,252,12,12: REM 147 Zombie 1
9056 DATA 12,12,20,36,68,68,36,116
9057 DATA 12,18,114,18,12,252,12,12: REM 149 Zombie 2
9058 DATA 12,12,12,12,12,12,10,63
9059 DATA 12,18,114,18,12,252,12,12: REM 151 Zombie 3
9060 DATA 12,12,12,10,10,9,9,54
9061 DATA 127,128,128,128,143,136,136,136: REM 153 Torreta
9062 DATA 254,1,1,1,241,17,17,17
9063 DATA 136,136,136,143,128,128,128,127
9064 DATA 17,17,17,241,1,1,1,254
9065 DATA 126,129,129,153,153,129,129,126: REM 157 Torreta pequena
9066 DATA 0,0,0,0,0,0,66,126: REM 158 Espacio
9067 DATA 129,90,36,90,90,36,90,129: REM 159 Cursor
9068 DATA 240,248,248,240,240,248,248,240: REM 160 Separador
9073 RETURN
9995 REM El programa utiliza BASIC de ZX Spectrum, con lo cual no puede utilizar las ordenes ELSE, END IF, o el operador MOD
9996 REM Se debe optimizar al maximo el uso de CPU, reduciendo los ciclos de reloj
9997 REM El uso de memoria no es problema, asi que se pueden crear variables auxiliares si asi se optimiza el codigo
9998 REM Es preferible tener menos lineas aunque sean muy largas. Igualmente, es mejor que los REM estén siempre acompañando a otra linea, no solos
9999 REM No se pueden crear lineas mas alla de la 9999