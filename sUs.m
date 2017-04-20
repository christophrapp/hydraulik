% Programm zur Berechnung von Sunk- und Schwallwellen in einem Gerinne
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
file='datenSuS.csv';
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

% Eingabedaten 
y=input('Geben Sie die urspruengliche Fliesstiefe y0 ein [m]: ');
dQ=input('Geben Sie die Durchflussaenderung dQ ein [m3/s]: ');
% Eingabedaten 

A=flaeche(qs,qsP,y);
v=Q/A;

for i=1:2 % i=1 Stauschwall, i=2 Absperrsunk
    h=0; % nur Startwert
    hl=1; % nur Startwert
    while abs(hl-h)>eps
        hl=h;
        c=sqrt(g*A/bWsp(qs,qsP,(y+h/2)))*sqrt(1+3/2*bWsp(qs,qsP,(y+h/2))*h/A+1/2*(bWsp(qs,qsP,(y+h/2))*h/A)^2); % Ausbreitungsgeschwindigkeit
        if i==1
            a=v-c; % Stauschwall
        elseif i==2
            a=v+c; % a Absperrsunk
        end
        h=dQ/(a*bWsp(qs,qsP,(y+h/2))); % Höhe Absperrsunk/Stauschwall
    end
    if i==1
        fname=sprintf('Hoehe Stauschwall %1.4f m', h);
    elseif i==2
        fname=sprintf('Hoehe Absperrsunk %1.4f m', h);
    end
    disp(fname);
end

