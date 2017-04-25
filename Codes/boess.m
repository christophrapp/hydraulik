% Programm zur Berechnung der Fliesstiefe in einem bestimmten Abstand Delta x mit dem Boess-Verfahren
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

% Eingabedaten 
yUnknown=input('Moechten Sie yl berechnen (stroemen) oder yr (schiessen): [yl], [yr]: ','s');
if strcmp(yUnknown,'yl')
	toggle='STR';
	fname=sprintf('Geben Sie die bekannte Fliesstiefe yr (stroemen) ein [m]: ');
elseif strcmp(yUnknown,'yr')
	toggle='SCH';
	fname=sprintf('Geben Sie die bekannte Fliesstiefe yl (schiessen) ein [m]: ');
end
yK=input(fname);
% Eingabedaten 

schritt=1;
while schritt*dx<=L
	yK=fsolve(@(y) boessSolve(y,qs,qsP,yK,Q,g,T,ks,kSt,JS,dx,toggle), yK);
	schritt=schritt+1;
end
if strcmp(toggle,'STR')
	fname=sprintf('yl = %1.3f m', yK);
elseif strcmp(toggle,'SCH')
	fname=sprintf('yr = %1.3f m', yK);
end
disp(fname);
