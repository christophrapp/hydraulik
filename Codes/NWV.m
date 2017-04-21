% Programm zur Loesung der Normalwassergleichungen mit den Reibungsansaetzen von Manning-Strickler und Prandtl-Colebrook
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
function f=NWV(y,qs,qsP,Q,g,T,ks,kSt,JS)
JE=JS;
if ks==0
	f=-Q+kSt * sqrt(JE) * flaeche(qs,qsP,y)^(5/3) / umfang(qs,qsP,y)^(2/3);
elseif kSt==0
	f=-Q+flaeche(qs,qsP,y)*sqrt(8*g*flaeche(qs,qsP,y)*...
	JE/(umfang(qs,qsP,y)*pc(qs,qsP,y,Q,ks,T)));
end
endfunction