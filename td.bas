   1 CLEAR 65031: DIM m(23,32): DIM c(10,3): DIM z(10,5): DIM l(20,3): DIM t(10,6): LET r=20: LET cx=7: LET cy=10: LET tiempo=0
   2 LET te=0: LET k$="": LET ox=0: LET oy=0: LET o=0: LET nz=0: LET nl=0: LET nt=0: LET nc=0: LET tir=0: LET tiz=0: LET cm=0: LET cc=0: LET w=0: LET x=0: LET y=0: LET sp=0: LET dp=0: LET seconds=0: LET oldseconds=0: DIM q(31)
   3 LET maxc=5: LET maxz=10: LET tv=3: LET lv=3: LET rcl=2: DIM h(3): LET nivel=1: LET maxtiempo=200
   4 LET h(1)=10: LET h(2)=15: LET h(3)=30
  10 BORDER 1: PAPER 0: INK 7: CLS
  15 PAPER 7: INK 0: PRINT AT 10,7; FLASH 1; INK 6; PAPER 2;" "; FLASH 0; INK 0; PAPER 7;"INICIALIZANDO..."; INK 2; PAPER 6; FLASH 1;" "; FLASH 0
  20 GO SUB 9500: GO SUB 9600: GO SUB 9060: REM Definir UDG
  22 GO SUB 1100: REM Intro del nivel
  23 LET tiempo=0: LET nz=0: LET nt=0: LET nl=0: LET nc=0: LET r=20: REM Reiniciar contadores principales
  25 RANDOMIZE 0: GO SUB 1000: GO SUB 2000: GO SUB 2050: GO SUB 8700: GO TO 6000
1000 REM Inicializar pantalla
1005 CLS : INK 5
1010 FOR y=0 TO 21
1020 PAPER 5: PRINT AT y,0; INK 1;CHR$ 160; INK 5;"     "; PAPER 0;CHR$ 160
1060 NEXT y
1065 FOR x=1 TO 23: FOR y=1 TO 32: LET m(x,y)=0: NEXT y: NEXT x: REM Reiniciar mapa
1070 RETURN
1100 REM Mostrar informacion del nivel
1110 INK 7: PAPER 0: CLS
1111 LET maxtiempo=50: IF nivel<>1 THEN LET maxtiempo=100*(nivel-1)
1112 LET maxc=10-nivel: IF maxc<=0 THEN LET maxc=1
1113 IF nivel>3 THEN LET h(1)=11+nivel:LET h(2)=16+nivel: LET h(3)=25+nivel*2: LET rcl=nivel
1120 PRINT AT 0,0; PAPER 7; INK 0; FLASH 1;"             NIVEL ";nivel;"            "
1121 IF NIVEL=1 THEN PRINT AT 1,0; BRIGHT 1;" Evita que los  zombies lleguen ";AT 2,0;" a la izquierda  de la pantalla "
1122 IF NIVEL=2 THEN PRINT AT 1,0; BRIGHT 1;"Aparece un nuevo  tipo de zombie";AT 2,0;"  Cada vez hay  menos defensas  "
1123 IF NIVEL=3 THEN PRINT AT 1,0; BRIGHT 1;"   Aparecen todos los zombies   ";AT 2,0;"En cada nivel  aumenta el tiempo"
1124 IF NIVEL>3 THEN PRINT AT 1,0; BRIGHT 1;"      A partir de este nivel    ";AT 2,0;"Suben los costes  de los objetos"
1125 PRINT AT 4,0; INK 6;"   ESPACIO"; INK 7;": Modo construccion"
1126 PRINT AT 5,0; INK 6;"         D"; INK 7;": disparar torretas"
1127 PRINT AT 6,0;"  (explotan tras  varios usos)"
1128 PRINT AT 8,0; INK 3; BRIGHT 1;"CONSTRUCCIONES:"
1129 PRINT AT 9,0;"   Disparo simple               "
1130 PRINT AT 10,0;"   "; INK 6;h(1); INK 7;" recursos            "
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
1152 PRINT AT 18,0;"  Lento      Rapido    Muy lento"
1154 PRINT AT 19,0;"  Normal     Debil     Tanque   "
1160 POKE 23675,8: POKE 23676,254
1161 PRINT AT 18,0; INK 4;CHR$ (144);AT 18,11;CHR$ (152);AT 18,21;CHR$ (160)
1162 PRINT AT 19,0; INK 1;CHR$ (145); INK 2;AT 19,11;CHR$ (153);AT 19,21; INK 3;CHR$ (145)
1163 IF nivel=1 THEN PRINT AT 18,13; INK 2;"Futuros ";AT 19,13;"Niveles "
1164 IF nivel<3 THEN PRINT AT 18,23; INK 2;"Futuros  ";AT 19,23;"Niveles  "
1169 POKE 23675,88: POKE 23676,255
1170 PRINT AT 20,0; PAPER 7; INK 0;"     TIEMPO A AGUANTAR: "; INK 1;maxtiempo;"s   ";AT 20,28;"    "
1180 PRINT AT 21,0; PAPER 7; INK 0; FLASH 1;"        PULSA UNA TECLA         "
1215 PAUSE 0
1220 IF INKEY$="" THEN GO TO 1220
1299 RETURN
2000 REM Colocar ciudadanos inicialmente
2001 FOR b=1 TO maxc
2002 LET c(b,1)=INT (RND*5)+1: LET c(b,2)=INT (RND*19)+1: LET c(b,3)=5
2010 IF m(c(b,2)+1,c(b,1))>0 OR m(c(b,2)+2,c(b,1))>0 THEN GO TO 2002
2020 PAPER 5: INK 0: PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2)+1,c(b,1))=b*2-1: LET m(c(b,2)+2,c(b,1))=b*2: LET nc=nc+1: NEXT b: RETURN
2050 REM Colocar ladrillos inicialmente
2051 LET nl=0
2052 FOR b=1 TO maxc: REM Coloca inicialmente tantos ladrillos como ciudadanos
2053 LET l(b,1)=INT (RND*3)+8: LET l(b,2)=INT (RND*20)+1: LET l(b,3)=3
2054 IF m(l(b,2)+1,l(b,1))>0 THEN GO TO 2053
2055 PAPER 0: INK 6: BRIGHT 1: PRINT AT l(b,2),l(b,1);CHR$ 146: BRIGHT 0
2056 LET m(l(b,2)+1,l(b,1))=20+b: LET nl=nl+1
2057 NEXT b
2058 RETURN
3000 REM Comprobar si podemos colocar objeto
3010 IF (NOT te AND r<rcl) THEN BEEP 0.5,10: RETURN : REM No hay recursos para un ladrillo
3020 IF te THEN IF r<h(te) THEN BEEP 0.5,10: RETURN : REM No hay recursos para una torreta
3025 LET o=m(cy+1,cx): IF NOT o THEN GO SUB 3100: RETURN : REM Posible en principio
3030 BEEP 0.5,10: RETURN : REM Casilla ocupada
3100 REM Colocar objeto en el mapa
3110 IF NOT te AND nl<20 THEN LET r=r-rcl: INK 6: BRIGHT 1: PRINT AT cy,cx;CHR$ 146: BRIGHT 0: LET m(cy+1,cx)=20+nl+1: LET nl=nl+1: LET l(nl,1)=cx: LET l(nl,2)=cy: LET l(nl,3)=lv
3120 IF te>0 AND nt<10 AND oy<20 THEN GO SUB 3200: IF NOT o THEN GO SUB 3300: BEEP 0.05,50: RETURN
3130 BEEP 0.5,10: RETURN : REM Celdas adyacentes ocupadas
3200 REM Comprobar si las celdas adyacentes estan libres para colocar torreta
3210 LET o=0
3214 IF cx+1>31 OR cy+1>21 THEN LET o=1: RETURN : REM No coloca fuera de limites
3215 IF (cx=5 OR cx=6) THEN LET o=1: RETURN : REM No coloca en separador
3220 IF m(cy+1,cx)>0 OR m(cy+1,cx+1)>0 OR m(cy+2,cx)>0 OR m(cy+2,cx+1)>0 THEN LET o=1
3225 RETURN
3300 REM Colocar torreta de tipo "te" en cx, cy
3310 LET m(cy+1,cx)=40+(nt*4)+1: LET m(cy+2,cx)=40+(nt*4)+2: LET m(cy+1,cx+1)=40+(nt*4)+3: LET m(cy+2,cx+1)=40+(nt*4)+4
3320 LET r=r-h(te): LET nt=nt+1: LET v=nt: LET t(nt,1)=cx: LET t(nt,2)=cy: LET t(nt,3)=te: LET t(nt,4)=tv: LET t(nt,5)=0: LET t(nt,6)=2+(1*(te<>2)): REM Inicializa torreta con vida tv y 3 usos (2 para las tipo 2)
3330 POKE 23675,176: POKE 23676,254: REM Subsubrutina de pintar torrea
3331 LET desp=(t(v,3)-1)*4
3332 INK t(v,3)+1: PAPER 0+(5*(t(v,1)<6)): PRINT AT t(v,2),t(v,1);CHR$ (144+desp);CHR$ (145+desp);AT t(v,2)+1,t(v,1);CHR$ (146+desp);CHR$ (147+desp)
3333 POKE 23675,88: POKE 23676,255
3340 RETURN
5000 REM Generar zombie
5010 IF nz>=maxz THEN RETURN
5011 LET nz=nz+1
5015 LET z(nz,3)=1 + (nivel > 1) * (RND > 0.5) + (nivel > 2) * (RND < 0.25): REM Nv1:1(siempre), Nv2:1-2(al 50%), Nv3+:1(37.5%)2(50%)3(12.5%)
5020 LET z(nz,1)=31: LET z(nz,2)=INT (RND*19)+1: LET z(nz,4)=0: LET z(nz,5)=1+(1*(z(nz,3)=1))+(2*(z(nz,3)=3)): REM Vida zombies: 2 para T1, 1 para T2, 4 para T3
5030 IF m(z(nz,2)+1,z(nz,1))>0 OR m(z(nz,2)+2,z(nz,1))>0 THEN LET nz=nz-1: RETURN
5040 LET g=nz: GO SUB 8150: LET m(z(nz,2)+1,z(nz,1))=80+(nz*2)-1: LET m(z(nz,2)+2,z(nz,1))=80+(nz*2)
5050 BEEP 0.05,20: RETURN
6000 REM Bucle principal del juego
6010 IF NOT cm THEN GO SUB 7000: GO SUB 7200: GO SUB 7300
6020 IF tiempo>=maxtiempo THEN GO SUB 9800: REM Comprobar si se ha alcanzado el tiempo máximo
6040 GO TO 6000
7000 REM Mover zombies
7010 FOR g=1 TO nz
7011 GO SUB 7440
7012 IF z(g,1)=1 THEN GO TO 7050: REM Si ya esta a la izquierda no hace nada
7013 IF m(z(g,2)+1,z(g,1)-1)>0 OR m(z(g,2)+2,z(g,1)-1)>0 THEN GO TO 7040: REM Si hay un objeto a la izquierda, va la deteccion de colisiones en vez de intentar mover
7020 IF z(g,3)=2 THEN GO TO 7030: REM Los zombies rapidos mueven cada turno
7021 LET z(g,4)=z(g,4)+2
7022 IF z(g,3)<>3 THEN LET z(g,4)=z(g,4)+2: REM Suma 2 a los lentos, 4 a los normales
7023 IF z(g,4)<8 THEN GO TO 7050: REM Si no toca turno, pasa al siguiente
7032 LET ox=z(g,1): LET oy=z(g,2): LET m(oy+1,ox)=0: LET m(oy+2,ox)=0: REM Vacia en el mapa la casilla actual
7033 GO SUB 8400: LET oy=oy+1: GO SUB 8400: REM Repinta las casillas actuales
7034 LET z(g,1)=z(g,1)-1: LET z(g,4)=0: REM Decrementa la X y resetea el contador de movimiento
7035 IF z(g,1)=1 THEN GO SUB 9700: RETURN : REM Si ha llegado a la izquierda, game over
7036 GO SUB 8170: GO SUB 8150: PRINT AT z(g,2),z(g,1)+1;" ";AT z(g,2)+1,z(g,1)+1;" ": BEEP 0.01,5: LET m(z(g,2)+1,z(g,1))=80+(g*2)-1: LET m(z(g,2)+2,z(g,1))=80+(g*2): REM Dibuja de nuevo el zombie y da un pitido
7037 IF z(g,1)=5 THEN GO SUB 8400: LET oy=oy-1: GO SUB 8400: REM Si hemos pasado por el separador, lo repintamos
7038 GO TO 7050: REM Salta al NEXT
7040 GO SUB 7100: GO TO 7050: REM Procesa colisiones
7050 NEXT g: REM Siguiente zombie
7060 RETURN
7100 REM Zombie encuentra objeto
7110 LET col=7: LET matado=0: LET ob=m(z(g,2)+1,z(g,1)-1): IF NOT ob OR ob>80 THEN LET ob=m(z(g,2)+2,z(g,1)-1): REM ob = objeto colisionado
7115 IF NOT ob OR ob>80 THEN RETURN : REM No colisiona con otros zombies
7120 IF ob<=20 THEN LET t=INT ((ob+1)/2): LET c(t,3)=c(t,3)-1: LET col=0: GO TO 7150: REM Ciudadano
7130 IF ob<=40 THEN LET t=ob-20: LET l(t,3)=l(t,3)-1: LET col=4: GO TO 7150: REM Ladrillo
7140 IF ob<=80 THEN LET t=INT ((ob-41)/4)+1: LET t(t,4)=t(t,4)-1: LET col=t(t,3)+1: GO TO 7150: REM Torreta
7150 POKE 23675,8: POKE 23676,254: PAPER 0: IF z(g,1)<6 THEN PAPER 5
7151 FLASH 1: PRINT AT z(g,2),z(g,1); INK 4;CHR$ (150+(8*(z(g,3)=2))+(13*(z(g,3)=3))); INK z(g,3);AT z(g,2)+1,z(g,1);CHR$ (151+(8*(z(g,3)=2)))
7155 FOR w=1 TO 10: BORDER z(g,3): BEEP 0.01,50: BORDER col: BEEP 0.01,60: NEXT w: BORDER 1: REM Animacion de "pelea"
7156 FLASH 0: GO SUB 8150: REM Quita el flash y repinta el zombie
7157 IF (ob<=20) THEN IF c(t,3)<=0 THEN LET matado=1: LET c(t,3)=0: REM Asegura que la vida no sea negativa
7158 IF (ob>20 AND ob<=40) THEN IF l(t,3)<=0 THEN LET matado=1: LET l(t,3)=0: REM Asegura que la vida no sea negativa
7159 IF (ob>40 AND ob<=80) THEN IF t(t,4)<=0 THEN LET matado=1: LET t(t,4)=0: REM Asegura que la vida no sea negativa
7160 IF matado=1 THEN GO SUB 7600: REM Elimina objeto si ya no tiene vida
7170 RETURN
7200 REM Actualizar puntuacion, recursos y tiempo
7201 LET seconds=INT ((65536*PEEK 23674+256*PEEK 23673+PEEK 23672)/50)
7202 IF seconds<>oldseconds THEN LET oldseconds=seconds: LET tiempo=tiempo+1
7205 GO SUB 7440
7210 IF tir>=2 THEN LET r=r+(1*r<100): REM cada 2 ticks suben los recursos, hasta 100
7220 IF tiz>=5 THEN LET tiz=0: GO SUB 5000: RETURN : REM cada 5 ticks sale un zombie
7240 LET tir=tir+1: LET tiz=tiz+1
7245 GO SUB 7453: REM Actualiza el marcador
7300 LET k$=INKEY$
7320 IF k$=" " OR sp THEN IF cm=0 THEN LET cm=1: LET cc=0: LET sp=0: GO SUB 7330: REM Si estamos pulsando espacio o lo habiamos pulsdo antes, entramos a modo construccion
7325 IF k$="d" OR dp THEN LET dp=0: GO SUB 7450: GO SUB 7500: REM Disparar torretas
7329 RETURN
7330 REM Modo de construccion
7331 PRINT #0;AT 0,0; PAPER 2; INK 7;"CONSTRUCION"; PAPER 7; INK 0;"         Rec:         "; INK 1;AT 0,24;r;"  ";
7332 PRINT #0;AT 1,0; PAPER 7; INK 0;"CONTROLES:"; INK 1;"QAOP0123"+CHR$ (158); INK 0;" 0"; INK 6; PAPER 0; BRIGHT 1;CHR$ 146; INK 2; PAPER 7; BRIGHT 0;" 1";CHR$ 153; INK 3;" 2";CHR$ 154; INK 4;" 3";CHR$ 155
7333 GO SUB 8000
7334 LET k$=INKEY$
7335 BORDER INT (RND*6): LET cc=cc+1: IF cc=100 THEN GO SUB 8050: LET cm=0: LET cc=0: BORDER 1: RETURN
7350 LET ox=cx: LET oy=cy
7351 IF k$=" " THEN IF cc>5 THEN GO SUB 8050: LET cm=0: LET cc=0: LET sp=0: PRINT AT oy,ox;" ": GO SUB 7450: GO SUB 8400: BORDER 1: RETURN : REM Salida del modo de construccion
7360 IF k$="q" AND cy>0 THEN LET cy=cy-1
7370 IF k$="a" AND cy<20 THEN LET cy=cy+1
7380 IF k$="o" AND cx>1 THEN LET cx=cx-1
7390 IF k$="p" AND cx<30 THEN LET cx=cx+1
7400 IF k$>="0" AND k$<="3" THEN LET te=VAL k$: GO SUB 3000: GO TO 7331
7410 IF ox<>cx OR oy<>cy THEN GO SUB 8050: GO SUB 8400: GO SUB 8000: LET ox=cx: LET oy=cy: REM Si hemos movido el cursor, redibuja
7420 GO TO 7334
7440 REM Comprueba teclas durante fases secundarias del juego
7441 LET k$=INKEY$
7442 IF k$=" " THEN LET sp=1: GO TO 7450
7443 IF k$="d" THEN LET dp=1: GO TO 7450
7444 RETURN
7450 REM Pinta el marcador en modo principal
7451 PRINT #0;AT 0,0; PAPER 2; INK 7;" CONTROLES "; PAPER 7; INK 1;FLASH sp;CHR$ 158;FLASH 0; INK 0;"Construir - "; INK 1;FLASH dp;"D";FLASH 0; INK 0;"isparar"
7452 PRINT #0; INK 0; PAPER 7;AT 1,0;"Recursos:         Tiempo:       ": PAPER 0:
7453 PRINT #0; INK 1; PAPER 7;AT 1,9;r;"  ";AT 1,25;tiempo
7455 RETURN
7500 REM Torretas disparan
7505 LET disparos=0
7510 FOR i=1 TO nt
7515 IF t(i,4)<=0 THEN GO TO 7590
7530 LET t(i,5)=0: LET tx=t(i,1)+1: LET ty=t(i,2)+1
7535 LET v=i: IF t(v,4)>0 THEN BRIGHT 1: GO SUB 3330: BRIGHT 0
7540 FOR j=1 TO nz
7541 GO SUB 7440
7550 IF z(j,5)<=0 THEN GO TO 7580: REM Zombie ya muerto
7551 LET dx=z(j,1)-t(i,1): LET dy=z(j,2)-t(i,2)
7552 IF t(i,3)=2 THEN GO TO 7570: REM Torreta tipo 2, tratamiento especial
7553 IF dx<=0 OR ABS (dy)>1 THEN GO TO 7580: REM Torreta tipo 1 o 3, solo dispara a la derecha y +/-1 en y
7554 LET lineax=z(j,1): LET lineay=t(i,2): IF z(j,2)=t(i,2)+1 THEN LET lineay=t(i,2)+1
7555 FOR w=tx TO lineax
7556 LET q(w)=0: IF  SCREEN$ (lineay,w)=" " THEN PRINT INK 6; PAPER 0+5*(w<6);AT lineay,w;CHR$ (156+1*(t(i,3)=3)): LET q(w)=1: REM pinta disparo
7557 NEXT w
7558 LET disparos=disparos+1: GO SUB 7700: REM Quita vida al zombie
7560 FOR w=tx TO lineax
7561 IF q(w)=1 THEN PRINT INK 6; PAPER 0+5*(w<6);AT lineay,w;" ": REM despinta disparo
7562 NEXT w
7563 GO TO 7580
7570 IF ABS (dx)>3 OR ABS (dy)>3 THEN GO TO 7580: REM Fuera de rango
7572 LET disparos=disparos+1: GO SUB 7700: REM Quita vida al zombie
7582 NEXT j
7583 IF t(i,6)<=0 THEN LET t=i: GO SUB 7640: REM Si ya no le quedan disparos, explota
7585 IF t(v,4)>0 THEN BRIGHT 0: GO SUB 3330
7590 NEXT i
7591 IF disparos=0 THEN BEEP 0.5,10
7592 RETURN
7600 REM Eliminar objeto
7610 IF ob<=20 THEN LET m(c(t,2)+1,c(t,1))=0: LET m(c(t,2)+2,c(t,1))=0: LET ox=c(t,1): LET oy=c(t,2): GO SUB 8400: LET oy=oy+1: GO SUB 8400: LET c(t,3)=0: LET nc=nc-1: GO SUB 9100: REM Eliminar ciudadano
7620 IF ob>20 AND ob<=40 THEN LET m(l(t,2)+1,l(t,1))=0: LET ox=l(t,1): LET oy=l(t,2): GO SUB 8400: LET l(t,3)=0: GO SUB 9200: REM Eliminar ladrillo
7630 IF ob<=40 OR ob>80 THEN GO TO 7660: REM Si no es torreta, termina
7640 LET m(t(t,2)+1,t(t,1))=0: LET m(t(t,2)+2,t(t,1))=0: LET m(t(t,2)+1,t(t,1)+1)=0: LET m(t(t,2)+2,t(t,1)+1)=0: LET ox=t(t,1): LET oy=t(t,2)
7650 INK 6: PAPER 2: FLASH 1: PRINT AT t(t,2),t(t,1);CHR$ (161);CHR$ (162);AT t(t,2)+1,t(t,1);CHR$ (163);CHR$ (164): REM Explosion
7655 FOR x=1 TO 10: BEEP 0.02,INT (RND*20): NEXT X
7658 INK 7: PAPER 0+(5*(t(t,1)<6)): FLASH 0: PRINT AT t(t,2),t(t,1);"  ";AT t(t,2)+1,t(t,1);"  ": LET t(t,4)=0: GO SUB 9300
7660 BEEP 0.05,0: RETURN
7700 REM Disparo de torreta "i" a zombie "j"
7705 FOR w=1 TO 2
7710 FLASH 1: OVER 1: PAPER 0+5*(t(i,1)<6)
7720 INK t(i,3)+1: PRINT AT t(i,2),t(i,1);"  ";AT t(i,2)+1,t(i,1);"  "
7725 PAPER 0+5*(z(j,1)<6)
7730 INK z(j,3): PRINT AT z(j,2),z(j,1);" ";AT z(j,2)+1,z(j,1);" "
7740 BEEP 0.1,50: BEEP 0.1,40
7750 FLASH 0: PAPER 0+5*(t(i,1)<6)
7760 INK t(i,3)+1: PRINT AT t(i,2),t(i,1);"  ";AT t(i,2)+1,t(i,1);"  "
7765 PAPER 0+5*(z(j,1)<6)
7770 PRINT AT z(j,2),z(j,1); INK 4;" ";AT z(j,2)+1,z(j,1); INK z(j,3);" "
7771 NEXT w
7775 OVER 0: PAPER 0
7780 IF t(i,3)=3 THEN LET z(j,5)=0: GO TO 7785: REM La torreta tipo 3 mata siempre
7781 LET z(j,5)=z(j,5)-1
7785 LET t(i,6)=t(i,6)-1
7786 IF t(i,6)<=0 THEN LET t(i,6)=0: REM Si va a hacer varios disparos en un turno, deja que los haga todos aunque explote antes
7790 IF z(j,5)>0 THEN GO TO 7800
7791 IF z(j,1)<6 THEN PAPER 5
7795 PRINT AT z(j,2),z(j,1);" ";AT z(j,2)+1,z(j,1);" ": LET m(z(j,2)+1,z(j,1))=0: LET m(z(j,2)+2,z(j,1))=0: GO SUB 9400: REM Matar zombie y reindexar
7800 PAPER 0: RETURN
8000 REM Dibujar cursor en cy,cx
8020 PAPER 0: INK 7
8030 FLASH 1: PRINT AT cy,cx;CHR$ (159): FLASH 0: RETURN
8050 REM Borrar cursor
8060 PRINT AT oy,ox;" ": RETURN
8150 REM Dibujar zombie numero g
8155 POKE 23675,8: POKE 23676,254
8160 IF z(g,1)<6 THEN PAPER 5: GO TO 8162
8161 PAPER 0
8163 INK 4: PRINT AT z(g,2),z(g,1);CHR$ (144+(8*(z(g,3)=2))+(16*(z(g,3)=3)))
8164 INK z(g,3): PRINT AT z(g,2)+1,z(g,1);CHR$ (145+(8*(z(g,3)=2)))
8165 POKE 23675,88: POKE 23676,255
8166 RETURN
8170 REM Dibujar zombie numero g andando
8175 POKE 23675,8: POKE 23676,254
8180 IF z(g,1)<6 THEN PAPER 5: GO TO 8182
8181 PAPER 0: INK 4
8182 IF z(g,3)=1 THEN PRINT AT z(g,2),z(g,1);CHR$ 146;CHR$ 147; INK 1;AT z(g,2)+1,z(g,1);CHR$ 148;CHR$ 149
8183 IF z(g,3)=2 THEN PRINT AT z(g,2),z(g,1);CHR$ 154;CHR$ 156; INK 2;AT z(g,2)+1,z(g,1);CHR$ 155;CHR$ 157
8184 IF z(g,3)=3 THEN PRINT AT z(g,2),z(g,1);CHR$ 161;CHR$ 162; INK 3;AT z(g,2)+1,z(g,1);CHR$ 148;CHR$ 149
8185 BEEP 0.01,10
8187 POKE 23675,88: POKE 23676,255
8188 RETURN
8400 REM Comprobar y redibujar objeto en oy, ox
8410 LET op=m(oy+1,ox)
8420 IF ox<6 THEN PAPER 5: GO TO 8430
8421 PAPER 0: IF ox=6 THEN INK 5: PRINT AT oy,ox;CHR$ 160: RETURN
8430 IF NOT op THEN PRINT AT oy,ox;" ": RETURN
8440 IF op<=20 THEN LET ci=INT ((op+1)/2): IF c(ci,3)>0 THEN INK 0: PRINT AT oy,ox;CHR$ (144+1*(c(ci,2)<>oy)): RETURN
8450 IF op<=40 THEN LET li=op-20: IF l(li,3)>0 THEN INK 6: BRIGHT 1: PRINT AT oy,ox;CHR$ 146: BRIGHT 0: RETURN
8460 IF op<=80 THEN GO TO 8480
8470 LET g=INT ((op-81)/2)+1: GO SUB 8150: RETURN
8480 LET v=INT ((op-41)/4)+1: IF t(v,4)>0 THEN GO SUB 3330: RETURN
8700 REM Dibujar interfaz
8710 PRINT #0;AT 1,0; INK 0; PAPER 7;"                                ";AT 0,0;"                                ";
8715 GO SUB 7450
8717 PAPER 0: RETURN
9000 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, z-zombies, l-ladrillos, t-torretas
9010 REM g-bucle mover zombies, k-tecla pulsada, ox,oy-posicion anterior, m-mapa del juego
9020 REM te-tipo de torreta, r-recursos, tiz-tiempo (zombies), cx,cy-posicion cursor, o-ocupado
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
9049 REM Torretas: t(nt,1)=x, t(nt,2)=y, t(nt,3)=color, t(nt,4)=vida, t(nt,5)=contador de disparo, t(nt,6)=contador de usos
9050 REM Ladrillos: l(nl,1)=x, l(nl,2)=y, l(nl,3)=vida
9051 REM Zombies: z(nz,1)=x, z(nz,2)=y, z(nz,3)=color, z(nz,4)=contador de movimiento, z(nz,5)=vida
9052 REM Variables adicionales: f-bucle para UDG, i-bucle general, j-bucle general, q-array para dibujo de disparos
9053 REM w-bucle general, x-bucle general, y-bucle general
9054 REM Otras variables: maxc-maximo de ciudadanos, maxz-maximo de zombies, tv-vida de torretas, lv-vida de ladrillos
9055 REM rcl-costo de ladrillos, h-array de costos de torretas, nivel-nivel actual, maxtiempo-tiempo maximo del nivel
9056 REM tiempo-tiempo transcurrido, sp-flag de espacio presionado, seconds-segundos transcurridos, oldseconds-segundos anteriores
9057 REM desp-desplazamiento para UDG, matado-flag de objeto destruido, col-color para animacion de colision
9058 REM lineax,lineay-coordenadas para dibujo de linea de disparo, op-valor de objeto en mapa para redibujar
9060 RESTORE 9062: FOR F=65368 TO 65535: READ A: POKE F,A: NEXT F: RETURN
9061 REM UDG estandar (POKE 23675,88: POKE 23676,255) - 144/145 Ciudadano, 146 Ladrillo, 153-155 Torretas, 156 Disparo simple, 157 Disparo grande, 158 Espacio, 159 Cursor, 160 Separador, 161-164 Explosion
9062 DATA 112,248,248,144,140,136,112,224
9063 DATA 240,248,184,216,240,96,120,124
9064 DATA 255,129,165,153,153,165,129,255
9065 DATA 0,0,0,0,0,0,0,0
9066 DATA 0,0,0,0,0,0,0,0
9067 DATA 0,0,0,0,0,0,0,0
9068 DATA 0,0,0,0,0,0,0,0
9069 DATA 0,0,0,0,0,0,0,0
9070 DATA 0,0,0,0,0,0,0,0
9071 DATA 126,135,135,135,126,248,188,252
9072 DATA 24,126,153,153,66,60,94,126
9073 DATA 127,240,252,248,126,248,188,252
9074 DATA 0,0,0,85,0,0,0,0
9075 DATA 0,170,0,85,0,170,0,0
9076 DATA 0,0,0,0,0,0,66,126
9077 DATA 129,90,36,90,90,36,90,129
9078 DATA 240,248,248,240,240,248,248,240
9079 DATA 1,226,90,36,16,16,96,128
9080 DATA 4,138,178,68,8,8,6,1
9081 DATA 64,48,8,16,16,39,72,48
9082 DATA 6,8,8,4,20,42,166,64
9100 REM Reindexar ciudadanos
9110 LET i=1
9120 IF NOT c(i,3) THEN LET c(i,1)=c(nc,1): LET c(i,2)=c(nc,2): LET c(i,3)=c(nc,3): LET nc=nc-1: RETURN
9130 LET i=i+1
9140 IF i<=nc THEN GO TO 9120
9150 RETURN
9200 REM Reindexar ladrillos
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
9410 IF j=nz THEN GO TO 9430: REM Si era el ultimo zombie, ahora hay uno menos
9420 LET z(j,1)=z(nz,1): LET z(j,2)=z(nz,2): LET z(j,3)=z(nz,3): LET z(j,4)=z(nz,4): LET z(j,5)=z(nz,5)
9430 LET nz=nz-1
9440 RETURN
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
9600 RESTORE 9601: FOR F=65200 TO 65295: READ A: POKE F,A: NEXT F: RETURN
9601 DATA 0,63,64,160,160,176,191,159
9602 DATA 0,254,7,15,15,15,207,207
9603 DATA 64,63,47,95,95,95,95,255
9604 DATA 6,252,192,224,224,224,224,240
9605 DATA 1,2,62,94,190,191,95,39
9606 DATA 128,64,124,122,125,253,250,228
9607 DATA 24,7,11,23,23,23,23,63
9608 DATA 24,224,240,248,248,248,248,252
9609 DATA 16,63,56,63,48,63,56,48
9610 DATA 0,254,5,255,40,248,20,20
9611 DATA 63,62,127,223,191,191,191,255
9612 DATA 248,0,192,224,224,224,224,240
9620 REM UDG en 65200 - Torretas - Uso: POKE 23675,176: POKE 23676,254 == POKE 23675,V-256*INT (V/256): POKE 23676,INT (V/256)
9621 REM Torreta 1 - 144-145/146-147
9622 REM Torreta 1 - 148-149/150-151
9623 REM Torreta 3 - 152-153/154-155
9700 REM Rutina de GAME OVER
9710 PAPER 0: INK 7: CLS
9720 PRINT AT 10,10;PAPER 2;" GAME OVER "
9730 PRINT AT 12,7;"Nivel alcanzado: ";nivel
9740 PRINT AT 14,1;"Pulsa una tecla para continuar"
9750 PAUSE 0
9760 LET nivel=1: GO TO 22
9770 RETURN
9800 REM Rutina de ENHORABUENA y pasar al siguiente nivel
9810 PAPER 0: INK 7: CLS
9820 PRINT AT 10,9;PAPER 1;"  ENHORABUENA  "
9830 PRINT AT 12,3;"Pasamos al siguiente nivel"
9840 PAUSE 250: REM Esperar 5 segundos (50 frames * 5)
9850 LET nivel=nivel+1
9860 GO TO 22: REM Volver a la pantalla de información del nivel
9870 RETURN
9994 REM .....................................................
9995 REM El programa utiliza BASIC de ZX Spectrum, con lo cual no puede utilizar las ordenes ELSE, END IF, o el operador MOD
9996 REM Se debe optimizar al maximo el uso de CPU, reduciendo los ciclos de reloj
9997 REM El uso de memoria no es problema, asi que se pueden crear variables auxiliares si asi se optimiza el codigo
9998 REM Es preferible tener menos lineas aunque sean muy largas. Igualmente, es mejor que los REM esten siempre acompanando a otra linea, no solos
9999 REM No se pueden crear lineas mas alla de la 9999. Siempre que pida cambios, solo se devuelven los bloques de lineas que han cambiado
