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
OMEGA = sqrt(D);
PHI = [zeros(2,Nb_DDL);PHI];

% Calcul des modes propres (numériquement)

% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Calcul des modes propres    
[v_FEM] = Modes_EF(PHI,x,Longueur,Nb_Elements);

% Tracage des 5 premier Modes
Nb_Modes = 5;
for i = 1:Nb_Modes
    figure(i)
    hold on
    plot(x,v_FEM(:,i),'bo')
end
hold off
hold on
figure(Nb_Modes+1)
plot(x,v_FEM(:,1),x,v_FEM(:,2),x,v_FEM(:,3),x,v_FEM(:,4),x,v_FEM(:,5));
legend({'Mode 1','Mode 2','Mode 3','Mode 4','Mode 5'},'location','southwest','FontName','Times New Roman');
xlabel('Longueur de l''aile (m)');
ylabel('Amplitude modale');

%Modèle Simulink   (Décommenter lorsque vous arrivez à la Partie 4 du laboratoire)

% Type de chargement (1 pour Balourd et 2 pour pour Rafale de vent)
Type = 1;

% Amortissement
C = 0.8*M;

if Type == 1    
    
    w = 10000*pi/30;    % Vitesse de rotation (rad/s)
    mb = 0.5;   % Masse du balourd
    e = 0.3;    % Excentricité du balourd
    F = zeros(Nb_DDL,1);
    F(2*Noeud-1) = mb*e*w^2; %force sin verticale au noeud moteur
    sim('Model_1');
    
elseif Type == 2   
    
    Impulsion = zeros(Nb_DDL,1);
    for i = 1:2:Nb_DDL
        Impulsion(i) = -3100;
    end
    V0 = M\Impulsion;
    sim('Model_2');
end

% Calcul de la flèche de la poutre + Animation   
[v_chargement] = Chargement(Deplacement,Longueur,Nb_Elements);





