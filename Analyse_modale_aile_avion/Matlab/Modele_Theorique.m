clc
clear all
close all

% Dimension de l'aile et propriétés 
Longueur = 10;
Largeur = 2;
Epaisseur =0.3;
Paroi = 0.05;
E = 70e9; %Pa
RHO = 2700;
A = Largeur*Epaisseur-(Largeur-2*Paroi)*(Epaisseur-2*Paroi);
I = Largeur*Epaisseur^3/12-(Largeur-2*Paroi)*(Epaisseur-2*Paroi)^3/12; %Equivaut a mr^2 avec masse au CG

% Calcul des fréquences propres et modes propres théorique (sans moteur ni carburant)

% Nombre de modes à calculer
N = 5;

% Calcul de Betak.L, un vecteur [1 x N]  
BL = ([1:N]-0.5)*pi;
for i = 1:N
    [BL(i),fval,exitflag] = fzero(@(x) cos(x)*cosh(x)+1,BL(i));
            optimset('TolX',1e-8);
end
Bk=(BL/Longueur);
% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Initialisation du vecteur OMEGA_theorique
OMEGA_theorique = zeros(N,1);
% Initialisation de la matrice v_theorique
v_theorique = zeros(Nb_Points,N);

% Calcul des modes propres théoriques  %%% A compléter %%%
for i = 1:N
    OMEGA_theorique(i) = (Bk(i))^2*sqrt(E*I/(RHO*A));
    
    v_theorique(:,i) = Xi(x,BL(i),Longueur);
    
    % Normalisation du vecteur propre
    v_theorique(:,i) = abs(v_theorique(2,i))/(v_theorique(2,i))*(v_theorique(:,i)/norm(v_theorique(:,i)));
end


% Tracage des 5 premier Modes
Nb_Modes = 5;
for i = 1:Nb_Modes
    figure(i)
    hold on
    plot(x,v_theorique(:,i),'-k')
end
hold off
hold on
figure(Nb_Modes+1)
plot(x,v_theorique(:,1),x,v_theorique(:,2),x,v_theorique(:,3),x,v_theorique(:,4),x,v_theorique(:,5));
%Fin du programme