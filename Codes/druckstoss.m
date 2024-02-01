% Programm zur Berechnung des Druckstosses in Rohrleitungen mit Hilfe des Charakteristikenverfahrens
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

% Physikalische Größen
g=9.80566; % [m/s²]
Ef=2.1E9; % [N/m²]
rho=1000; %[kg/m³]
T=20; % [°C]
hAtm=10; % [mWs] Atmosphärische Druckhöhe
n=1.2; % [] abgeänderter kappa-Wert, der das Verhältnis der spez. Wärme bei konst. Druck gg. konst. Temp. wiedergibt.
nue=csvread('kinViskositaet.csv');
pD=csvread('dampfdruck.csv');
nue=interp1(nue(:,1),nue(:,2),T);
pD=interp1(pD(:,1),pD(:,2),T);
% Physikalische Größen

% Leitungsdaten
L=6000; % [m]
Er=2.1E11; % [N/m²] E-Modul des Rohres
ho=312; % [m]
hu=298; % [m]
d=.3; % [m]
A=(d/2)^2*pi; % [m²]
ks=1E-3; % [m] äquivalente Sandrauheit
sZeta=0; % [] Summe der Einzelverluste OHNE Auslauf- bzw. Schieberverlust
w=0.008; % [m] Wandstärke des Rohrs
mueq=0.33; % [] Querkontraktionsziffer
% Leitungsdaten

% Leitungsverlauf
%x-Position in [m], Organkennzeichen:
%erste Zeile: x, zweite Zeile y, dritte Zeile z, vierte Zeile Organtyp
%0 Standardwert, nix tut sich, gerade Leitung
%1 offenes Ende,
%2 Schieber: vVerschluss, vVerschluss
%3 veränderliche Geschwindigkeit: vvont
%4 veränderlicher WSP Im Reservoir: hvont
%5 Streckenschieber
%6 Wasserschloss
%7 Windkessel
xyz=[0,L/2,L;0,0,0;ho-5,(ho+hu)/2-5,hu-5;1,0,2];
leitungsverlauf=input("piezometrische DH (piezo), Druckstosshoehe (nur), Druckhoehe (DL): ", 's');
% Leitungsverlauf

% Verschlussorgan
A0=A;%.0356; % [m²] Öffnungsfläche zu Beginn des Schließvorgangs
fname=sprintf('A0=A=%1.3f m2',A0);
disp(fname);
A0Neu=input('A0 aendern? Wenn ja, dann Wert angeben in m2: ');
if isempty(A0Neu)==0
	A0=A0Neu;
end
At=A0; % nur für den stationären Fall
mue=0.98; % [] Durchflussbeiwert / Verlust im Schieber
ts=30; % [s] Verschlusszeit
verschlussArt=input('Schliessgesetz linear/hyperbel: ','s'); %  Schließgesetz
spalt=0; % spalt heisst wieviel der QS-Fläche bei der Verschlusszeit noch offen ist
% Verschlussorgan

% Besondere Einbauten
V0=1E-2; % [m³] ursprüngliches Luftvolumen im Windkessel
% Besondere Einbauten

% Charakteristikensystem
stuetzstellen=3; % als j indiziert (Spalten)
zeitschritte=40; % als i indiziert (Zeilen)
positionsgenau=10; % Wert, der angibt, ob ein Verschlussorgan auf einer Stützstelle liegt
jPlot=stuetzstellen; % Stützstelle, deren Druckverlauf geplottet werden soll
% Charakteristikensystem

% Berechnung von Deltax und Delta t
deltax=L/(stuetzstellen-1);
a=sqrt(1/rho/(1/Ef+d*(1-mueq^2)/(Er*w)));
fname=sprintf('a=%3d m/s',a);
disp(fname);
aNeu=input('a aendern? Wenn ja, dann Wert angeben in m/s: ');
if isempty(aNeu)==0
	a=aNeu;
end
deltat=deltax/a;
x=(0:deltax:L); % Position Stuetzstellen
topo=interp1(xyz(1,:),xyz(3,:),x);
% Berechnung von Deltax und Delta t

% Stationärer Fall / Bernoulli mit Darcy-Weisbach; Prandtl-Colebrook
[Q,fval,info]=fsolve(@(Q)energie(Q,'kreis',d,d,L,ks,sZeta,A0,At,mue,g,T,ho-hu),sqrt(2*g*(ho-hu))*A);
v0=Q/A;
lambda=pc('kreis',d,d,Q,ks,T);
% Stationärer Fall / Bernoulli mit Darcy-Weisbach; Prandtl-Colebrook

% % Wo passiert was??
o=zeros(1,stuetzstellen); % gibt an, ob ein Organ an der Stelle ist
for k=1:size(xyz,2)
    for l=1:length(x)
        if abs(xyz(1,k)-x(l))<positionsgenau;
            o(l)=xyz(4,k);
        end
    end
end
pos=find(o,2); % sucht die Stützstelle des Verschlussorgans
% % Wo passiert was??

% Joukowsky-Stoß
maxh=a/g*v0;
if 2*L/a>ts
    fname=sprintf('Der Joukowsky-Stoss tritt auf: maxh=%1.2f m\n',maxh);
    disp(fname)
else
    fname=sprintf('Der Joukowsky-Stoss (maxh=%1.2f m) tritt nicht auf.\n',maxh);
    disp(fname)
end
% Joukowsky-Stoß

% Initialisierung
kp=zeros(zeitschritte,stuetzstellen); 
km=zeros(zeitschritte,stuetzstellen); 
% kp für +Charakteristik,km für -Charakteristik
h=zeros(zeitschritte,stuetzstellen);
v=zeros(zeitschritte,stuetzstellen);
Je=zeros(zeitschritte,stuetzstellen);
vrK=[ones(1,stuetzstellen);zeros(1,stuetzstellen)]; % falls Kavitation auftritt
vlK=[ones(1,stuetzstellen);zeros(1,stuetzstellen)]; % falls Kavitation auftritt

lK=zeros(1,stuetzstellen); % falls Kavitation auftritt
% Initialisierung

% Stationäre Lösung
h(1,:)=ho-v0^2/(2*g)*(lambda*x./d); % h(x), stationärer Fall mit sZeta=0 und EL=DL
v(1,:)=v0; % v(x), stationärer Fall
% Stationäre Lösung

% Anfangscharakteristik erster Zeitschritt
Je(1,:)=sign(v(1,:))*lambda/d.*v(1,:).^2/(2*g);
km(1,:)=-h(1,:)+a/g*v(1,:)-a*deltat*Je(1,:);
kp(1,:)=-h(1,:)-a/g*v(1,:)+a*deltat*Je(1,:);
% Anfangscharakteristik erster Zeitschritt

% Instationäre Berechnung über Charakteristiken-Verfahren
for i=2:zeitschritte
    for j=1:stuetzstellen
        if j==1 % oberste Stelle nur bei ungeraden zeitschritten
            if rem(i,2)==1 % i=zeitschritt==ungerade
                if o(1,j)==1
                    v(i,j)=g/a*(ho+km(i-1,j+1));
                    h(i,j)=ho;
                elseif o(1,j)==2
					At=schliessen(A0,ts,(i-1)*deltat,spalt,verschlussArt);
                    v(i,j)=vVerschluss(ho,km(i-1,j+1),mue,At,A,a,g,'oben');
					h(i,j)=a/g*v(i,j)-km(i-1,j+1);
                elseif o(1,j)==3
                    v(i,j)=vvont();
                    h(i,j)=a/g*vvont()-km(i-1,j+1);
                elseif o(1,j)==4
                    h(i,j)=hvont();
					v(i,j)=a/g*(h(i,j)+km(i-1,j+1));
                end
			elseif rem(i,2)==0 % zeitschritt gerade
				v(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
				h(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
            end
        elseif j==stuetzstellen % unterste Stelle
            if rem(i,2)==1 % i=zeitschritt==ungerade
                if o(1,j)==1
                    v(i,j)=-g/a*(hu+kp(i-1,j-1));
                    h(i,j)=hu;
                elseif o(1,j)==2
                    At=schliessen(A0,ts,(i-1)*deltat,spalt,verschlussArt);
					v(i,j)=vVerschluss(hu,kp(i-1,j-1),mue,At,A,a,g,'unten');
                    h(i,j)=-a/g*v(i,j)-kp(i-1,j-1);
                elseif o(1,j)==3
                    v(i,j)=vvont();
					h(i,j)=-a/g*vvont-kp(i-1,j-1);
                elseif o(1,j)==4
                    h(i,j)=hvont();
					v(i,j)=-g/a*(h(i,j)+kp(i-1,j-1));
                end
			elseif rem(i,2)==0 % zeitschritt gerade
				v(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
				h(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
            end
			% alle geraden Stellen und alle geraden Zeitschritte ODER
			% alle ungeraden Stellen und alle ungeraden Zeitschritte
        elseif rem(j,2)==0 && rem(i,2)==0 || rem(j,2)==1 && rem(i,2)==1 
			if o(1,j)==0
				v(i,j)=g/a*(km(i-1,j+1)-kp(i-1,j-1))/2;
				h(i,j)=-(km(i-1,j+1)+kp(i-1,j-1))/2;
			end
		elseif rem(j,2)==0 && rem(i,2)==1 || rem(j,2)==1 && rem(i,2)==0
				v(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
				h(i,j)=NaN; % an dieser Stelle ist zu diesem Zeitpunkt die Lösung der Gleichungen unmöglich
        end
        Je(i,j)=sign(v(i,j))*pc('kreis',d,d,abs(v(i,j))*d^2*pi/4,ks,T)...
			/d*v(i,j)^2/(2*g);
        km(i,j)=-h(i,j)+a/g*v(i,j)-a*deltat*Je(i,j);
        kp(i,j)=-h(i,j)-a/g*v(i,j)+a*deltat*Je(i,j);
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Hier kommt die Überprüfung auf Kavitation
		p=rho*g*(h(i,j)-topo(1,j)+hAtm);
		if p<pD
			fname=sprintf('Vorsicht Kavitation! t=%1.2f, j=%1.2f, Druckhoehe h=%1.2f m', deltat*(i-1), j, h(i,j)-topo(1,j)+hAtm);
			disp(fname)
			h(i,j)=topo(1,j)-hAtm+pD/(rho*g);
			if j==1
				vr=g/a*(h(i,j)+km(i-1,j+1));
				vl=0;
			elseif j==stuetzstellen
				vl=-g/a*(h(i,j)+kp(i-1,j-1));
				vr=0;
			else
				vr=g/a*(h(i,j)+km(i-1,j+1));
				vl=-g/a*(h(i,j)+kp(i-1,j-1));
			end
			km(i,j)=-h(i,j)+a/g*vr-a*deltat*Je(i,j);
			kp(i,j)=-h(i,j)-a/g*vl+a*deltat*Je(i,j);
			% Je bleibt unberührt, da das ursprüngliche v(i,j)=1/2(vl+vr).
			if vrK(1,j)~=i-2
				lK(1,j)=0; % falls im Zeitschritt davor an dieser Stelle (i-2) kein Dampfdruck mehr herrschte.
			end
			lK(1,j)=lK(1,j)+.5*(vr-vl+vrK(2,j)-vlK(2,j))*deltat;
			vrK(1,j)=i; vrK(2,j)=vr;
			vlK(1,j)=i;	vlK(2,j)=vl;
			fname=sprintf('Laenge Kavitationsblase lK=%1.2f m, vr=%1.2f m/s, vl=%1.2f m/s\n', lK(1,j), vr, vl);
			disp(fname)
		end
		% Hier kommt die Überprüfung auf Kavitation
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
% Instationäre Berechnung über Charakteristiken-Verfahren
% Ausgabe Druckhoehe in Leitung
fname=sprintf('Die maximale Druckhoehe ist: %1.2f m\nDie minimale Druckhoehe ist: %1.2f m',max(max(h-topo)),min(min(h-topo)));
disp(fname)
% Ausgabe Druckhoehe in Leitung
% Hier wird noch der Leitungsverlauf wie oben abgefragt eingerechnet
if strcmp(leitungsverlauf,'nur')==1
    for i=1:zeitschritte
        for j=1:stuetzstellen
            if h(i,j)~=0
                h(i,j)=h(i,j)-topo(1,j);
            end
        end
    end
elseif strcmp(leitungsverlauf,'DL')==1
    for i=zeitschritte:-1:1
        for j=1:stuetzstellen
            if h(i,j)~=0
                h(i,j)=h(i,j)-h(1,j);
            end
        end
    end
end
% Hier wird noch der Leitungsverlauf wie oben abgefragt eingerechnet
% Plot
zeit=(0:deltat:deltat*(zeitschritte-1))';
plot(zeit(!isnan(h(:,jPlot))),h(!isnan(h(:,jPlot)),jPlot),'-k','linewidth',8)
hold on
plot(zeit(!isnan(h(:,jPlot-1))),h(!isnan(h(:,jPlot-1)),jPlot-1),'-.k','linewidth',8)
plot(zeit(!isnan(h(:,jPlot-2))),h(!isnan(h(:,jPlot-2)),jPlot-2),':k','linewidth',8)
legende=legend('Rohrleitungsende', 'Rohrleitungsmitte', 'Rohrleitungsanfang');
if strcmp(leitungsverlauf,'piezo')==1
    title('zeitlicher Verlauf der piezometrischen Druckhoehe','fontsize',18)
elseif strcmp(leitungsverlauf,'nur')==1
    title('zeitlicher Verlauf der Druckhoehe','fontsize',18)
elseif strcmp(leitungsverlauf,'DL')==1
    title('zeitlicher Verlauf der Druckstosshoehe gegenueber stat. Druckhoehe','fontsize',18)
end
set(legende, 'fontsize', 18)
xlabel('t [s]', 'fontsize', 18)
ylabel('h_p [m]', 'fontsize', 18)
set(gca, 'fontsize', 18)
print('druckstossBsp.png','-dpng')
print('druckstossBsp.pdf','-dpdf')
% Plot
