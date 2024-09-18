1 DIM m(22,32):DIM c(10,2):DIM z(10,3):LET r=40:LET t=0:LET tr=0:LET tz=0:LET cx=10:LET cy=10
2 LET te=0:LET k=0:LET lk=0:LET ox=0:LET oy=0:LET f=0:LET g=0:LET b=0:LET n=0:LET o=0:LET op=0
5 BORDER 0:PAPER 0:INK 7:CLS
10 RESTORE 15:FOR n=0 TO 71:READ a:POKE USR "a"+n,a:NEXT n
15 DATA 60,126,219,255,189,189,126,60,60,36,36,24,60,90,129,66
16 DATA 255,219,255,219,255,219,255,219
17 DATA 60,126,219,255,255,219,126,60,60,90,90,60,36,36,102,66
18 DATA 60,126,195,255,255,195,126,60,60,66,66,60,36,36,102,66
19 DATA 60,126,231,255,255,231,126,60,60,102,102,60,36,36,102,66
20 DATA 24,60,126,255,255,126,60,24,24,60,102,255,255,102,60,24,24,60,90,255,255,90,60,24
25 GO SUB 2000:GO SUB 8000:GO SUB 8700:GO TO 6000
2000 REM Colocar ciudadanos
2001 PAPER 0:INK 7:FOR b=1 TO 10
2002 LET c(b,1)=INT (RND*9)+1:LET c(b,2)=INT (RND*20)+1
2010 IF m(c(b,2)+1,c(b,1))=1 OR m(c(b,2)+2,c(b,1))=1 THEN GO TO 2002
2020 PRINT AT c(b,2),c(b,1);CHR$ 144;AT c(b,2)+1,c(b,1);CHR$ 145
2030 LET m(c(b,2)+1,c(b,1))=1:LET m(c(b,2)+2,c(b,1))=1:NEXT b:RETURN
3000 REM Colocar objeto
3010 IF (te=0 AND r<5) OR (te>0 AND r<20) THEN RETURN
3020 GO SUB 8600:IF o=0 THEN GO SUB 3100
3030 RETURN
3100 REM Colocar objeto en el mapa
3110 IF te=0 THEN LET r=r-5:INK 4:PRINT AT cy,cx;CHR$ 146:LET m(cy+1,cx)=2
3120 IF te>0 THEN LET r=r-20:INK 5:PRINT AT cy,cx;CHR$ (149+te):LET m(cy+1,cx)=te+2
3130 BEEP 0.1,50:RETURN
5000 REM Generar zombie
5010 LET f=1:LET z(f,1)=31:LET z(f,2)=INT (RND*20)+1:LET z(f,3)=INT (RND*3)+1
5020 IF m(z(f,2)+1,z(f,1))>0 OR m(z(f,2)+2,z(f,1))>0 THEN GO TO 5010
5030 LET g=f:GO SUB 8150:LET m(z(f,2)+1,z(f,1))=z(f,3)+5:LET m(z(f,2)+2,z(f,1))=z(f,3)+5
5040 BEEP 0.1,20:RETURN
6000 REM Bucle principal del juego
6010 GO SUB 7000:GO SUB 7200:GO SUB 7300:GO TO 6000
7000 REM Mover zombies
7010 FOR g=1 TO 10:IF z(g,1)>1 THEN LET ox=z(g,1):LET oy=z(g,2):LET m(oy+1,ox)=0:LET m(oy+2,ox)=0:LET z(g,1)=z(g,1)-1:PRINT AT oy,ox;" ";AT oy+1,ox;" ":GO SUB 8150:LET m(z(g,2)+1,z(g,1))=z(g,3)+5:LET m(z(g,2)+2,z(g,1))=z(g,3)+5:BEEP 0.05,10
7020 NEXT g:RETURN
7200 REM Actualizar puntuación, recursos y tiempo
7210 INK 0:PAPER 7:PRINT AT 0,10;r;"   ":PAPER 0:LET t=t+1:LET tr=tr+1:LET tz=tz+1
7220 IF tr=3 THEN LET r=r+1:LET tr=0:IF r>100 THEN LET r=100
7230 IF tz=10 THEN GO SUB 5000:LET tz=0:RETURN
7300 REM Controles del jugador
7310 LET k=PEEK 23560:IF k=0 THEN RETURN
7320 LET ox=cx:LET oy=cy
7330 IF k=113 AND cy>1 THEN LET cy=cy-1
7340 IF k=97 AND cy<20 THEN LET cy=cy+1
7350 IF k=111 AND cx>10 THEN LET cx=cx-1
7360 IF k=112 AND cx<30 THEN LET cx=cx+1
7370 IF k>=48 AND k<=51 THEN LET te=k-48:GO SUB 3000
7380 IF ox<>cx OR oy<>cy THEN GO SUB 8400:GO SUB 8000
7390 RETURN
8000 REM Dibujar cursor
8010 INK 6:PRINT AT cy,cx;"+":RETURN
8150 REM Dibujar zombie
8160 INK z(g,3):PRINT AT z(g,2),z(g,1);CHR$ (144+z(g,3)*2);AT z(g,2)+1,z(g,1);CHR$ (145+z(g,3)*2):RETURN
8400 REM Comprobar y redibujar objeto
8410 LET op=m(oy+1,ox):IF op=2 THEN INK 4:PRINT AT oy,ox;CHR$ 146:RETURN
8420 IF op>=3 AND op<=5 THEN INK op-2:PRINT AT oy,ox;CHR$ (149+op-2):RETURN
8430 PRINT AT oy,ox;" ":RETURN
8600 REM Comprobar si la celda está ocupada
8610 LET o=m(cy+1,cx):RETURN
8700 REM Dibujar interfaz
8710 INK 0:PAPER 7:PRINT AT 0,0;"Dinero:                        ";AT 21,0;"Movimiento: QAOP               "
8720 INK 4:PRINT AT 21,18;"0";CHR$ 146:INK 1:PRINT AT 21,21;"1";CHR$ 150
8730 INK 2:PRINT AT 21,24;"2";CHR$ 151:INK 3:PRINT AT 21,27;"3";CHR$ 152:PAPER 0:RETURN
9000 REM Variables: a-dato leido, b-bucle ciudadanos, c-ciudadanos, f-indice zombie
9010 REM g-bucle mover zombies, k-tecla pulsada, lk-ultima tecla, ox,oy-posicion anterior
9020 REM z-zombies, m-mapa del juego (0=vacio, 1=ciudadano, 2=ladrillo, 3-5=torreta, 6-8=zombie)
9030 REM te-tipo de torreta, r-recursos, t-tiempo, tr-tiempo recurso, tz-tiempo zombie
9040 REM cx,cy-posicion cursor, o-ocupado
9090 REM UDGs: 144-145 Ciudadano, 146 Ladrillo, 147-152 Zombies, 149-152 Torretas