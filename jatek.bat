@echo off
:: Jatek program, egyszeru rpg [MS CommandPrompt]
:: Fejlesztette: Szekeres Abel
:: Parbaj

set eHP=%1
set eATT=%2
set eDEF=%3
set eINT=%4

set /A HPszorzo=10
set /A ATTszorzo=10
set /A INTszorzo=10
set /A DEFszorzo=10
set /A szorzo=10

IF [%1]==[--help] goto :help
IF [%1]==[--alap] goto :alap
echo %* |find "--help" > nul
echo %* |find "--alap" > nul
IF errorlevel 1 goto :main

:help
echo Ellenfel hozzaadasa c:\jatek.bat [hp] [attack] [defend] [intel]
echo Gyors harc c:\jatek.bat --alap
goto :helpend

:alap
	set name1=ALAP
	set name2=NEV
	set ELEM=nul
	set OSZTALY=nul
	set /A eletero=20000
	set /A sebzes=20000
	set /A vedekezes=20000
	set /A intel=20000
	set /A eHP=20000
	set /A eATT=20000
	set /A eDEF=20000
	set /A eINT=20000
	goto :visszaHarc

:main
CLS
echo ---SURNAME---
set /P name1=Add meg a csaladod!:

CLS
echo ---FIRSTNAME---
set /P name2=Add meg a neved!:

CLS
echo ---ELEMENT---
echo (1) Tuz
echo (2) Levego
echo (3) Fold
echo (4) Viz
set /P N=Valassz ELEMET!:

:CASE_ELEM
	2>NUL CALL :CASE_E_%N%
	IF ERRORLEVEL 1 CALL :DEFAULT_E_CASE 

:CASE_E_1
	:: echo TUZ
	set ELEM=tuz
    	set /A ATTszorzo=ATTszorzo+10
	goto :CASE_E_END  
	
:CASE_E_2
	:: echo LEVEGO
	set ELEM=levego
    	set /A INTszorzo=INTszorzo+10
	goto :CASE_E_END
	
:CASE_E_3
    	:: echo FOLD
	set ELEM=fold
    	set /A DEFszorzo=DEFszorzo+10
	goto :CASE_E_END

:CASE_E_4
	:: echo VIZ
	set ELEM=viz
	set /A HPszorzo=HPszorzo+10
	goto :CASE_E_END

:DEFAULT_E_CASE
	set ELEM=kivalasztott
	set /A szorzo=szorzo+10
	goto :CASE_E_END

:CASE_E_END
   	CLS
	echo ---CLASS---

echo (1) Harcos
echo (2) Lovesz
echo (3) Fejvadasz
echo (4) Kereskedo
echo (5) Bandita
echo (6) Fantom szekta
set /P N=Valassz OSZTALYT!:

:CASE_OSZTALY
	2>NUL CALL :CASE_O_%N%
	IF ERRORLEVEL 1 CALL :DEFAULT_O_CASE 

:CASE_O_1
	:: echo HARCOS
	set OSZTALY=harcos	
	set /A HPszorzo=HPszorzo+10
	goto :CASE_O_END

:CASE_O_2
	:: echo LOVESZ
	set OSZTALY=lovesz
	set /A ATTszorzo=ATTszorzo+10
	goto :CASE_O_END

:CASE_O_3
	:: echo FEJVADASZ
	set OSZTALY=fejvadasz
	set /A ATTszorzo=ATTszorzo+14
	set /A DEFszorzo=DEFszorzo-2
	set /A HPszorzo=HPszorzo-2
	goto :CASE_O_END 

:CASE_O_4
	:: echo KERESKEDO
	set OSZTALY=kereskedo
	set /A INTszorzo=INTszorzo+10
	goto :CASE_O_END
 
:CASE_O_5
	:: echo BANDITA
	set OSZTALY=bandita
	set /A ATTszorzo=ATTszorzo+6
	set /A DEFszorzo=DEFszorzo+4
	goto :CASE_O_END

:CASE_O_6
	:: echo FANTOM
	set OSZTALY=fantom szekta
	set /A INTszorzo=INTszorzo+14
	set /A HPszorzo=HPszorzo-4
	goto :CASE_O_END

:DEFAULT_O_CASE
	set OSZTALY=nincs
	set /A szorzo=szorzo-14
	goto :CASE_O_END
:CASE_O_END

CLS

set /A Srandom=(%RANDOM%*600/32768)+300
set /A Vrandom=(%RANDOM%*600/32768)+300
set /A Irandom=(%RANDOM%*600/32768)+300
set /A Erandom=(%RANDOM%*600/32768)+300

echo ---SEBZES---
set /A sebzes=%Srandom%*%ATTszorzo%
echo %Srandom%/%ATTszorzo%
PAUSE > NUL

CLS
echo ---VEDEKEZES---
set /A vedekezes=%Vrandom%*%DEFszorzo%
echo %Vrandom%/%DEFszorzo%
PAUSE > NUL

CLS
echo ---INTEL---
set /A intel=%Irandom%*%INTszorzo%
echo %Irandom%/%INTszorzo%
PAUSE > NUL

CLS
echo ---ELETERO---
set /A eletero=%Erandom%*%HPszorzo%
echo %Erandom%/%HPszorzo%
PAUSE > NUL

CLS
echo ---STATOK---
echo A neved matol %name1% %name2%!
echo Utadat a(z) %ELEM% hatarozza meg!
echo Mindennapodat pedig a(z) %OSZTALY% szakma vegzese, fejlesztese befolyasolja!
PAUSE > NUL
echo Eletero:%eletero%
echo Vedekezes:%vedekezes%
echo Sebzes:%sebzes%
echo Intel:%intel%
PAUSE > NUL

CLS
:visszaHarc
if %eletero% LEQ 0 goto :PLAYER_DEAD
echo ---HARC---
echo //ELLENFEL//
echo HP:%eHP%
echo ATT:%eATT%
echo DEF:%eDEF%
echo INT:%eINT% 

echo //%name1% %name2%//
echo HP:%eletero%
echo ATT:%sebzes%
echo DEF:%vedekezes%
echo INT:%intel%

echo (1) Tamadas
echo (2) Vedekezes
echo (3) Menekules
set /P N=Mit teszel?:

:CASE_HARC
	2>NUL CALL :CASE_H_%N%
	IF ERRORLEVEL 1 CALL :DEFAULT_H_CASE 

:CASE_H_1
	set /A eHP=eHP-sebzes
	echo Ellenfel HP: %eHP%
	goto :enemyATT

:CASE_H_2
	set /A eletero=eletero+vedekezes
	echo Uj eleterod: %eletero%
	goto :enemyATT

:CASE_H_3
	echo elmenekultel
	goto :CASE_H_END

:DEFAULT_H_CASE
	echo Nem csinaltal semmit!!! :/
	goto :enemyATT

:CASE_H_END

echo THE END
PAUSE > NUL
exit

:enemyATT
	if %eHP% LEQ 0 goto :enemyDEAD
	if %eHP% LEQ %sebzes% goto :enemyATT-vedekezes else goto :enemyATT-sebzes
	goto :CASE_H_END 

:enemyATT-sebzes
	set /A eletero=eletero-eATT
	echo Eleterod az ellenfeled csapasa utan: %eletero%
	PAUSE > NUL
	goto :visszaHarc

:enemyATT-vedekezes
	set /A eHP=eHP+eDEF
	echo Az ellenfeled vedekezik... %eHP%
	PAUSE > NUL
	goto :visszaHarc

:enemyDEAD
	echo az ellenfeled meghalt
	goto :CASE_H_END

:PLAYER_DEAD
	echo meghaltal! ellenfeled fegyvere altal
	goto :CASE_H_END

:helpend