% Programm zur Visualisierung der Couette-Stroemung
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
mu=1e-3; % [kg/(ms)]
aufloesung=1000;
B=input('Geben Sie die Breite des Kanals B ein: '); % [m]
dpdx=input('Geben Sie den Druckgradienten dp/dx ein: '); % [N/m3]
uB=input('Geben Sie die Geschwindigkeit der oberen Platte ein: '); % [m/s]

z=(0:B/aufloesung:B)';

u=uB/B.*z+1/mu*dpdx.*z/2.*(z-B);

plot(u,z)

print('Geschwindigkeitsprofil.png','-dpng') 
