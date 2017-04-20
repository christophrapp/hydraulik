% Berechnung der konjugierten Fliesstiefe
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
function yk=konjugiert(qs,qsP,y,Q,g,rho,yc)

if strcmp(qs,'kreis')
    d=qsP(1);
elseif strcmp(qs,'trapez')
    b=qsP(1);
    m=qsP(2);
elseif strcmp(qs,'parabel')
	a=qsp(1);
end

A=flaeche(qs,qsP,y);
bwsp=bWsp(qs,qsP,y);
sp=schwerpunkt(qs,qsP,y);

Fr=Q/A/sqrt(g*A/bwsp);
StN=rho*Q^2/A+sp*rho*g*A; % Stützkraft der Normalwasserverhältnisse
% Startwert
if Fr>1
	yGuess=yc*1.5;
elseif Fr<1
	yGuess=yc/1.5;
end
% Startwert
if strcmp(qs,'kreis')
	[yk,fval,info]=fsolve(@(yk) stK(yk,qs,d,Q,g,rho,StN),yGuess); 
	% Vorsicht! Reihenfolge beibehalten!
elseif strcmp(qs,'trapez')
	if m==0
		yk=y/2*(sqrt(1+8*Fr^2)-1);
	else
		[yk,fval,info]=fsolve(@(yk) stK(yk,qs,qsP,Q,g,rho,StN),yGuess); 
		% Vorsicht! Reihenfolge beibehalten!
	end
elseif strcmp(qs,'parabel')
	[yk,fval,info]=fsolve(@(yk) stK(yk,qs,a,Q,g,rho,StN),yGuess); 
	% Vorsicht! Reihenfolge beibehalten!
end

return