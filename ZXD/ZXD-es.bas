   1 CLEAR 64000: DIM m(23,32): DIM c(10,3): DIM z(10,5): DIM l(20,3): DIM t(10,6): LET r=20: LET cx=7: LET cy=10: LET tiempo=0:LET dificultad=0
   2 LET te=0: LET k$="": LET ox=0: LET oy=0: LET o=0: LET nz=0: LET nl=0: LET nt=0: LET nc=0: LET tir=0: LET tiz=0: LET cm=0: LET cc=0: LET w=0: LET x=0: LET y=0: LET sp=0: LET dp=0: LET seconds=0: LET oldseconds=0: LET puntos=0
   3 LET maxc=5: LET maxz=10: LET tv=3: LET lv=3: LET rcl=2: DIM h(3): LET nivel=1: LET maxtiempo=200: LET h(1)=10: LET h(2)=15: LET h(3)=25
  10 BORDER 1: PAPER 0: INK 7: CLS
  11 LOAD "ZXDFONT" CODE 64000: LOAD "ZXDSCRN" CODE 16384: POKE 23606,0: POKE 23607,INT 249: REM Carga el Font en 64000 y apunta a esa direccion
  12 PRINT AT 21,0; PAPER 7; INK 0; FLASH 1;"        PULSA UNA TECLA         ": PAUSE 0: CLS
  13 PRINT AT 21,28;PAPER 0;INK 7;"v1.1"
  15 PRINT AT 4,13; BRIGHT 1; INK 2;"Z"; BRIGHT 0; INK 4;"OMBIE";AT 5,11; BRIGHT 1; INK 2;"X"; BRIGHT 0; INK 4;"TINCTION";AT 6,12; BRIGHT 1; INK 2;"D"; BRIGHT 0; INK 4;"EFENSE.": PAPER 7: INK 0: PRINT AT 10,7; FLASH 1; INK 6; PAPER 2;" "; FLASH 0; INK 0; PAPER 7;"Inicializando..."; INK 2; PAPER 6; FLASH 1;" "; FLASH 0; INK 4; PAPER 0;AT 15,11; INK 2; BRIGHT 1;"J"; INK 4; BRIGHT 0;"avi"; INK 2; BRIGHT 1;"P"; INK 4; BRIGHT 0;"rieto";AT 16,10; INK 4;"("; INK 2;"G"; INK 4;"eese"; INK 2;"B"; INK 4;"umps)";AT 17,14; INK 6;"2024"
  20 GO SUB 9000: REM Generar UDG con barra de progreso
  22 GO SUB 1100: REM Intro del nivel
  23 LET tiempo=maxtiempo: LET nz=0: LET nt=0: LET nl=0: LET nc=0: LET r=20: REM Reiniciar contadores principales
  24 POKE 23560,0
  25 RANDOMIZE 0: GO SUB 1000: GO SUB 2000: GO SUB 2050: GO SUB 8700: GO TO 6000
  52 LET op=m(oy+1,ox): IF ox<6 THEN PAPER 5: GO TO 54: REM Redibujar objeto en oy, ox
  53 PAPER 0: IF NOT op AND ox=6 THEN INK 5: PRINT AT oy,ox;CHR$ 160: RETURN
  54 IF NOT op THEN PRINT AT oy,ox;" ": RETURN
  55 IF op<=20 THEN LET ci=INT ((op+1)/2): IF c(ci,3)>0 THEN INK 0: PRINT AT oy,ox;CHR$ (144+1*(c(ci,2)<>oy)): RETURN
  56 IF op<=40 THEN LET li=op-20: IF l(li,3)>0 THEN INK 6: BRIGHT 1: PRINT AT oy,ox;CHR$ 146: BRIGHT 0: RETURN
  57 IF op>80 THEN LET g=INT ((op-81)/2)+1: GO SUB 100: RETURN
  58 LET v=INT ((op-41)/4)+1: IF t(v,4)>0 THEN GO SUB 3330
  59 RETURN
 105 POKE 23675,8: POKE 23676,254: REM Dibujar zombie numero g
 110 IF z(g,1)<6 THEN PAPER 5: GO TO 120
 115 PAPER 0
 120 INK 4: LET z=z(g,3): PRINT AT z(g,2),z(g,1);CHR$ (144+(8*(z=2))+(16*(z=3)))
 125 INK z: PRINT AT z(g,2)+1,z(g,1);CHR$ (145+(8*(z=2)))
 130 POKE 23675,88: POKE 23676,255
 150 RETURN
1005 CLS : INK 5: REM Inicializar pantalla
1010 FOR y=0 TO 21
1020 PAPER 5: PRINT AT y,0; INK 1;CHR$ 160; INK 5;"     "; PAPER 0;CHR$ 160
1060 NEXT y
1070 RETURN
1110 INK 7: PAPER 0: CLS : REM Mostrar informacion del nivel
1111 DIM m(23,32): LET maxtiempo=50+25*(nivel-1)
1112 LET maxc=10-nivel: IF maxc<=0 THEN LET maxc=1
1113 IF nivel>3 THEN LET h(1)=11+nivel: LET h(2)=16+nivel: LET h(3)=25+nivel*2: LET rcl=nivel
1114 IF h(1)>99 THEN LET h(1)=99
1115 IF h(2)>99 THEN LET h(2)=99
1116 IF h(3)>99 THEN LET h(3)=99
1117 IF rcl>9 THEN LET rcl=9
1120 PRINT AT 0,0; PAPER 7; INK 0; FLASH 1;"             NIVEL ";nivel;"            "
1121 IF NIVEL=1 THEN PRINT AT 1,0; BRIGHT 1;" Evita que los  zombies lleguen ";AT 2,0;" a la izquierda  de la pantalla "
1122 IF NIVEL=2 THEN PRINT AT 1,0; BRIGHT 1;"Aparece un nuevo  tipo de zombie";AT 2,0;"  Cada vez hay  menos defensas  "
1123 IF NIVEL=3 THEN PRINT AT 1,0; BRIGHT 1;"   Aparecen todos los zombies   ";AT 2,0;"En cada nivel  aumenta el tiempo"
1124 IF NIVEL=4 THEN PRINT AT 1,0; BRIGHT 1;"      A partir de este nivel    ";AT 2,0;"Suben los costes  de los objetos"
1125 IF NIVEL>4 THEN PRINT AT 1,0; BRIGHT 1;"           ENHORABUENA          ";AT 2,0;"POCOS JUGADORES LLEGAN TAN LEJOS"
1126 PRINT AT 4,0; INK 6;"   ESPACIO"; INK 7;": Modo construccion"
1127 PRINT AT 5,0; INK 6;"         D"; INK 7;": disparar torretas"
1128 PRINT AT 6,0;"  (explotan tras  varios usos)"
1129 PRINT AT 8,0; INK 3; BRIGHT 1;"CONSTRUCCIONES:"
1130 PRINT AT 9,0;"   Disparo simple               "
1131 PRINT AT 10,0;"   "; INK 6;h(1); INK 7;" recursos            "
1132 PRINT AT 11,0;"             Radio 2 casillas   "
1134 PRINT AT 12,0;"                  "; INK 6;h(2); INK 7;" recursos   "
1136 PRINT AT 13,0;"   Mata de un disparo"
1137 PRINT AT 14,0;"   "; INK 6;h(3); INK 7;" recursos            "
1138 PRINT AT 15,13;"Ralentiza zombies "; BRIGHT 1; INK 6;CHR$ (146)
1139 PRINT AT 16,20; INK 6;rcl; INK 7;" recursos "; BRIGHT 1; INK 6;CHR$ (146)
1140 POKE 23675,176: POKE 23676,254
1141 PRINT AT 9,0; INK 2;CHR$ (144);CHR$ (145);AT 10,0;CHR$ (146);CHR$ (147):
1142 PRINT AT 11,30; INK 3;CHR$ (148);CHR$ (149);AT 12,30;CHR$ (150);CHR$ (151):
1143 PRINT AT 13,0; INK 4;CHR$ (152);CHR$ (153);AT 14,0;CHR$ (154);CHR$ (155):
1149 POKE 23675,88: POKE 23676,255
1150 PRINT AT 17,0; INK 3; BRIGHT 1;"ZOMBIES:"
1152 IF dificultad=0 THEN PRINT AT 18,0;"  Lento      Rapido    Muy lento"
1153 IF dificultad=1 THEN PRINT AT 18,0;"  ";PAPER 4;INK 0;FLASH 1;"Rapido";PAPER 0;INK 7;FLASH 0;"     Rapido    ";PAPER 4;INK 0;FLASH 1;"Rapido";PAPER 0;INK 7;FLASH 0;"   "
1154 PRINT AT 19,0;"  Normal     Debil     Tanque   "
1160 POKE 23675,8: POKE 23676,254
1161 PRINT AT 18,0; INK 4;CHR$ (144);AT 18,11;CHR$ (152);AT 18,21;CHR$ (160)
1162 PRINT AT 19,0; INK 1;CHR$ (145); INK 2;AT 19,11;CHR$ (153);AT 19,21; INK 3;CHR$ (145)
1163 IF nivel=1 THEN PRINT AT 18,13; INK 2;"Futuros ";AT 19,13;"Niveles "
1164 IF nivel<3 THEN PRINT AT 18,23; INK 2;"Futuros  ";AT 19,23;"Niveles  "
1169 POKE 23675,88: POKE 23676,255
1170 PRINT AT 20,0; PAPER 7; INK 0;"     TIEMPO A AGUANTAR: "; INK 1;maxtiempo;"s   ";AT 20,28;"    "
1180 PRINT AT 21,0; PAPER 7; INK 0; FLASH 1;"        PULSA UNA TECLA         "
1200 LET k$=INKEY$
1215 IF k$="s" OR k$="S" THEN GO TO 8800
1220 IF k$="" THEN GO TO 1200
1230 IF INKEY$=" " THEN GO TO 1230: REM Espera a que se suelte la tecla de espacio
1299 RETURN
2001 FOR b=1 TO maxc: REM Colocar ciudadanos inicialmente
2002 LET c(b,1)=INT (RND*5)+1: LET c(b,2)=INT (RND*19)+1: LET c(b,3)=5
2010 IF m(c(b,2)+1,c(b,1))>0 OR m(c(b,2)+2,c(b,1))>0 THEN GO TO 2002
2020 PAPER 5: INK 0: PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2)+1,c(b,1))=b*2-1: LET m(c(b,2)+2,c(b,1))=b*2: LET nc=nc+1: NEXT b: RETURN
2051 LET nl=0: REM Colocar ladrillos inicialmente
2052 FOR b=1 TO maxc: REM Coloca inicialmente tantos ladrillos como ciudadanos
2053 LET l(b,1)=INT (RND*3)+8: LET l(b,2)=INT (RND*20)+1: LET l(b,3)=3
2054 IF m(l(b,2)+1,l(b,1))>0 THEN GO TO 2053
2055 PAPER 0: INK 6: BRIGHT 1: PRINT AT l(b,2),l(b,1);CHR$ 146: BRIGHT 0
2056 LET m(l(b,2)+1,l(b,1))=20+b: LET nl=nl+1
2057 NEXT b
2058 RETURN
3000 REM Comprobar si podemos colocar objeto
3010 IF (NOT te AND r<rcl) THEN BEEP 0.2,10: RETURN : REM No hay recursos para un ladrillo
3020 IF te THEN IF r<h(te) THEN BEEP 0.2,10: RETURN : REM No hay recursos para una torreta
3025 LET o=m(cy+1,cx): IF NOT o THEN GO SUB 3100: RETURN : REM Posible en principio
3030 BEEP 0.2,10: RETURN : REM Casilla ocupada
3100 REM Colocar objeto en el mapa
3110 IF NOT te AND nl<20 THEN LET r=r-rcl: INK 6: BRIGHT 1: PRINT AT cy,cx;CHR$ 146: BRIGHT 0: LET m(cy+1,cx)=20+nl+1: LET nl=nl+1: LET l(nl,1)=cx: LET l(nl,2)=cy: LET l(nl,3)=lv
3120 IF te>0 AND nt<10 AND oy<20 THEN GO SUB 3200: IF NOT o THEN GO SUB 3300: BEEP 0.05,50: RETURN
3130 BEEP 0.5,10: RETURN : REM Celdas adyacentes ocupadas
3210 LET o=0: REM Comprobar si las celdas adyacentes estan libres para colocar torreta
3214 IF cx+1>31 OR cy+1>21 THEN LET o=1: RETURN : REM No coloca fuera de limites
3215 IF (cx=5 OR cx=6) THEN LET o=1: RETURN : REM No coloca en separador
3220 IF m(cy+1,cx)>0 OR m(cy+1,cx+1)>0 OR m(cy+2,cx)>0 OR m(cy+2,cx+1)>0 THEN LET o=1
3225 RETURN
3310 LET m(cy+1,cx)=40+(nt*4)+1: LET m(cy+2,cx)=40+(nt*4)+2: LET m(cy+1,cx+1)=40+(nt*4)+3: LET m(cy+2,cx+1)=40+(nt*4)+4: REM Colocar torreta de tipo "te" en cx, cy
3320 LET r=r-h(te): LET nt=nt+1: LET v=nt: LET t(nt,1)=cx: LET t(nt,2)=cy: LET t(nt,3)=te: LET t(nt,4)=tv: LET t(nt,5)=0: LET t(nt,6)=3+(1*(te=2)): REM Inicializa torreta con vida tv (+1 si es torreta tipo 2) y 3 usos (4 si es de tipo 2)
3330 POKE 23675,176: POKE 23676,254: REM Subsubrutina de pintar torreta
3331 LET desp=(t(v,3)-1)*4
3332 INK t(v,3)+1: PAPER 0+(5*(t(v,1)<6)): PRINT AT t(v,2),t(v,1);CHR$ (144+desp);CHR$ (145+desp);AT t(v,2)+1,t(v,1);CHR$ (146+desp);CHR$ (147+desp)
3333 POKE 23675,88: POKE 23676,255
3340 RETURN
5010 IF nz>=maxz THEN RETURN : REM Generar zombie
5011 LET nz=nz+1
5015 LET z(nz,3)=1+(nivel>1)*(RND>0.5)+(nivel>2)*(RND<0.25): REM Nv1:1(siempre), Nv2:1-2(al 50%), Nv3+:1(37.5%)2(50%)3(12.5%)
5020 LET z(nz,1)=31: LET z(nz,4)=0: LET z(nz,5)=1+(1*(z(nz,3)=1))+(3*(z(nz,3)=3)): REM Vida zombies: 2 para T1, 1 para T2, 4 para T3
5030 LET z(nz,2)=INT (RND*19)+1
5031 IF m(z(nz,2)+1,z(nz,1))>0 OR m(z(nz,2)+2,z(nz,1))>0 THEN GO TO 5030
5040 LET g=nz: GO SUB 100: LET m(z(nz,2)+1,z(nz,1))=80+(nz*2)-1: LET m(z(nz,2)+2,z(nz,1))=80+(nz*2)
5050 BEEP 0.05,20: RETURN
6010 IF NOT cm THEN GO SUB 7000: GO SUB 7200: GO SUB 7300: REM Bucle principal del juego
6020 IF tiempo<=0 THEN GO TO 9800: REM Comprobar si se ha alcanzado el tiempo maximo
6040 GO TO 6000
7001 IF nz=0 THEN RETURN : REM Mover zombies
7005 LET g=1
7010 LET ox=z(g,1): LET oy=z(g,2): LET z=z(g,3): IF z(g,1)=1 THEN GO TO 7045: REM Saltar si el zombie esta en la columna 1
7011 IF m(oy+1,ox-1)+m(oy+2,ox-1)>0 THEN GO TO 7040: REM Ir a chocar con objeto si hay algo delante
7020 LET z(g,4)=z(g,4)+2+(2*(z<>3)): IF dificultad=0 AND z(g,4)<8 AND z<>2 THEN GO TO 7045: REM Saltar si no es momento de moverse
7030 LET m(oy+1,ox)=0: LET m(oy+2,ox)=0: GO SUB 50: LET oy=oy+1: GO SUB 50: LET oy=oy-1: REM Borrar zombie de la posicion anterior
7031 LET ox=ox-1: LET z(g,1)=ox: LET z(g,4)=0: IF ox=1 THEN GO SUB 9700: RETURN : REM Game over si el zombie llega a la columna 1
7032 GO SUB 8170: GO SUB 100: IF ox=5 THEN PRINT PAPER 0; INK 5;AT oy,ox+1;CHR$ (160);AT oy+1,ox+1;CHR$ (160): GO TO 7035
7033 IF ox<5 THEN PAPER 5
7034 PRINT AT oy,ox+1;" ";AT oy+1,ox+1;" "
7035 BEEP 0.01,5: LET m(oy+1,ox)=80+(g*2)-1: LET m(oy+2,ox)=80+(g*2): GO TO 7045: REM Actualizar mapa y ontinuar con el siguiente zombie
7040 GO SUB 7100: REM Procesar colision con objeto
7045 GO SUB 7440: IF sp=1 OR dp=1 THEN RETURN : REM Salir si se presiona espacio o D
7050 LET g=g+1: IF g>nz THEN RETURN
7055 GO TO 7010: REM Procesar el siguiente zombie
7110 LET ob=m(z(g,2)+1,z(g,1)-1): IF NOT ob OR ob>80 THEN LET ob=m(z(g,2)+2,z(g,1)-1): IF NOT ob OR ob>80 THEN RETURN : REM Zombie encuentra objeto
7120 LET col=7: LET matado=0: IF ob<=20 THEN LET t=INT ((ob+1)/2): LET c(t,3)=c(t,3)-1: LET col=0: GO TO 7150
7130 IF ob<=40 THEN LET t=ob-20: LET l(t,3)=l(t,3)-1: LET col=4: GO TO 7150
7140 IF ob<=80 THEN LET t=INT ((ob-41)/4)+1: LET t(t,4)=t(t,4)-1: LET col=t(t,3)+1
7150 POKE 23675,8: POKE 23676,254: PAPER 0+(5*(z(g,1)<6)): FLASH 1
7151 PRINT AT z(g,2),z(g,1); INK 4;CHR$ (150+(8*(z=2))); INK z;AT z(g,2)+1,z(g,1);CHR$ (151+(8*(z=2)))
7155 FOR w=1 TO 10: BORDER z: BEEP 0.01,50: BORDER col: BEEP 0.01,60: NEXT w: BORDER 1
7156 FLASH 0: GO SUB 100
7157 IF ob<=20 THEN IF c(t,3)<=0 THEN LET matado=1: LET c(t,3)=0: LET z(g,5)=z(g,5)-1: REM Mata ciudadano, pero zombie pierde 1 vida
7158 IF ob>20 AND ob<=40 THEN IF l(t,3)<=0 THEN LET matado=1: LET l(t,3)=0
7159 IF ob>40 AND ob<=80 THEN IF t(t,4)<=0 THEN LET matado=1: LET t(t,4)=0
7160 IF matado THEN GO SUB 7600
7165 IF z(g,5)=0 THEN LET j=g: GO SUB 7791
7170 RETURN
7201 LET seconds=INT ((65536*PEEK 23674+256*PEEK 23673+PEEK 23672)/50): REM Actualizar puntuacion, recursos y tiempo
7202 IF seconds<>oldseconds THEN LET oldseconds=seconds: LET tiempo=tiempo-1: LET puntos=puntos+1: GO SUB 7453
7205 GO SUB 7440
7210 IF tir>=2 THEN LET r=r+(1*r<100): REM cada 2 ticks suben los recursos, hasta 100
7220 IF tiz>=4 THEN LET tiz=0: GO SUB 5000: RETURN : REM cada 4 ticks sale un zombie
7240 LET tir=tir+1: LET tiz=tiz+1
7320 IF PEEK 23560=32 OR sp THEN POKE 23560,0: IF cm=0 THEN LET cm=1: LET cc=0: LET sp=0: GO SUB 7330: REM Si estamos pulsando espacio o lo habiamos pulsdo antes, entramos a modo construccion
7325 IF PEEK 23560=68 OR PEEK 23560=100 OR dp THEN POKE 23560,0: GO SUB 7500: LET dp=0: GO SUB 7450: REM Disparar torretas
7329 RETURN
7331 BORDER 2: PRINT #0;AT 0,0; PAPER 2; INK 7;" CONTROLES "; PAPER 7; INK 1;"QAOP"+CHR$ (158);" +  0"; INK 6; PAPER 0; BRIGHT 1;CHR$ 146; INK 1; PAPER 7; BRIGHT 0;" 1"; INK 2;CHR$ 153; INK 1;" 2"; INK 3;CHR$ 154; INK 1;" 3"; INK 4;CHR$ 155;" ": REM Modo de construccion
7332 PRINT #0;AT 1,0; PAPER 2; INK 7; FLASH 1;"CONSTRUCCION"; FLASH 0; PAPER 6; INK 0;"Rec:                "; INK 1;AT 1,16;r;"  ";AT 1,21;rcl;AT 1,23;h(1);AT 1,26;h(2);AT 1,29;h(3)
7333 GO SUB 8000
7334 POKE 23560,0
7335 LET cc=cc+1: IF cc=500 THEN GO SUB 8050: GO SUB 8700: LET cm=0: LET cc=0: BORDER 1: RETURN
7350 LET ox=cx: LET oy=cy
7351 IF IN 32766=190 THEN POKE 23560,0: IF cc>5 THEN GO SUB 8050: LET cm=0: LET cc=0: LET sp=0: PRINT AT oy,ox;" ": GO SUB 7450: GO SUB 50: BORDER 1: RETURN : REM Salida del modo de construccion
7360 IF IN 64510=190 AND cy>0 THEN LET cy=cy-1
7370 IF IN 65022=190 AND cy<20 THEN LET cy=cy+1
7380 IF IN 57342=189 AND cx>1 THEN LET cx=cx-1
7390 IF IN 57342=190 AND cx<30 THEN LET cx=cx+1
7400 IF (IN 63486<>191 OR IN 61438<>191) THEN LET k$=INKEY$: IF k$>="0" AND k$<="3" THEN LET te=VAL k$: GO SUB 3000: GO TO 7331
7410 IF ox<>cx OR oy<>cy THEN GO SUB 8050: GO SUB 50: GO SUB 8000: LET ox=cx: LET oy=cy: REM Si hemos movido el cursor, redibuja
7420 GO TO 7334
7442 IF PEEK 23560=32 THEN POKE 23560,0: LET sp=1: GO TO 7450: REM Comprueba teclas durante fases secundarias del juego
7443 IF PEEK 23560=68 OR PEEK 23560=100 THEN POKE 23560,0: IF sp=0 THEN LET dp=1: GO TO 7450
7444 RETURN
7450 REM Pinta el marcador en modo principal
7451 PRINT #0;AT 0,0; PAPER 2; INK 7;" CONTROLES "; PAPER 7; INK 1; FLASH sp;CHR$ 158; FLASH 0; INK 0;"Construir - "; INK 1; FLASH dp;"D"; FLASH 0; INK 0;"isparar"
7452 PRINT #0; INK 0; PAPER 6;AT 1,0;"Recursos:    Tiempo:     P:     ": PAPER 0:
7453 PRINT #0; INK 1; PAPER 6;AT 1,9;r;"  ";AT 1,20;tiempo;" ";AT 1,27;puntos
7455 RETURN
7505 LET disparos=0: REM Torretas disparan
7510 LET i=1
7515 IF t(i,4)<=0 THEN GO TO 7590
7530 LET t(i,5)=0: LET tx=t(i,1)+1: LET ty=t(i,2)+1
7535 LET v=i: IF t(v,4)>0 THEN BRIGHT 1: GO SUB 3330: BRIGHT 0
7540 LET j=1
7542 IF t(i,6)<=0 THEN GO TO 7583
7550 IF z(j,5)<=0 THEN GO TO 7580: REM Zombie ya muerto
7551 LET dx=z(j,1)-t(i,1): LET dy=z(j,2)-t(i,2)
7552 IF t(i,3)=2 THEN GO TO 7570: REM Torreta tipo 2, tratamiento especial
7553 IF dx<=0 OR ABS (dy)>1 THEN GO TO 7580: REM Torreta tipo 1 o 3, solo dispara a la derecha y +/-1 en y
7554 LET lineax=z(j,1): LET lineay=t(i,2): IF z(j,2)=t(i,2)+1 THEN LET lineay=t(i,2)+1
7555 INK 6: FOR w=tx TO lineax-1
7556 IF  SCREEN$ (lineay,w)=" " THEN PAPER 0+5*(w<6): PRINT AT lineay,w;CHR$ (156+(t(i,3)=3)): BEEP 0.02,15: PRINT AT lineay,w;" ": GO TO 7558: REM pinta disparo
7558 NEXT w: PAPER 0
7559 LET disparos=disparos+1: GO SUB 7700: REM Quita vida al zombie
7563 GO TO 7540: REM Vuelve a mirar todos los zombies
7570 IF ABS (dx)>3 OR ABS (dy)>3 THEN GO TO 7580: REM Fuera de rango
7572 LET disparos=disparos+1: GO SUB 7700: GO TO 7540: REM Quita vida al zombie y vuelve a empezar a buscar zombies desde cero
7582 LET j=j+1: IF j<=nz THEN GO TO 7541
7583 IF t(i,6)<=0 THEN LET t=i: GO SUB 7640: LET i=0: GO TO 7590: REM Si ya no le quedan disparos, explota y vuelve a empezar las torretas desde cero
7585 IF t(v,4)>0 THEN BRIGHT 0: GO SUB 3330
7590 LET i=i+1: IF i<=nt THEN GO TO 7515
7591 IF disparos=0 THEN RETURN
7592 GO TO 7500: REM Sigue disparando hasta que no se pueda mas
7600 REM Zombie g ha chocado con objeto ob
7610 IF ob<=20 THEN LET m(c(t,2)+1,c(t,1))=0: LET m(c(t,2)+2,c(t,1))=0: LET ox=c(t,1): LET oy=c(t,2): GO SUB 50: LET oy=oy+1: GO SUB 50: LET c(t,3)=0: LET nc=nc-1: GO SUB 9100: REM Eliminar ciudadano, y quitar 1 de vida a zombie
7620 IF ob>20 AND ob<=40 THEN LET m(l(t,2)+1,l(t,1))=0: LET ox=l(t,1): LET oy=l(t,2): GO SUB 50: LET l(t,3)=0: GO SUB 9200: REM Eliminar ladrillo
7630 IF ob<=40 OR ob>80 THEN GO TO 7660: REM Si no es torreta, termina
7640 LET m(t(t,2)+1,t(t,1))=0: LET m(t(t,2)+2,t(t,1))=0: LET m(t(t,2)+1,t(t,1)+1)=0: LET m(t(t,2)+2,t(t,1)+1)=0: LET ox=t(t,1): LET oy=t(t,2)
7650 INK 6: PAPER 2: FLASH 1: PRINT AT t(t,2),t(t,1);CHR$ (147);CHR$ (148);AT t(t,2)+1,t(t,1);CHR$ (149);CHR$ (150): REM Explosion
7655 FOR x=1 TO 10: BEEP 0.02,INT (RND*20): NEXT X
7658 INK 7: PAPER 0+(5*(t(t,1)<6)): FLASH 0: PRINT AT t(t,2),t(t,1);"  ";AT t(t,2)+1,t(t,1);"  ": LET t(t,4)=0: GO SUB 9300
7660 BEEP 0.05,0: RETURN
7705 FOR w=1 TO 2: REM Disparo de torreta "i" a zombie "j"
7710 FLASH 1: OVER 1: PAPER 0+5*(t(i,1)<6)
7720 INK t(i,3)+1: PRINT AT t(i,2),t(i,1);"  ";AT t(i,2)+1,t(i,1);"  "
7725 PAPER 0+5*(z(j,1)<6)
7730 PRINT AT z(j,2),z(j,1); INK 4;" ";AT z(j,2)+1,z(j,1); INK z(j,3);" "
7740 BEEP 0.02,50: BEEP 0.02,40
7750 FLASH 0: PAPER 0+5*(t(i,1)<6)
7760 INK t(i,3)+1: PRINT AT t(i,2),t(i,1);"  ";AT t(i,2)+1,t(i,1);"  "
7765 PAPER 0+5*(z(j,1)<6)
7770 PRINT AT z(j,2),z(j,1); INK 4;" ";AT z(j,2)+1,z(j,1); INK z(j,3);" "
7771 NEXT w
7775 OVER 0: PAPER 0
7780 IF t(i,3)=3 THEN LET z(j,5)=0: GO TO 7785: REM La torreta tipo 3 mata siempre
7781 LET z(j,5)=z(j,5)-1
7785 LET t(i,6)=t(i,6)-1
7786 IF t(i,6)<=0 THEN LET t(i,6)=0
7790 IF z(j,5)>0 THEN GO TO 7800
7791 BEEP 0.02,10: BEEP 0.02,20: BEEP 0.02,10: BEEP 0.02,20: BEEP 0.02,10: BEEP 0.02,20: BEEP 0.02,10: BEEP 0.02,20: BEEP 0.02,10: BEEP 0.02,20: LET m(z(j,2)+1,z(j,1))=0: LET m(z(j,2)+2,z(j,1))=0: REM Vacia mapa
7792 LET ox=z(j,1): LET oy=z(j,2): GO SUB 50: LET oy=oy+1: GO SUB 50: REM redibuja
7793 LET puntos=puntos+(10*z(j,3)): GO SUB 9400: GO SUB 7450: REM Elimina zombie y suma puntos
7800 PAPER 0: RETURN
8020 PAPER 0: INK 7: REM Dibujar cursor en cy,cx
8030 FLASH 1: PRINT AT cy,cx;CHR$ (159): FLASH 0: RETURN
8060 PAPER 0+5*(ox<6): PRINT AT oy,ox;" ": RETURN : REM Borrar cursor
8175 POKE 23675,8: POKE 23676,254: REM Dibujar zombie numero g andando
8180 IF ox<6 THEN PAPER 5: GO TO 8182
8181 PAPER 0: INK 4
8182 IF z(g,3)=1 THEN PRINT AT oy,ox;CHR$ 146;CHR$ 147; INK 1;AT oy+1,ox;CHR$ 148;CHR$ 149
8183 IF z(g,3)=2 THEN PRINT AT oy,ox;CHR$ 154;CHR$ 156; INK 2;AT oy+1,ox;CHR$ 155;CHR$ 157
8184 IF z(g,3)=3 THEN PRINT AT oy,ox;CHR$ 161;CHR$ 162; INK 3;AT oy+1,ox;CHR$ 148;CHR$ 149
8185 BEEP 0.01,10
8187 POKE 23675,88: POKE 23676,255
8188 RETURN
8700 REM Dibujar interfaz
8710 PRINT #0;AT 1,0; INK 0; PAPER 7;"                                ";AT 0,0;"                                ";
8715 GO SUB 7450
8717 PAPER 0: RETURN
8800 REM Menu de seleccion de nivel y dificultad
8801 LET j=0:PRINT AT 6,4; PAPER 2; "                         "; AT 14,4; "                         "
8804 FOR i = 7 TO 13
8805 PRINT AT i, 4; PAPER 2; " ";PAPER 0; "                       "; PAPER 2; " "
8810 NEXT i
8815 PRINT AT 8, 11; PAPER 0; INK 4; BRIGHT 1; "MENU SECRETO"
8820 PRINT AT 10, 6; "SELECCIONAR  NIVEL: ";FLASH (j=0);nivel
8825 PRINT AT 12, 7; "DIFICULTAD: ";INK 2;
8826 IF dificultad=0 THEN PRINT FLASH (j=1);" FACIL "
8827 IF dificultad=1 THEN PRINT FLASH (j=1);"DIFICIL"
8828 LET k$=INKEY$
8829 IF k$="" THEN GO TO 8828
8830 IF k$="q" OR k$="Q" OR k$="a" OR k$="A" THEN LET j=1-j
8831 IF j=1 THEN GO TO 8835
8832 IF k$="o" OR k$="O" THEN IF nivel>1 THEN LET nivel=nivel-1
8833 IF k$="p" OR k$="P" THEN IF nivel<9 THEN LET nivel=nivel+1
8834 GO TO 8840
8835 IF k$="o" OR k$="O" OR k$="p" OR k$="P" THEN LET dificultad=1-dificultad
8840 IF k$=" " THEN GO TO 1100
8850 GO TO 8820
9000 REM Generacion de UDG con barra de progreso
9001 INK 6: PAPER 0: PRINT AT 12,0;"                                "
9002 LET total=(65535-65358)+(65295-65032)+1: LET progreso=0: RESTORE 9012
9003 LET F=65368
9004 READ A: POKE F,A
9005 LET progreso=progreso+1: IF progreso-INT (progreso/32)*32=0 THEN PRINT AT 12,INT (progreso/total*32);".";
9006 LET F=F+1: IF F=65536 THEN LET F=65032
9007 IF F<>65296 THEN GO TO 9004
9008 RETURN
9009 REM UDG estandar (POKE 23675,88: POKE 23676,255)
9010 REM 144/145 Ciudadano, 146 Ladrillo, 147-150 Explosion, 153-155 Torretas,
9011 REM 156 Disparo simple, 157 Disparo grande, 158 Espacio, 159 Cursor, 160 Separador
9012 DATA 112,248,248,144,140,136,112,224
9013 DATA 240,248,184,216,240,96,120,124
9014 DATA 255,129,165,153,153,165,129,255
9015 DATA 1,226,90,36,16,16,96,128
9016 DATA 4,138,178,68,8,8,6,1
9017 DATA 64,48,8,16,16,39,72,48
9018 DATA 6,8,8,4,20,42,166,64
9019 DATA 0,0,0,0,0,0,0,0
9020 DATA 0,0,0,0,0,0,0,0
9021 DATA 126,135,135,135,126,248,188,252
9022 DATA 24,126,153,153,66,60,94,126
9023 DATA 127,240,252,248,126,248,188,252
9024 DATA 0,0,0,85,0,0,0,0
9025 DATA 0,170,0,85,0,170,0,0
9026 DATA 0,0,0,0,0,0,66,126
9027 DATA 129,90,36,90,90,36,90,129
9028 DATA 240,248,248,240,240,248,248,240
9029 DATA 1,226,90,36,16,16,96,128
9030 DATA 4,138,178,68,8,8,6,1
9031 DATA 64,48,8,16,16,39,72,48
9032 DATA 6,8,8,4,20,42,166,64
9033 REM UDG en 65032 - Zombies (POKE 23675,8: POKE 23676,254)
9034 REM Zombie 1 - Quieto: 144/145 - Andar 146-147/148-149 - Morder 150/151 - Color 4/1
9035 REM Zombie 2 - Quieto: 152/153 - Andar 154-156/155-157 - Morder 158/159 - Color 4/2
9036 REM Zombie 3 - Quiero: 160/145 - Andar 161-162/148-149 - Morder 150/151 - Color 4/3
9037 DATA 28,62,46,126,30,12,252,156
9038 DATA 28,28,28,44,44,44,44,124
9039 DATA 1,3,2,7,1,0,15,8
9040 DATA 192,224,224,224,224,192,192,192
9041 DATA 1,1,3,7,12,44,56,24
9042 DATA 192,192,192,96,112,56,24,48
9043 DATA 56,124,92,252,24,184,88,56
9044 DATA 24,24,56,56,44,102,99,198
9045 DATA 0,0,0,12,22,30,12,124
9046 DATA 12,12,12,12,20,18,18,54
9047 DATA 0,0,0,1,2,3,1,15
9048 DATA 1,1,1,3,4,4,2,6
9049 DATA 0,0,0,128,192,192,128,128
9050 DATA 128,128,128,128,192,96,48,16
9051 DATA 0,0,0,24,44,188,88,56
9052 DATA 24,24,24,24,40,76,38,98
9053 DATA 60,94,126,126,60,60,28,252
9054 DATA 3,5,7,7,3,7,15,25
9055 DATA 192,192,192,224,224,240,216,196
9056 DATA 0,0,0,0,0,0,0,0
9057 DATA 0,0,0,0,0,0,0,0
9058 REM UDG en 65200 - Torretas (POKE 23675,176: POKE 23676,254)
9059 REM Torreta 1 - 144-145/146-147
9060 REM Torreta 2 - 148-149/150-151
9061 REM Torreta 3 - 152-153/154-155
9062 DATA 0,63,64,160,160,176,191,159
9063 DATA 0,254,7,15,15,15,207,207
9064 DATA 64,63,47,95,95,95,95,255
9065 DATA 6,252,192,224,224,224,224,240
9066 DATA 1,2,62,94,190,191,95,39
9067 DATA 128,64,124,122,125,253,250,228
9068 DATA 24,7,11,23,23,23,23,63
9069 DATA 24,224,240,248,248,248,248,252
9070 DATA 16,63,56,63,48,63,56,48
9071 DATA 0,254,5,255,40,248,20,20
9072 DATA 63,62,127,223,191,191,191,255
9073 DATA 248,0,192,224,224,224,224,240
9100 REM Reindexar ciudadanos
9105 IF nc<=1 THEN RETURN
9110 LET i=1
9120 IF NOT c(i,3) THEN LET c(i,1)=c(nc,1): LET c(i,2)=c(nc,2): LET c(i,3)=c(nc,3): LET nc=nc-1: RETURN
9130 LET i=i+1
9140 IF i<=nc THEN GO TO 9120
9150 RETURN
9200 REM Reindexar ladrillos
9205 IF nl<=1 THEN RETURN
9210 LET i=1
9220 IF NOT l(i,3) THEN LET l(i,1)=l(nl,1): LET l(i,2)=l(nl,2): LET l(i,3)=l(nl,3): LET nl=nl-1: RETURN
9230 LET i=i+1
9240 IF i<=nl THEN GO TO 9220
9250 RETURN
9300 REM Reindexar torretas
9310 LET i=1
9320 IF NOT t(i,4) THEN LET t(i,1)=t(nt,1): LET t(i,2)=t(nt,2): LET t(i,3)=t(nt,3): LET t(i,4)=t(nt,4): LET t(i,5)=t(nt,5): LET t(i,6)=t(nt,6): LET nt=nt-1: RETURN
9330 LET i=i+1
9340 IF i<=nt THEN GO TO 9320
9350 RETURN
9400 REM Matar zombie
9410 IF j<nz THEN LET z(j,1)=z(nz,1): LET z(j,2)=z(nz,2): LET z(j,3)=z(nz,3): LET z(j,4)=z(nz,4): LET z(j,5)=z(nz,5)
9420 LET nz=nz-1: RETURN
9700 REM Rutina de GAME OVER
9710 PAPER 0: INK 7: CLS
9720 PRINT AT 10,10; PAPER 2; FLASH 1;" GAME OVER "
9730 PRINT AT 12,7;"Nivel alcanzado: "; INK 2; BRIGHT 1;nivel
9735 PRINT AT 13,5;"Puntuacion final: "; INK 2; BRIGHT 1;puntos
9740 PRINT AT 15,0; PAPER 7; INK 0; FLASH 1;"        PULSA UNA TECLA         "
9750 PAUSE 0
9755 LET puntos=0
9760 LET nivel=1: LET dificultad=0: GO TO 22
9770 RETURN
9800 REM Rutina de ENHORABUENA y pasar al siguiente nivel
9810 PAPER 0: INK 7: CLS
9820 PRINT AT 10,9; PAPER 1; FLASH 1;"  ENHORABUENA  "
9830 LET nivel=nivel+1: LET puntos=puntos+100+r*2+nc*5+dificultad*500
9832 PRINT AT 1,0;INK 1;BRIGHT 1;" TOP SECRET:";BRIGHT 0;" Pulsa ";BRIGHT 1;"S";BRIGHT 0;" en el menu ";AT 2,0;" para saltar a  cualquier nivel "
9840 PRINT AT 12,7;"AVANZAS AL NIVEL: "; INK 2; BRIGHT 1;nivel
9845 PRINT AT 14,5;"Puntos acumulados: "; INK 2; BRIGHT 1;puntos
9850 PRINT AT 21,0; PAPER 7; INK 0; FLASH 1;"        PULSA UNA TECLA         "
9860 PAUSE 0
9870 IF INKEY$=" " THEN GO TO 9870
9880 GO TO 22: REM Volver a la pantalla de informacion del nivel
9900 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, z-zombies, l-ladrillos, t-torretas
9910 REM g-bucle mover zombies, k-tecla pulsada, ox,oy-posicion anterior, m-mapa del juego
9920 REM te-tipo de torreta, r-recursos, tiz-tiempo (zombies), cx,cy-posicion cursor, o-ocupado
9930 REM nz-numero de zombies, nl-numero de ladrillos, nt-numero de torretas, nc-numero de ciudadanos, cm-modo construccion, cc-contador de ciclos, z-temporizador
9935 REM cm=0 modo normal, cm=1 modo contruccion
9940 REM Mapa (m): 0=vacio, 1-20=ciudadano, 21-40=ladrillo, 41-80=torreta, 81-100=zombie
9941 REM Para torretas y zombies, el valor de m tambien codifica el color:
9942 REM Torretas: m = 40 + (nt*4) + (1-4), donde nt es el numero de torreta (0-9) y (1-4) es la parte de la torreta (2x2)
9943 REM El color de la torreta se almacena en t(nt,3) y puede ser 1, 2 o 3
9944 REM Zombies: m = 80 + (nz*2) + (0-1), donde nz es el numero de zombie (1-10) y (0-1) es la parte superior/inferior
9945 REM El color del zombie se almacena en z(nz,3) y puede ser 1, 2 o 3
9946 REM La animacion del zombie se almacena en z(nz,5), con valores 0, 1 o 2
9947 REM La vida de los objetos se almacena en: c(b,3) para ciudadanos, l(nl,3) para ladrillos, t(nt,4) para torretas
9948 REM Ciudadanos: c(b,1)=x, c(b,2)=y, c(b,3)=vida
9949 REM Torretas: t(nt,1)=x, t(nt,2)=y, t(nt,3)=color, t(nt,4)=vida, t(nt,5)=contador de disparo, t(nt,6)=contador de usos
9950 REM Ladrillos: l(nl,1)=x, l(nl,2)=y, l(nl,3)=vida
9951 REM Zombies: z(nz,1)=x, z(nz,2)=y, z(nz,3)=color, z(nz,4)=contador de movimiento, z(nz,5)=vida
9952 REM Variables adicionales: f-bucle para UDG, i-bucle general, j-bucle general, q-array para dibujo de disparos
9953 REM w-bucle general, x-bucle general, y-bucle general
9954 REM Otras variables: maxc-maximo de ciudadanos, maxz-maximo de zombies, tv-vida de torretas, lv-vida de ladrillos
9955 REM rcl-costo de ladrillos, h-array de costos de torretas, nivel-nivel actual, maxtiempo-tiempo maximo del nivel
9956 REM tiempo-tiempo transcurrido, sp-flag de espacio presionado, seconds-segundos transcurridos, oldseconds-segundos anteriores
9957 REM desp-desplazamiento para UDG, matado-flag de objeto destruido, col-color para animacion de colision
9958 REM lineax,lineay-coordenadas para dibujo de linea de disparo, op-valor de objeto en mapa para redibujar
9959 REM ...Y mas cosas que seguro me estoy dejando :)
9999 REM Javi Prieto 2024. Gracias a Migue McLeod por su sorprendente memoria y sabios consejos