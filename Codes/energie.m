% Berechnung der Darcy-Weisbach-Gleichung für Rohrstroemungen
% der Auslaufverlust muss in sZeta angegeben werden
% ist die Fliesstiefe, also d im Rohr und je nachdem bei Trapez oder Rechteck
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
function f=energie(Q,qs,qsP,y,l,ks,sZeta,A0,At,mue,g,T,dH)

f=-dH+Q^2/(flaeche(qs,qsP,y)^2*2*g)*(sZeta+At^2/...
(mue^2*A0^2)+pc(qs,qsP,y,Q,ks,T)*l/(4*flaeche(qs,qsP,y)/umfang(qs,qsP,y)));

endfunction