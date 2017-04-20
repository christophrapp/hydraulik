% Programm fuer die Elementarloesung von Quellen-/Senkenstroemungen
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
function [phi,psi,u,v]=source(x,y,posX,posY,Q)

phi=zeros(size(x,1),size(x,2));
psi=zeros(size(x,1),size(x,2));
for i=1:size(x,2)
	for j=1:size(y,1)
		phi(j,i)=Q/(2*pi)*log(sqrt((x(j,i)-posX)^2+(y(j,i)-posY)^2));
		psi(j,i)=Q/(2*pi)*atan((y(j,i)-posY)/(x(j,i)-posX));
		u(j,i)=Q/(2*pi)*(x(j,i)-posX)/((x(j,1)-posX)^2+(y(j,1)-posY)^2);
		v(j,i)=Q/(2*pi)*(y(j,i)-posY)/((x(j,1)-posX)^2+(y(j,1)-posY)^2);
	end
end
endfunction