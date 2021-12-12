clc
clear all
close all
warning('off')

% Dimension de l'aile et propriétés  
Longueur = 10;
Largeur = 2;
Epaisseur =0.3;
Paroi = 0.05;
E = 70*10^3;%MPa
RHO = 2700;
A = Largeur*Epaisseur-(Largeur-2*Paroi)*(Epaisseur-2*Paroi);
I = (A*Longueur*RHO)*(Longueur/2)^2; %Equivaut a mr^2 avec masse au CG

% Moteur  
LM =  4;% Emplacement du moteur
MM =  1000;% Masse du moteur

% Carburant 
LC1 =  2; % Début de la zone de carburant
LC2 =  6;% Fin de la zone de carburant
MC  =  304; % Masse par unité de longueur

% Calcul des fréquences et modes propres par la méthode des modes supposés

% Nombre de modes à calculer  
N = 5;

% Calcul de Betak.L, un vecteur [1 x N]  
BL = ([1:N]-0.5)*pi;
for i = 1:N
    [BL(i),fval,exitflag] = fzero(@(x) cos(x)*cosh(x)+1,BL(i));
            optimset('TolX',1e-8);
end

% Calul de mij et kij     
m = (RHO*A); %kg/m
mij = zeros(N,N);
kij = zeros(N,N);
for i = 1:N
    for j = i:N
    mij(i,j) = quadgk(@(x)m*Xij(x,BL(i),BL(j),Longueur),0,Longueur)+ ...
   quadgk(@(x)(MC*Xij(x,BL(i),BL(j),Longueur)+MM*Xij(LM,BL(i),BL(j), ... 
Longueur)),LC1,LC2);  
        mij(j,i) = mij(i,j);
        
        kij(i,j) = quadgk(@(x)E*I*Xij_dd(x,BL(i),BL(j),Longueur),0,Longueur);
        kij(j,i) = kij(i,j); 
    end
end

% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Calul des fréquences propres    
[PHI,D] = eig(kij,mij);
for i=1:length(D)
    OMEGA(i) = sqrt(D(i,i));
end



% Calcul de modes propres    %%% A compléter %%%
v_AM = Modes_MS(mij,x,Longueur,BL);

% Tracage des 5 premier Modes
Nb_Modes = 5;
for i = 1:Nb_Modes
figure(i)
hold on
plot(x,v_AM(:,i),'-b')
end    
hold off                           
hold on
figure(Nb_Modes+1)
plot(x,v_AM(:,1),x,v_AM(:,2),x,v_AM(:,3),x,v_AM(:,4),x,v_AM(:,5));
%Fin du programme 

