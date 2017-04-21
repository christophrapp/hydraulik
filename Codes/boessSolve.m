% Berechnung Boess-Gleichung mit den Reibungsansaetzen nach Manning-Strickler und Prandtl-Colebrook
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
function f=boessSolve(y,qs,qsP,yK,Q,g,T,ks,kSt,JS,dx,toggle)

if strcmp(toggle,'SCH')
	if kSt==0	
		f=-y+yK+(Q/flaeche(qs,qsP,yK))^2/(2*g)-(Q/flaeche(qs,qsP,y))^2/(2*g)+...
		(JS-(.5*(Q/flaeche(qs,qsP,y)+Q/flaeche(qs,qsP,yK)))^2/(8*g)*...
		pc(qs,qsP,(y+yK)/2,Q,ks,T)/((flaeche(qs,qsP,y)+flaeche(qs,qsP,yK))/...
		(umfang(qs,qsP,y)+umfang(qs,qsP,yK))))*dx;
		
	elseif ks==0
	f=-y+yK+(Q/flaeche(qs,qsP,yK))^2/(2*g)-(Q/flaeche(qs,qsP,y))^2/(2*g)+...
		(JS-(.5*(Q/flaeche(qs,qsP,y)+Q/flaeche(qs,qsP,yK)))^2/...
		(kSt^2*((flaeche(qs,qsP,y)+flaeche(qs,qsP,yK))/...
		(umfang(qs,qsP,y)+umfang(qs,qsP,yK)))^(4/3)))*dx;
	end
elseif strcmp(toggle,'STR')
	if kSt==0
	f=-y+yK+(Q/flaeche(qs,qsP,yK))^2/(2*g)-(Q/flaeche(qs,qsP,y))^2/(2*g)+...
		((.5*(Q/flaeche(qs,qsP,y)+Q/flaeche(qs,qsP,yK)))^2/(8*g)*...
		pc(qs,qsP,(y+yK)/2,Q,ks,T)/((flaeche(qs,qsP,y)+flaeche(qs,qsP,yK))/...
		(umfang(qs,qsP,y)+umfang(qs,qsP,yK)))-JS)*dx;
	elseif ks==0
	f=-y+yK+(Q/flaeche(qs,qsP,yK))^2/(2*g)-(Q/flaeche(qs,qsP,y))^2/(2*g)+...
		((.5*(Q/flaeche(qs,qsP,y)+Q/flaeche(qs,qsP,yK)))^2/...
		(kSt^2*((flaeche(qs,qsP,y)+flaeche(qs,qsP,yK))/...
		(umfang(qs,qsP,y)+umfang(qs,qsP,yK)))^(4/3))-JS)*dx;
	end
end
endfunction