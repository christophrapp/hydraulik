hydraulik
=========
Octave/MATLAB-Codes for basic hydraulic probelms

Hydraulik für Ingenieure – ein Kurs mit Experimenten und Open-Source-Codes
--------------------------------------------------------------------------

### Christoph Rapp

Die Octave-Programme sind unter der GNU General Public License (http://www.gnu.org/licenses) veröffentlicht worden. Alle Eingaben und Berechnungen erfolgen mit SI-Einheiten. Die Programme greifen teilweise auf die im .csv-Format abgespeicherten Eingabe-Dateien zu. Alle Dateien müssen in einem Verzeichnis liegen und von dort aus aufgerufen werden.

übergreifende Funktionen
------------------------

#### **Function-Name:** 	datenEinlesen(daten,delimiter,header)
- **Beschreibung:** 	weist den Daten der Datei ‚daten.XXX‘ die durch den ‚delimiter‘ getrennten Werte zu. Dabei werden die mit der Integer-Zahl header definierten Zeilen übersprungen
- **Ausgaben:**	alle einzeln in der Datei definierten Variablen erhalten ihren Wert zugeordnet


#### **Function-Name:** 	readData(file,delimiter)
- **Beschreibung:** 	weist den Daten der Datei ‚file.XXX‘ die durch den ‚delimiter‘ getrennten Werte zu.
- **Ausgaben:**	alle einzeln in der Datei definierten Variablen erhalten ihren Wert zugeordnet


#### **Function-Name:** 	A=flaeche(qs,qsP,y)
- **Beschreibung:** 	Berechnung der Querschnittsfläche bei Kreis- Trapez- oder Parabel-Profilen
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
- **Ergebnis:**	Querschnittsfläche: A


#### **Function-Name:** 	U=umfang(qs,qsP,y)
- **Beschreibung:** 	Berechnung des benetzten Umfangs von Kreis- Trapez- oder Parabel-Profilen
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
- **Ergebnis:**	benetzter Umfang: U


#### **Function-Name:** 	bWsp=bWsp(qs,qsP,y)
- **Beschreibung:** 	Berechnung der Breite des Wasserspiegels bei Kreis- Trapez- oder Parabel-Profilen
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
- **Ergebnis:**	Breite des Wasserspiegels: bWsp


#### **Function-Name:** 	sp=schwerpunkt(qs,qsP,y)
- **Beschreibung:** 	Berechnung des Schwerpunkts von Kreis- Trapez- oder Parabel-Profilen
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
- **Ergebnis:**	Flächenschwerpunkt: sp


#### **Function-Name:** 	lambda=pc(qs,qsP,y,Q,ks,T)
- **Beschreibung:** 	Berechnung des Rohrreibungsbeiwerts lambda über den Prandtl-Colebrook-Algorithmus
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y (beim vollgefüllten Rohr y=d)
	Durchfluss: Q
	äquivalente Sandrauheit: ks
	Temperatur: T
- **Eingabedatei:**	Zeile 19: kinViskositaet.csv
- **Ergebnis:**	Rohrreibungsbeiwert: lambda


 
Gerinnehydraulik
----------------

#### **Function-Name:** 	f=stK(y,qs,qsP,Q,g,rho,StN)
- **Beschreibung:** 	Solver für Stützkraft-Berechnung für konjugierte Fließtiefe beim Wechselsprung
- **Eingabewerte:**	Fließtiefe: y
	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Durchfluss: Q
	Gravitationskonstante: g
	Dichte: rho
	Stützkraft bei Normalwasserverhältnissen: StN
- **Aufruf:**	[yk,fval,info]=fsolve(@(yk) stK(yk,qs,qsP,Q,g,rho,StN),yGuess)
- **Ergebnis:**	Funktionswert f für konjugierte Fließtiefe: yk


#### **Function-Name:** 	f=NWV(y,qs,qsP,Q,g,T,ks,kSt,JS)
- **Beschreibung:** 	Berechnung der konjugierten Fließtiefe beim Wechselsprung
- **Eingabewerte:**	Fließtiefe: y
	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Durchfluss: Q
	Gravitationskonstante: g
	Temperatur: T
	äquivalente Sandrauheit: ks (falls ks=0 wird die Rauheit über die Manning-Strickler-Gleichung einbezogen)
	Strickler-Beiwert: kSt (falls kSt=0 wird die Rauheit über den Prandtl-Colebrook-Algorithmus berechnet)
	Sohlgefälle: JS
- **Subroutinen:**	stK(yk,qs,qsP,Q,g,rho,StN)
- **Aufruf:**	[yk,fval,info]=fsolve(@(yk) stK(yk,qs,qsP,Q,g,rho,StN),yGuess)
- **Ergebnis:**	Funktionswert f für Normalwasser-Fließtiefe: yN


#### **Function-Name:** 	yc=yC(qs,qsP,Q,g)
- **Beschreibung:** 	Berechnung der kritischen Fließtiefe
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Durchfluss: Q
	Gravitationskonstante: g
- **Subroutinen:**	phiCKreis % unten aufgeführt
	yCTrapez % unten aufgeführt
- **Ergebnis:**	kritische Fließtiefe: yc


#### **Function-Name:** 	yk=konjugiert(qs,qsP,y,Q,g,rho,yc)
- **Beschreibung:** 	Berechnung der konjugierten Fließtiefe beim Wechselsprung
- **Eingabewerte:**	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
	Durchfluss: Q
	Gravitationskonstante: g
	Dichte: rho
	kritische Fließtiefe: yc
- **Subroutinen:**	stK(yk,qs,qsP,Q,g,rho,StN)
- **Aufruf:**	[yk,fval,info]=fsolve(@(yk) stK(yk,qs,qsP,Q,g,rho,StN),yGuess)
- **Ergebnis:**	konjugierte Fließtiefe: yk


#### **Skript-Name:** 	normalwasser.m
- **Beschreibung:** 	Berechnung der Normalwasserverhältnisse.
- **Eingabedatei:**	Zeile 18: datenGerinne.csv
- **Bildschirmeingaben:**	Eingabe, ob die Fließtiefe im Strömen (yl) oder im Schießen (yr) bestimmt werden soll
Bekannte Fließtiefe rechts (Strömen) bzw. links (Schießen) eingeben
- **Subroutinen:**	NWV(y,qs,qsP,Q,g,T,ks,kSt,JS)
	konjugiert(qs,qsP,y,Q,g,rho,yc)
- **Ergebnis/Ausgabe:**	Normalwasser-Fließtiefe: yN
	Normalwasser-Geschwindigkeit: vN
	Normalwasser-Energiehöhe: HN
	Normalwasser-Froude-Zahl: FrN
	kritische Fließtiefe: yc
	kritische Geschwindigkeit: vc
	minimale Energiehöhe: Hmin
	konjugierte Fließtiefe: yk
	Energiehöhe bei konjugierter Fließtiefe: Hk
	Froude-Zahl bei konjugierter Fließtiefe: Frk


#### **Skript-Name:** 	boess.m
- **Beschreibung:** 	Berechnung der Wasserspiegel in einem bestimmten Abstand Dx nach oberstrom (im Strömen) bzw. nach unterstrom (im Schießen).
- **Eingabedatei:**	Zeile 18: datenGerinne.csv
- **Bildschirmeingaben:**	Eingabe, ob die Fließtiefe im Strömen (yl) oder im Schießen (yr) bestimmt werden soll
Bekannte Fließtiefe rechts (Strömen) bzw. links (Schießen) eingeben
- **Subroutinen:**	1. 	datenEinlesen.m % weist den Variablen in der Eingabedatei die entsprechenden Werte zu
	2. boessSolve.m % löst die Böß-Gleichung iterativ
- **Ergebnis:**	Fließtiefe: y


#### **Skript-Name:** 	boessDeltaX.m
- **Beschreibung:** 	Berechnung des Abstands zweier Wasserspiegel
- **Eingabedatei:**	Zeile 18: datenGerinne.csv
- **Bildschirmeingaben:**	Eingabe der bekannten Fließtiefen rechts und links
- **Subroutinen:**	datenEinlesen.m % weist den Variablen in der Eingabedatei die entsprechenden Werte zu


#### **Skript-Name:** 	sUs.m
- **Beschreibung:** 	Berechnung der Sunk- bzw. Schwallhöhe
- **Eingabedatei:**	Zeile 18: datenSuS.csv
- **Bildschirmeingaben:**	Eingabe der ursprünglichen Fließtiefe
	Eingabe der Durchflussänderung (Vorzeichen beachten! Reduktion (-), Steigerung (+))
- **Subroutinen:**	datenEinlesen.m % weist den Variablen in der Eingabedatei die entsprechenden Werte zu
	bWsp.m % Berechnung der Breite des Wasserspiegels
- **Ausgabe:**	Höhe des Stauschwalls bzw. Absperrsunks: h

 
Rohrhydraulik
-------------

#### **Skript-Name:** 	couette.m
- **Beschreibung:** 	Berechnung des Geschwindigkeits-Profils einer Couette-Poiseuille-Strömung.
- **Bildschirmeingaben:**	Kanalbreite: B
	Druckgradient: dp/dx
	Geschwindigkeit der oberen Platte uB
	Bekannte Fließtiefe rechts (Strömen) bzw. links (Schießen) eingeben
- **Ausgabe:**	Geschwindigkeitsprofil.png im aktuellen Ordner


#### **Function-Name:** 	f=energie(Q,qs,qsP,y,l,ks,sZeta,A0,At,mue,g,T,dH)
- **Aufruf:**	[Q,fval,info]=fsolve(@(Q),qs,qsP,y,l, ks,sZeta,A0,At,mue,g,T,dH,PT,PP,eta),guess)
- **Beschreibung:** 	Berechnung des Durchflusses in einem Rohrleitungssystem mit den Parametern:
	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
	Länge: l
	äquivalente Sandrauheit: ks
	Summe der Einzelverluste (Auslaufverlust nicht vergessen!): sZeta
	Gravitationskonstante: g
	Temperatur: T
	Wasserspiegeldifferenz zwischen Ein- und Auslauf: dH
	Pumpenleistung: PP
	Turbinenleistung: PT
	Wirkungsgrad: eta
- **Subroutinen:**	1. 	flaeche.m % berechnet die Querschnittsfläche
	2. umfang.m % berechnet den benetzten Umfang
- **Ergebnis:**	Durchfluss: Q


#### **Function-Name:** f=rohr(Q,qs,qsP,y,l,ks,sZeta,A0,At,mue,g,T,dH,PT,PP,eta)
- **Aufruf:**	[Q,fval,info]=fsolve(@(Q),qs,qsP,y,l, ks,sZeta,A0,At,mue,g,T,dH,PT,PP,eta),guess)
- **Beschreibung:** 	Berechnung des Durchflusses in einem Rohrleitungssystem mit den Parametern:
	Querschnittsform: qs(‘kreis‘,‘trapez‘,‘parabel‘)
	Querschnittsparameter: qsP(d, [s,m],a)
	Fließtiefe: y
	Länge: l
	äquivalente Sandrauheit: ks
	Summe der Einzelverluste (Auslaufverlust nicht vergessen!): sZeta
	Gravitationskonstante: g
	Temperatur: T
	Wasserspiegeldifferenz zwischen Ein- und Auslauf: dH
	Pumpenleistung: PP
	Turbinenleistung: PT
	Wirkungsgrad: eta
- **Subroutinen:**	1. 	flaeche.m % berechnet die Querschnittsfläche
	2. umfang.m % berechnet den benetzten Umfang
- **Ergebnis:**	Durchfluss: Q


 
instationäre Rohrhydraulik
--------------------------

#### **Skript-Name:** 	druckstoss.m
- **Beschreibung:** 	Programm zur Berechnung der Geschwindigkeiten und Drücke bei instationären Rohrströmungen mit Hilfe des Charakteristiken-Verfahrens.
- **Bildschirmeingaben:**	leitungsverlauf: Anzeige der piezometrischen Druckhöhe (piezo), der Druckstoßhöhe (nur) oder der Druckhöhe (DL)
	A0neu: A0 ist als Default der Rohrquerschnitt. Falls dieser durch ein Ventil im stationären Zustand bereits reduziert ist, muss hier die Querschnittsfläche eingegeben werden. Anderenfalls mit Enter bestätigen.
	verschlussArt: Art des Schließgesetztes (hyperbel,linear)
	aNeu: Ermöglicht die Korrektur der Ausbreitungsgeschwindigkeit a
- **Eingabedatei:**	Zeile 26: kinViskositaet.csv
	Zeile 27: dampfdruck.csv
- **Subroutinen:**	1. 	flaeche.m % berechnet die Querschnittsfläche
	2. umfang.m % berechnet den benetzten Umfang
	3. energie.m % berechnet den Durchfluss
	4. schliessen.m % berechnet die Fläche des Verschlussorgans zum Zeitpunkt t
- **Ergebnis:**	Matrizen der zeit- und ortsabhängigen Größen:
	Geschwindigkeit: v
	Druckhöhe: h
- **Ausgabe:**	druckstossBsp.png im aktuellen Ordner
	druckstossBsp.pdf im aktuellen Ordner


#### **Function-Name:** 	At=schliessen(A0,ts,t,spalt,verschlussArt)
- **Beschreibung:** 	Berechnung der offenen Fläche des Verschlussorgans zum Zeitpunkt t mit den Parametern:
	ursprüngliche Öffnungsfläche: A0
	Verschlusszeit: ts
	Zeitpunkt: t
	bei komplettem Verschluss verbliebene Öffnungsfläche: spalt
	verschlussArt: Schließgesetz (linear,hyperbolisch)
- **Ergebnis:**	Öffnungsfläche des Verschlussorgans zum Zeitpunkt t: At

#### **Function-Name:** 	v=vVerschluss(h,k,mue,At,A,a,g,ort)
- **Beschreibung:** 	Berechnung der Fließgeschwindigkeit am Verschlussorgan mit folgenden Parametern:
	Druckhöhe: h
	Kontante aus vorherigem Zeitschritt des Nachbarpunkts: k (km bzw. kp)
	Verlustbeiwert des Verschlussorgans: mue
	Öffnungsfläche zum Zeitpunkt t: At
	Querschnittsfläche des Rohres: A
	Ausbreitungsgeschwindigkeit der Störung: a
	Gravitationskonstante: g
	Stelle des Verschlussorgans: ort (‘oben‘ bzw. ‘unten‘)
- **Ergebnis:**	Öffnungsfläche des Verschlussorgans zum Zeitpunkt t: At


 
Potentialtheorie
----------------

#### **Function-Name:** 	[phi,psi,u,v]=parallel(x,y,u0,v0)
- **Beschreibung:** 	Berechnung der Potential- (phi) und Stromfunktion (psi) sowie der Geschwindigkeitskomponenten u und v in einem durch x und y definierten Feld, das einer Parallelströmung mit u0 und v0 unterliegt.
- **Eingabewerte:**	Matrix des Feldes: x in der Form [x1,x2,xn;x1,x2,xn;x1,x2,xn]
	Matrix des Feldes: y in der Form [y1,y1,y1;y2,y2,y2;yn,yn,yn]
	konstante Geschwindigkeit in x-Richtung: u0
	konstante Geschwindigkeit in y-Richtung: v0
- **Ergebnis:**	Potentialfunktion im Feld: phi
	Stromfunktion im Feld: psi
	Geschwindigkeitskomponente in x-Richtung: u
	Geschwindigkeitskomponente in y-Richtung: v


#### **Function-Name:** 	[phi,psi,u,v]=source(x,y,posX,posY,Q)
- **Beschreibung:** 	Berechnung der Potential- (phi) und Stromfunktion (psi) sowie der Geschwindigkeitskomponenten u und v in einem durch x und y definierten Feld, das eine Quelle(+) bzw. eine Senke (-) mit dem spezifischen Durchfluss Q an der Stelle (posX,poxY) hat.
- **Eingabewerte:**	Matrix des Feldes: x in der Form [x1,x2,xn;x1,x2,xn;x1,x2,xn]
	Matrix des Feldes: y in der Form [y1,y1,y1;y2,y2,y2;yn,yn,yn]
	x-Position des Dipols: posX
	y-Position des Dipols: posY
	Dipolstärke: m
- **Ergebnis:**	Potentialfunktion im Feld: phi
	Stromfunktion im Feld: psi
	Geschwindigkeitskomponente in x-Richtung: u
	Geschwindigkeitskomponente in y-Richtung: v


#### **Function-Name:** 	[phi,psi,u,v]=dipol(x,y,posX,posY,m)
- **Beschreibung:** 	Berechnung der Potential- (phi) und Stromfunktion (psi) sowie der Geschwindigkeitskomponenten u und v in einem durch x und y definierten Feld, das einen Dipol mit der Stärke m an der Stelle (posX,poxY) hat.
- **Eingabewerte:**	Matrix des Feldes: x in der Form [x1,x2,xn;x1,x2,xn;x1,x2,xn]
	Matrix des Feldes: y in der Form [y1,y1,y1;y2,y2,y2;yn,yn,yn]
	x-Position des Dipols: posX
	y-Position des Dipols: posY
	Dipolstärke: m
- **Ergebnis:**	Potentialfunktion im Feld: phi
	Stromfunktion im Feld: psi
	Geschwindigkeitskomponente in x-Richtung: u
	Geschwindigkeitskomponente in y-Richtung: v


#### **Function-Name:** 	[phi,psi,u,v]=vortex(x,y,posX,posY,gamma)
- **Beschreibung:** 	Berechnung der Potential- (phi) und Stromfunktion (psi) sowie der Geschwindigkeitskomponenten u und v in einem durch x und y definierten Feld, das einen Potentialwirbel mit der Stärke gamma an der Stelle (posX,poxY) hat.
- **Eingabewerte:**	Matrix des Feldes: x in der Form [x1,x2,xn;x1,x2,xn;x1,x2,xn]
	Matrix des Feldes: y in der Form [y1,y1,y1;y2,y2,y2;yn,yn,yn]
	x-Position des Wirbels: posX
	y-Position des Wirbels: posY
	Wirbelstärke: m
- **Ergebnis:**	Potentialfunktion im Feld: phi
	Stromfunktion im Feld: psi
	Geschwindigkeitskomponente in x-Richtung: u
	Geschwindigkeitskomponente in y-Richtung: v


#### **Skript-Name:** 	potential.m
- **Beschreibung:** 	Programm zur Berechnung von Potentialströmungen. Das Programm durchsucht den Ordnern nach den Dateien der Elementarlösungen source.csv, parallel.csv, vortex.csv und dipol.csv und bezieht gegebenenfalls die Eingangsdaten ein.
- **Bildschirmeingaben:**	leitungsverlauf: Anzeige der piezometrischen Druckhöhe (piezo), der Druckstoßhöhe (nur) oder der Druckhöhe (DL)
	A0neu: A0 ist als Default der Rohrquerschnitt. Falls dieser durch ein Ventil im stationären Zustand bereits reduziert ist, muss hier die Querschnittsfläche eingegeben werden. Anderenfalls mit Enter bestätigen.
	verschlussArt: Art des Schließgesetztes (hyperbel,linear)
	aNeu: Ermöglicht die Korrektur der Ausbreitungsgeschwindigkeit a
- **Eingabedatei:**	Zeile 28: source.csv
	Zeile 35: dipol.csv
	Zeile 42: vortex.csv
	Zeile 49: parallel.csv
- **Subroutinen:**	readData.m % weist den Variablen die entsprechenden Werte zu
	plotStreamline.m % zeichnet die Strom- und Äquipotentiallinien
- **Ergebnis:**	Potentialfunktion: phi
	Stromfunktion: psi
	Geschwindigkeitsfeld in x-Richtung: u
	Geschwindigkeitsfeld in y-Richtung: v
- **Ausgabe:**	streamL.png im aktuellen Ordner

#### **Function-Name:** 	stream=plotStreamline(x,y,u,v,dx,dy,seed)
- **Beschreibung:** 	Programm zur Berechnung von Stromlinien, die an den Saatpunkten seed beginnen.
- **Eingabewerte:**	Matrix des Feldes: x in der Form [x1,x2,xn;x1,x2,xn;x1,x2,xn]
	Matrix des Feldes: y in der Form [y1,y1,y1;y2,y2,y2;ym,ym,ym]
	Matrix des Feldes: u in der Form [u11,u12,u1n;u21,u22,u2n;um1,um2,umn]
	Matrix des Feldes: v in der Form [v11,v12,v1n;v21,v22,v2n;vm1,vm2,vmn]
	äquidistanter Knotenabstand in x-Richtung: dx
	äquidistanter Knotenabstand in y-Richtung: dy
	Saatpunkt der Stromlinien: seed in der Form
	[x1,y1;x2,y2;x3,y3;xn,yn]
- **Ergebnis:**	Stromlinien der Form
	stream{i}(x,y)



