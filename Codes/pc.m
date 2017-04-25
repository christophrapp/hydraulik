% Prandtl-Colebrook-Algorithmus zur Berechnung von lambda mit (qs,qsP,y,Q,ks,T)
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
function lambda=pc(qs,qsP,y,Q,ks,T)
nue=csvread('kinViskositaet.csv');
nue=interp1(nue(:,1),nue(:,2),T);
eps=1e-6; % Genauigkeitskriterium
% Berechnung der Querschnittswerte
if strcmp(qs,'kreis')
    d=qsP(1);
elseif strcmp(qs,'trapez')
    b=qsP(1);
    m=qsP(2);
elseif strcmp(qs,'parabel')
	a=qsp(1);
end
A=flaeche(qs,qsP,y);
U=umfang(qs,qsP,y);
R=A/U;
v=Q/A;
Re=v*4*R/nue;
% Berechnung der Querschnittswerte
% Ueberpruefung ob laminar / turbulent
% falls turbulent zunaechst Berechnung von lambda und damit ueberpruefen, ob glatt / rau anzuwenden ist 
if Re==0
	lambda=0;
elseif Re>0 && Re<2300 % fuer laminare Stroemung
	lambda=64/Re;
else % fuer turbulente Stroemung
	lambda=0.02; % Startwert der Iteration;
	rs=0.01; % = rechte Seite der Gleichung Startwert der Iteration;
	ls=1/sqrt(lambda); % = linke Seite der Gleichung 
	while abs(ls-rs)>eps % Iteration, solange rs ~= ls
		ls=1/sqrt(lambda); % zunaechst Berechnung mit Uebergangsformel
		rs = -2*log10(2.51/(Re*sqrt(lambda))+ks/(3.71*4*R));
		lambda=(1/rs)^2;
	end
	if Re*sqrt(lambda)*ks/(4*R)<5*sqrt(8) % Ueberprüfung ob glatter Bereich anzuwenden 
		rs=0.01; % = rechte Seite der Gleichung Startwert der Iteration;
		ls=1/sqrt(lambda);  % = linke Seite der Gleichung 
		while abs(ls-rs)>eps
			ls=1/sqrt(lambda);
			rs = -2*log10(2.51/(Re*sqrt(lambda)));
			lambda=(1/rs)^2;
		end
		warning('glatter Bereich')
	elseif Re*sqrt(lambda)*ks/(4*R)>70*sqrt(8) % Ueberprüfung ob rauer Bereich anzuwenden 
		lambda = (1/(-2*log10(ks/(3.71*4*R))))^2;
		warning('rauer Bereich')
	end
end
return