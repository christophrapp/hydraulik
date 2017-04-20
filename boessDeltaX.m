% Programm zur Berechnung des Abstandes Delta x zweier Fließtiefen mit dem Boess-Verfahren
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

% Eingabedaten 
fname=sprintf('Geben Sie die bekannte Fliesstiefe yr ein [m]: ');
yr=input(fname);
fname=sprintf('Geben Sie die bekannte Fliesstiefe yl ein [m]: ');
yl=input(fname);
% Eingabedaten 

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
Al=flaeche(qs,qsP,yl);
Ar=flaeche(qs,qsP,yr);
Ul=umfang(qs,qsP,yl);
Ur=umfang(qs,qsP,yr);
vl=Q/Al;
vr=Q/Ar;
vm=(vl+vr)/2;
Rm=(Ar+Al)/(Ur+Ul);
JEm=vm^2/kSt^2/Rm^(4/3);
kl=vl^2/(2*g);
kr=vr^2/(2*g);
deltax=(yr+kr-yl-kl)/(JS-JEm);
fname=sprintf('deltax = %1.3f', deltax);
disp(fname);
