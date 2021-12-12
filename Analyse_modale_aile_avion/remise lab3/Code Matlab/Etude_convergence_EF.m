clc
clear all
close all

% Dimension de l'aile et propriétés  
Longueur =10;%m
Largeur =2;%m
Epaisseur =0.3;%m
Paroi =0.05;%m
E = 70e9;%Pa
RHO = 2700; %kg/m^2
A =Largeur*Epaisseur-(Largeur-2*Paroi)*(Epaisseur-2*Paroi);
I =Largeur*Epaisseur^3/12-((Largeur-2*Paroi)*(Epaisseur-2*Paroi)^3)/12;

% Moteur  
LM = 4; % Emplacement du moteur
MM = 1000; % Masse du moteur

% Carburant   
LC1 = 2;  % Début de la zone de carburant
LC2 = 6;  % Fin de la zone de carburant
MC  = 304;  % Masse par unité de longueur

% Maillage
Nb_Elements = 10;
L = Longueur/Nb_Elements;
DDL = 2*(Nb_Elements+1);

% Matrice de rigidité et de masse d'une poutre   
K_poutre = E*I/L^3.*[12 6*L -12 6*L; 6*L 4*L^2 -6*L 2*L^2;-12 -6*L 12 -6*L; 6*L 2*L^2 -6*L 4*L^2];%
M_poutre = RHO*A*L/420*[156 22*L 54 -13*L; 22*L 4*L^2 13*L -3*L^2; 54 13*L 156 -22*L; -13*L -3*L^2 -22*L 4*L^2];%

% Matrice de rigidité et de masse globale du système    
K = zeros(DDL,DDL);
M = zeros(DDL,DDL);
for i = 1:2:DDL-3
    K(i:i+3,i:i+3) = (K(i:i+3,i:i+3)+K_poutre);
    M(i:i+3,i:i+3) = M(i:i+3,i:i+3)+M_poutre;
end

% Ajout de la masse du moteur  
Noeud = 0.4*Nb_Elements+1;
M(2*Noeud-1,2*Noeud-1) = M(2*Noeud-1,2*Noeud-1)+MM;

%Ajout de la masse du carburant   
Noeud1 =3;
M(2*Noeud1-1,2*Noeud1-1) =M(2*Noeud1-1,2*Noeud1-1)+MC*L/2;
Noeud2 =7;
M(2*Noeud2-1,2*Noeud2-1) =M(2*Noeud2-1,2*Noeud2-1)+MC*L/2;

for i = 2*Noeud1+1:2:2*Noeud2-3
    M(i,i) = M(i,i)+MC*L;
end

% Conditions aux rives
K = K(3:end,3:end); %Mets le premier noeud encastre a zero
M = M(3:end,3:end);
Nb_DDL = length(K);

% Calcul des fréquences propres (numériquement)    
[PHI,D] = eig(K,M);
OMEGA1 = sqrt(D);
PHI = [zeros(2,Nb_DDL);PHI];

% Calcul des modes propres (numériquement)

% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Calcul des modes propres    
[v_FEM1] = Modes_EF(PHI,x,Longueur,Nb_Elements);
%Analyse de la convergence
erreur=0.01;
epsilon =1;
delta=1;
deltaok=4e-3;
n=1;
while  epsilon>erreur ||delta>deltaok 
   % Maillage
   n=n+1; 
   Nb_Elements = n*10;
    L = Longueur/Nb_Elements;
    DDL = 2*(Nb_Elements+1);

   % Matrice de rigidité et de masse d'une poutre   
K_poutre = E*I/L^3.*[12 6*L -12 6*L; 6*L 4*L^2 -6*L 2*L^2;-12 -6*L 12 -6*L; 6*L 2*L^2 -6*L 4*L^2];%
M_poutre = RHO*A*L/420*[156 22*L 54 -13*L; 22*L 4*L^2 13*L -3*L^2; 54 13*L 156 -22*L; -13*L -3*L^2 -22*L 4*L^2];%

% Matrice de rigidité et de masse globale du système    
K = zeros(DDL,DDL);
M = zeros(DDL,DDL);
for i = 1:2:DDL-3
    K(i:i+3,i:i+3) = (K(i:i+3,i:i+3)+K_poutre);
    M(i:i+3,i:i+3) = M(i:i+3,i:i+3)+M_poutre;
end

% Ajout de la masse du moteur  
Noeud = 0.4*Nb_Elements+1;
M(2*Noeud-1,2*Noeud-1) = M(2*Noeud-1,2*Noeud-1)+MM;

%Ajout de la masse du carburant   
Noeud1 =3;
M(2*Noeud1-1,2*Noeud1-1) =M(2*Noeud1-1,2*Noeud1-1)+MC*L/2;
Noeud2 =7;
M(2*Noeud2-1,2*Noeud2-1) =M(2*Noeud2-1,2*Noeud2-1)+MC*L/2;

for i = 2*Noeud1+1:2:2*Noeud2-3
    M(i,i) = M(i,i)+MC*L;
end

% Conditions aux rives
K = K(3:end,3:end); %Mets le premier noeud encastre a zero
M = M(3:end,3:end);
Nb_DDL = length(K);

% Calcul des fréquences propres (numériquement)    
[PHI,D] = eig(K,M);
OMEGA = sqrt(D);
PHI = [zeros(2,Nb_DDL);PHI];

% Calcul des modes propres (numériquement)

    % Discrétisation de l'aile en 100 points
    Nb_Points = 100;
    pas = Longueur/(Nb_Points-1);
    x=[0:pas:Longueur]';

    % Calcul des modes propres    
    [v_FEM] = Modes_EF(PHI,x,Longueur,Nb_Elements);
    for i=1:5
        Epsilon(i)=abs(OMEGA(i,i)-OMEGA1(i,i))/abs(OMEGA(i,i));
        if delta>deltaok
            Delta(i)=max(sum((v_FEM(:,i)-v_FEM1(:,i)).^2));
        end
    end
    
    OMEGA1=OMEGA;
    [v_FEM1]=[v_FEM];
    delta=max(Delta);
    epsilon=max(Epsilon);
    disp('iteration');
    disp(delta);
    disp(epsilon);
end
