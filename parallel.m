% Programm für die Elementarloesung von Parallelstroemungen
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
function [phi,psi,u,v]=parallel(x,y,u0,v0)

phi=zeros(size(x,1),size(x,2));
psi=zeros(size(x,1),size(x,2));
for i=1:size(x,2)
	for j=1:size(y,1)
		phi(j,i)=u0*x(j,i)+v0*y(j,i);
		psi(j,i)=u0*y(j,i)+v0*x(j,i);
		u(j,i)=u0;
		v(j,i)=v0;
	end
end
endfunction