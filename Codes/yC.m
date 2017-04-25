% Programm zur Berechnung der kritischen Fliesstiefe
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
function yc=yC(qs,qsP,Q,g)

if strcmp(qs,'kreis')
    d=qsP(1);
elseif strcmp(qs,'trapez')
    b=qsP(1);
    m=qsP(2);
elseif strcmp(qs,'parabel')
	a=qsp(1);
end

if strcmp(qs,'kreis')
	[phic,fval,info]=fsolve(@(y) phiCKreis(y,d,Q,g),1); % Vorsicht! Reihenfolge beibehalten!
		if info==-3
			error('Vertrauensintervall sehr klein');
		elseif info==0
			error('keine Lösung innerhalb der Iterationen gefunden');
		end
	yc=d*sin(phic/4)*sin(phic/4);
elseif strcmp(qs,'trapez')
	if b==0
		yc=(2*Q^2/(m^2*g))^(1/5); % Dreieckquerschnitt
	elseif m==0
		yc=(Q^2/(b^2*g))^(1/3); % Rechteckquerschnitt
	else
		[yc,fval,info]=fsolve(@(y) yCTrapez(y,b,m,Q,g),1); % Vorsicht! Reihenfolge beibehalten!
		if info==-3
			error('Vertrauensintervall sehr klein');
		elseif info==0
			error('keine Lösung innerhalb der Iterationen gefunden');
		end
	end
elseif strcmp(qs,'parabel')
	yc=(27*a*Q^2/(8*g))^(1/4);
end

endfunction

function f=yCTrapez(y,b,m,Q,g)
f=-g/Q^2+(b+2*m*y)/(b*y+m*y^2)^3;
endfunction

function f=phiCKreis(phi,d,Q,g) 
f=(phi-sin(phi))^3/sin(.5*phi)-512*Q^2/(g*d^5);
endfunction