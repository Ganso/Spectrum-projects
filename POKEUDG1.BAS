Check 2AFEFEE4
Auto 8224

# Run-time Variables

Var v: Num = 65032
Var x: Num = 254
Var y: NumFOR = 8, 7, 1, 60, 3
Var c$: Str = "a"

# End Run-time Variables

   5 CLEAR 65031
  10 REM DEFINE BANK 1
  15 LET V=65368: GO SUB 200
  20 READ C$: FOR Y=0 TO 7: READ X: POKE USR C$+Y,X: NEXT Y
  25 DATA "a",0,56,68,130,130,130,68,56
  30 REM DEFINE BANK 2
  35 LET V=65200: GO SUB 200
  40 READ C$: FOR Y=0 TO 7: READ X: POKE USR C$+Y,X: NEXT Y
  45 DATA "a",0,254,130,130,130,130,130,254
  50 REM DEFINE BANK 3
  55 LET V=65032: GO SUB 200
  60 READ C$: FOR Y=0 TO 7: READ X: POKE USR C$+Y,X: NEXT Y
  65 DATA "a",0,128,192,160,144,136,132,254
  70 REM SHOW BANK 1
  75 LET V=65368: GO SUB 200: PRINT CHR$ 144: REM GRAPHICS A
  80 REM SHOW BANK 2
  85 LET V=65200: GO SUB 200: PRINT CHR$ 144: REM GRAPHICS A
  90 REM SHOW BANK 3
  95 LET V=65032: GO SUB 200: PRINT CHR$ 144: REM GRAPHICS A
 100 STOP
 200 REM SET BANK ADDRESS
 210 POKE 23675,V-256*INT (V/256): POKE 23676,INT (V/256)
 215 RETURN
 300 REM https://www.worldofspectrum.org/forums/discussion/comment/194250/#Comment_194250
 400 REM https://www.worldofspectrum.org/forums/discussion/comment/505892/#Comment_505892
 500 REM https://www.worldofspectrum.org/forums/discussion/comment/772149/#Comment_772149
 600 REM https://www.worldofspectrum.org/forums/discussion/comment/831995/#Comment_831995
