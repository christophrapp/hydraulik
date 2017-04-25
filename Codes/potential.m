% Programm zur Berechnung von Potentialstroemungen
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
warning("off") % division by zero wird nicht angezeigt

% Daten einlesen
readData("datenGW.csv","=");
% Daten einlesen

% Woraus setzt sich das Strömungsfeld zusammen?
flow=[];
f=1; % Strömungsart
if exist("source.csv","file")==2
	readData("source.csv","=");
	i=1;
	while i<=size(SposX,2)
		flow{f}="source"; f=f+1; i=i+1;
	end
end
if exist("dipol.csv","file")==2
	readData("dipol.csv","=");
	i=1;
	while i<=size(DposX,2)
		flow{f}="dipol"; f=f+1; i=i+1;
	end
end
if exist("vortex.csv","file")==2
	readData("vortex.csv","=");
	i=1;
	while i<=size(VposX,2)
		flow{f}="vortex"; f=f+1; i=i+1;
	end
end
if exist("parallel.csv","file")==2
	readData("parallel.csv","=");
	i=1;
	while i<=size(u0,2)
		flow{f}="parallel"; f=f+1; i=i+1;
	end
end
f=f-1;
% Woraus setzt sich das Strömungsfeld zusammen?

% Berechnungsgebiet initialisieren
lx=floor(lx); % auf ganze Zahlen begrenzen
ly=floor(ly); % auf ganze Zahlen begrenzen
[x,y]=meshgrid(-lx:dx:lx,-ly:dy:ly);
x=x-offset(1);
y=y-offset(2);

PHI=zeros(size(x,1),size(x,2));
PSI=zeros(size(x,1),size(x,2));
U=zeros(size(x,1),size(x,2));
V=zeros(size(x,1),size(x,2));
% Berechnungsgebiet initialisieren

% Core
l=1;
while l<=f
	if strcmp(flow{l},"source")==1
		[phi,psi,u,v]=source(x,y,SposX(1),SposY(1),SQ(1)); SposX(1)=[]; SposY(1)=[]; SQ(1)=[];
	elseif strcmp(flow{l},"dipol")==1
		[phi,psi,u,v]=dipol(x,y,DposX(1),DposY(1),Dm(1)); DposX(1)=[]; DposY(1)=[]; Dm(1)=[];
	elseif strcmp(flow{l},"vortex")==1
		[phi,psi,u,v]=vortex(x,y,VposX(1),VposY(1),Vgamma(1)); VposX(1)=[]; VposY(1)=[]; Vgamma(1)=[];
	elseif strcmp(flow{l},"parallel")==1
		[phi,psi,u,v]=parallel(x,y,u0(1),v0(1)); u0(1)=[]; v0=[];
	end
	PHI=PHI+phi;
	PSI=PSI+psi;
	U=U+u;
	V=V+v;
	l=l+1;
end
% Core

% Geschwindigkeitsfeld
[u,v]=gradient(PHI,dx,dy);
% Geschwindigkeitsfeld

% piezometrische Höhe des Wasserspiegels berechnen
h=-PHI/kf;
% piezometrische Höhe des Wasserspiegels berechnen

% Plot
%contour(x,y,PSI,[min(PSI(finite(PSI))):(max(PSI(finite(PSI)))-min(PSI(finite(PSI))))/ceil((anzahlSLx+anzahlSLy)/2):max(PSI(finite(PSI)))],'-k')
hold on
contour(x,y,PHI,[min(PHI(finite(PHI))):(max(PHI(finite(PHI)))-min(PHI(finite(PHI))))/ceil((anzahlSLx+anzahlSLy)/2):max(PHI(finite(PHI)))],'-k')
hold off
fname=sprintf('plot.png');
print(fname,'-dpng')
surfc(x,y,h)
hold on
contour(x,y,PSI,[0 0],'-k')
hold off
fname=sprintf('surf.png');
print(fname,'-dpng')
% Plot

figure
% Potentiallines
contour(x,y,PHI,[min(PHI(finite(PHI))):(max(PHI(finite(PHI)))-min(PHI(finite(PHI))))/ceil((anzahlSLx+anzahlSLy)/2):max(PHI(finite(PHI)))],'-k','linewidth',4)
% Potentiallines
hold on
% Streamlines
seed=[];
seedX(:,2)=(min(min(y)):(max(max(y))-min(min(y)))/anzahlSLy:max(max(y)))';
seedX(:,1)=min(min(x));
seed=seedX;
seedX(:,1)=max(max(x));
seed=[seed;seedX];
seedY(:,1)=(min(min(x)):(max(max(x))-min(min(x)))/anzahlSLx:max(max(x)))';
seedY(:,2)=min(min(y));
seed=[seed;seedY];
seedY(:,2)=max(max(y));
seed=[seed;seedY];
% fuer Doublette
r=25;
alpha=(0:30:330)';
xS=r.*cos(alpha/180*pi)+150;
yS=r.*sin(alpha/180*pi)+150;
seed=[seed;xS,yS];
% fuer Doublette
stream=plotStreamline(x,y,u,v,dx,dy,seed);
for i=1:size(seed,1)-size(xS,1)
	plot(stream{i}(:,1),stream{i}(:,2),'-b','linewidth',4)
end
% Streamlines

for i=size(seed,1)-size(xS,1)+1:size(seed,1)
	plot(stream{i}(:,1),stream{i}(:,2),'-r','linewidth',4)
end
% fuer Kontamination
% % % seed=[seed;300,200];
% % % stream{i+1}=plotStreamline(x,y,u,v,dx,dy,seed(end,:));
% % % plot(stream{i+1}(:,1),streamH{i+1}(:,2),'-r','linewidth',4)
% fuer Kontamination

axis equal
fname=sprintf('streamL.png');
print(fname,'-dpng')
hold off