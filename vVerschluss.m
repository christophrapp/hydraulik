% Programm zur Loesung der Schieber-Gleichung
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
function v=vVerschluss(h,k,mue,At,A,a,g,ort)

if strcmp(ort,'unten')==1
	v=sign(-h-k)*(-1*mue^2*At^2/A^2*a+...
        sqrt(mue^4*At^4/A^4*a^2+2*g*mue^2*At^2/A^2*...
        abs(-h-k)));             
elseif strcmp(ort,'oben')==1
	v=sign(h+k)*(-1*mue^2*At^2/A^2*a+...
        sqrt(mue^4*At^4/A^4*a^2+2*g*mue^2*At^2/A^2*...
        abs(h+k)));
end
return