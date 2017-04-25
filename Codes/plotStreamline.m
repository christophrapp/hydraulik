% Plots 2D Streamlines of the vecor field (x,y,u,v,seed) @ starting points indicated in seed[x,y]
% Finite Differences First Order
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
function stream=plotStreamline(x,y,u,v,dx,dy,seed)

[dudx,dudy]=gradient(u,dx,dy);
[dvdx,dvdy]=gradient(v,dx,dy);

for i=1:size(seed,1)
	stream{i}(1,1)=seed(i,1);
	stream{i}(1,2)=seed(i,2);
	j=1;
	schritte=1;
	X(1)=stream{i}(1,1);
	Y(1)=stream{i}(1,2);
	while X(1)>=min(min(x)) && X(1)<=max(max(x)) && Y(1)>=min(min(y)) && Y(1)<=max(max(Y))
		dt=1; % Zeitschritt im Euler'schen Kontext
		U(1)=interp2(x,y,u,X(1),Y(1)); % interpoliere Geschwindigkeitsfeld u auf genaue (X,Y)-Position
		V(1)=interp2(x,y,v,X(1),Y(1)); % interpoliere Geschwindigkeitsfeld v auf genaue (X,Y)-Position
		dUdx(1)=interp2(x,y,dudx,X(1),Y(1)); % interpoliere Geschwindigkeitsgradient dudx auf genaue (X,Y)-Position
		dUdy(1)=interp2(x,y,dudy,X(1),Y(1));
		dVdx(1)=interp2(x,y,dvdx,X(1),Y(1));
		dVdy(1)=interp2(x,y,dvdy,X(1),Y(1));
		U(1)=U(1)+(U(1)*dUdx(1)+V(1)*dUdy(1))*dt; % Lagrange'sche Geschwindigkeit
		V(1)=V(1)+(U(1)*dVdx(1)+V(1)*dVdy(1))*dt; % Lagrange'sche Geschwindigkeit
		dtx=1e-1*dx/U(1); % Zeit, die vergeht, bis die Bewegung in x-Richtung 0.1*dx beträgt, um Rechenzeit zu sparen
		dty=1e-1*dy/V(1); % Zeit, die vergeht, bis die Bewegung in y-Richtung 0.1*dy beträgt, um Rechenzeit zu sparen
		dt=min(abs(dtx),abs(dty)); % Bewegung in x- oder y-Richtung maximal dx bzw. dy.
		% Berechnung der Zustände am Punkt 2
		X(2)=X(1)+U(1)*dt; % x-Position ist ursprüngliches x+U*dt; Lagrange'scher Weg
		Y(2)=Y(1)+V(1)*dt; % y-Position ist ursprüngliches y+V*dt; Lagrange'scher Weg
		dt=1; % Zeitschritt muss für den Geschwindigkeitsgradienten wieder auf 1 gesetzt werden.
		U(2)=interp2(x,y,u,X(2),Y(2));
		V(2)=interp2(x,y,v,X(2),Y(2));
		dUdx(2)=interp2(x,y,dudx,X(2),Y(2));
		dUdy(2)=interp2(x,y,dudy,X(2),Y(2));
		dVdx(2)=interp2(x,y,dvdx,X(2),Y(2));
		dVdy(2)=interp2(x,y,dvdy,X(2),Y(2));
		U(2)=U(2)+(U(2)*dUdx(2)+V(2)*dUdy(2))*dt;
		V(2)=V(2)+(U(2)*dVdx(2)+V(2)*dVdy(2))*dt;
		U(1)=(U(1)+U(2))/2; % Die Geschwindigkeit wird bei x_0 und x_0+u_0*dt berechnet und gemittelt
		V(1)=(V(1)+V(2))/2; % Die Geschwindigkeit wird bei y_0 und y_0+v_0*dt berechnet und gemittelt
		% Berechnung der Zustände am Punkt 2
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% TEST
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		if isinf(sqrt(U(1)^2+V(1)^2))==1 || isnan(sqrt(U(1)^2+V(1)^2))==1
			break
		else
			% damit bei kleinen u und v nicht nur micrometer vorangeschritten wird (Rechenzeit), werden Mindestschritte berechnet.
			dtx=1e-1*dx/U(1);
			dty=1e-1*dy/V(1);
			dt=min(abs(dtx),abs(dty));
			X(1)=X(1)+U(1)*dt;
			Y(1)=Y(1)+V(1)*dt;
			j=j+1;
			schritte=schritte+1;
			stream{i}(j,1)=X(1);
			stream{i}(j,2)=Y(1);
		end
	end
	fname=sprintf('Anzahl Schritte: %d',schritte);
	disp(fname)
end