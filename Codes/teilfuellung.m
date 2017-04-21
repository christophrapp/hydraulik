% Programm zur Darstellung der Teilfuellungskurve
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
qs='kreis';
d=1;
y=(0:d/100:d)';

A=flaeche(qs,d,y);
U=umfang(qs,d,y);

R=A./U;
R=R./(d/4);
Qt=R.^.625.*A./(d^2*pi/4);
y=y./d;
plot(Qt,y,'-k','linewidth',8)
hold on
plot([1,1],[0,1],'--k','linewidth',4)
xlabel('Q_t/Q_v [-]', 'fontsize', 20,'fontweight','bold')
ylabel('y/d [-]', 'fontsize', 20,'fontweight','bold')
set(gca, 'linewidth', 4, 'fontsize', 20,'fontweight','bold')
limits=axis([0,1.2,0,1]);
%print('teilfuellung4.pdf','-dpdf')
print('teilfuellung4.eps','-depsc')
