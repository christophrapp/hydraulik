% Programm zum Einlesen von Daten
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
function datenEinlesen(data,delimiter,header)

fid=fopen(data);
for i=1:header+1
	line=fgetl(fid);
end
i=1;
while line(1)>0
	j=1;
	while strcmp(line(j),delimiter)~=1
		j=j+1;
	end
	vars{i}=line(1:j-1);
	VARS{i}=str2num(line(j+1:end));
	i=i+1;
	line=fgetl(fid);
end
fclose(fid);

for i = 1:length(vars)
	assignin('base', vars{i}, VARS{i});
end

return