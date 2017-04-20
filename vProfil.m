% Programm zur Visualisierung von Geschwindigkeitsprofilen in einer Rohrstroemung.
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
aufloesung=1000;

v=1;
d=2;

r=-d/2:d/2/aufloesung:0; % 
u=2*v*(1-r.^2./(d/2)^2); % laminar
r=(r+d/2);

plot(r,u,':k', 'linewidth',8)
xlabel('1-r/R', 'fontsize', 20)
ylabel('u_{max}/u', 'fontsize', 20)
hold on
%delta = 14/15*(d/2)^(1/7)/v;
r=0:d/2/aufloesung:d/2;
r=[r,fliplr(r)];
u=15/14*v*(r).^(1/7); % turbulent

plot(r,u,'-k', 'linewidth',8)
h=legend('laminar','turbulent','location','northwest');
set (h, 'fontsize', 20);
set(gca, 'linewidth', 4, 'fontsize', 20)
print('laminarVSturbulent.eps','-depsc')
