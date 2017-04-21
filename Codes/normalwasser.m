% Programm zur Berechnung der Normalwasserverhaeltnisse in einem Gerinne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Copyright (C) <2016>  <Christoph Rapp, Muenchen, Germany>

% % % This program is free software: you can redistribute it and/or modify
% % % it under the terms of the GNU General Public License as published by
% % % the Free Software Foundation, either version 3 of the License, or
% % % (at your option) any later version.

% % % This program is distributed in the hope that it will be useful,
% % % but WITHOUT ANY WARRANTY; without even the implied warranty of
% % % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% % % GNU General Public License for more details.

% % % You should have received a copy of the GNU General Public License
% % % along with this program.  If not, see <http://www.gnu.org/licenses/>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file='datenGerinne.csv';
delimiter='=';
header=2;
% Einlesen der Gerinnecharakteristik
datenEinlesen(file,delimiter,header);
% Einlesen der Gerinnecharakteristik

% Zuweisung von Begriffen für die Querschnittsbezeichnung
if qs==1
	qs='kreis';
	qsP=d;
elseif qs==2
	qs='trapez';
	qsP=[b,m];
elseif qs==3
	qs='parabel';
	qsP=a;
end
% Zuweisung von Begriffen für die Querschnittsbezeichnung

% Berechnung Normalwassertiefe
y=fsolve(@(y) NWV(y,qs,qsP,Q,g,T,ks,kSt,JS), qsP(1)/2);
% Berechnung Normalwassertiefe
A=flaeche(qs,qsP,y);
% Berechnung Geschwindigkeit/shöhe
v=Q/A;
k=Q^2/A^2/2/g;
% Berechnung Geschwindigkeit/shöhe
% Berechnung Energiehöhe
H=y+k;
% Berechnung Energiehöhe
% Berechnung Froude-Zahl
bwsp=bWsp(qs,qsP,y);
Fr=v/sqrt(g*A/bwsp);
% Berechnung Froude-Zahl

% Bildschirmanzeige
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nNormalwasserverhaeltnisse');
disp(ausgabe);
ausgabe=sprintf('yN = %1.3f m', y);
disp(ausgabe);
ausgabe=sprintf('vN = %1.3f m/s', v);
disp(ausgabe);
ausgabe=sprintf('HN = %1.3f m', H);
disp(ausgabe);
ausgabe=sprintf('FrN = %1.3f', Fr);
disp(ausgabe);
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(ausgabe);
% Bildschirmanzeige

% kritische Verhältnisse
yc=yC(qs,qsP,Q,g);
Ac=flaeche(qs,qsP,yc);
vc=Q/Ac;
Hmin=yc+Q^2/(Ac^2*2*g);
% kritische Verhältnisse

% Bildschirmanzeige
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nkritische Verhaeltnisse');
disp(ausgabe);
ausgabe=sprintf('yc = %1.3f m', yc);
disp(ausgabe);
ausgabe=sprintf('vc = %1.3f m', vc);
disp(ausgabe);
ausgabe=sprintf('Hmin = %1.3f m', Hmin);
disp(ausgabe);
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(ausgabe);
% Bildschirmanzeige

% Berechnung konjugierte Verhältnisse
yk=konjugiert(qs,qsP,y,Q,g,rho,yc);
Ak=flaeche(qs,qsP,yk);
% Berechnung konjugierte Verhältnisse
% Berechnung konjugierte Energiehöhe
Hk=yk+(Q^2/Ak^2)/(2*g);
% Berechnung konjugierte Energiehöhe

% Berechnung Froude-Zahl
bwspk=bWsp(qs,qsP,yk);
Frk=Q/(Ak)/sqrt(g*Ak/bwspk);
% Berechnung Froude-Zahl

% Bildschirmanzeige
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nkonjugierte Verhaeltnisse');
disp(ausgabe);
ausgabe=sprintf('yk = %1.3f m', yk);
disp(ausgabe);
ausgabe=sprintf('Hk = %1.3f m', Hk);
disp(ausgabe);
ausgabe=sprintf('Frk = %1.3f', Frk);
disp(ausgabe);
ausgabe=sprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(ausgabe);
% Bildschirmanzeige
fname=sprintf('%03dMIK.csv',Q);
csvwrite(fname,[y,v,H,Fr])

return