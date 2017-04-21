% Programm zur Berechnung des benetzten Umfangs 
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
function U=umfang(qs,qsP,y)

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
	alpha=2*acos(1-y/r); % ganzer Öffnungswinkel
	U=r*alpha; % benetzter Umfang
elseif strcmp(qs,'trapez')   
    U=b+2*y*sqrt(1+m^2); % benetzter Umfang
elseif strcmp(qs,'parabel')
	p=1/(2*abs(a)); % Halbparameter
	U=p/2*(sqrt(2*y/p*(1+2*y/p))+log(sqrt(2*y/p)+sqrt(1+2*y/p)))*2; % siehe Bronstein S. 211; Bogen doppelt! also * 2
end

return