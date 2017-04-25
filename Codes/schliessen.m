% Programm zur Berechnung der Oeffnungsflaeche an einem Verschlussorgan
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
function At=schliessen(A0,ts,t,spalt,verschlussArt)

if strcmp(verschlussArt,'linear')==1
	At=(1-t/ts)*A0;
	At=max(At,spalt*A0);
elseif strcmp(verschlussArt,'hyperbel')==1
	At=ts/t*spalt*A0;
end

return