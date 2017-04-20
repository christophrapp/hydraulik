% Berechnung der konjugierten Fliesstiefe aus dem Gleichgewicht der Stuetzkraefte
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
function f=stK(y,qs,qsP,Q,g,rho,StN)

if strcmp(qs,'kreis')
    d=qsP(1);
elseif strcmp(qs,'trapez')
    b=qsP(1);
    m=qsP(2);
elseif strcmp(qs,'parabel')
	a=qsp(1);
end

if strcmp(qs,'kreis')
	f=StN-(rho*Q^2/(flaeche(qs,qsP,y))+schwerpunkt(qs,qsP,y)*rho*g*flaeche(qs,qsP,y));
elseif strcmp(qs,'trapez')
	f=StN-(rho*Q^2/(flaeche(qs,qsP,y))+schwerpunkt(qs,qsP,y)*rho*g*flaeche(qs,qsP,y));
elseif strcmp(qs,'parabel')
	f=StN-(rho*Q^2/(flaeche(qs,qsP,y))+schwerpunkt(qs,qsP,y)*rho*g*flaeche(qs,qsP,y));
end

endfunction