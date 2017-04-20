% Berechnung des Schwerpunkts einer Flaeche 
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
function sp=schwerpunkt(qs,qsP,y)

if strcmp(qs,'kreis')
    d=qsP(1);
elseif strcmp(qs,'trapez')
    b=qsP(1);
    m=qsP(2);
elseif strcmp(qs,'parabel')
	a=qsp(1);
end

if strcmp(qs,'kreis')
	r=d/2;
	alpha=acos((r-y)/r); % halber Öffnungswinkel
	A=flaeche(qs,qsP,y);
	sp=y-(r-bWsp(qs,qsP,y)^3/(12*A));
elseif strcmp(qs,'trapez')   
	bwsp=bWsp(qs,qsP,y);
    sp=y/3*(bwsp+2*b)/(bwsp+b);
elseif strcmp(qs,'parabel')
	sp=2/5*y;
end

return