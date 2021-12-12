clc
clear all
close all

%% Dimension de l'aile et propriétés  (%%% A compléter %%%)
Longueur =
Largeur =
Epaisseur =
Paroi =
E =
RHO =
A =
I =

%% Moteur  (%%% A compléter %%%)
LM =  % Emplacement du moteur
MM =  % Masse du moteur

%% Carburant   (%%% A compléter %%%)
LC1 =   % Début de la zone de carburant
LC2 =   % Fin de la zone de carburant
MC  =   % Masse par unité de longueur

%% Maillage
Nb_Elements = 10;
L = Longueur/Nb_Elements;
DDL = 2*(Nb_Elements+1);

% Matrice de rigidité et de masse d'une poutre    %%% A compléter %%%
K_poutre =
M_poutre =

% Matrice de rigidité et de masse globale du système    %%% A compléter %%%
K = zeros(DDL,DDL);
M = zeros(DDL,DDL);
for i = 1:2:DDL-3
    K(i:i+3,i:i+3) =
    M(i:i+3,i:i+3) =
end

%% Ajout de la masse du moteur   %%% A compléter %%%
Noeud =
M() =

%% Ajout de la masse du carburant   %%% A compléter %%%
Noeud1 =
M( ) =
Noeud2 =
M( ) =

for i = 2*Noeud1+1:2:2*Noeud2-3
    M(i,i) =
end

%% Conditions aux rives
K = K(3:end,3:end);
M = M(3:end,3:end);
Nb_DDL = length(K);

%% Calcul des fréquences propres (numériquement)    %%% A compléter %%%
[PHI,D] =
OMEGA =
PHI = [zeros(2,Nb_DDL);PHI];

%% Calcul des modes propres (numériquement)

% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Calcul des modes propres    %%% A compléter %%%
[v_FEM] =

%% Tracage des 5 premier Modes
Nb_Modes = 5;
for i = 1:Nb_Modes
    figure(i)
    hold on
    plot(x,v_FEM(:,i),'bo')
end


%% Modèle Simulink   (Décommenter lorsque vous arrivez à la Partie 4 du laboratoire)
% 
% % Type de chargement (1 pour Balourd et 2 pour pour Rafale de vent)
% Type = 1;
% 
% % Amortissement
% C = 0.8*M;
% 
% if Type == 1    %%% A compléter %%%
%     
%     w =     % Vitesse de rotation
%     mb =    % Masse du balourd
%     e =     % Excentricité du balourd
%     F = zeros(Nb_DDL,1);
%     F( ) = ;
%     sim('Model_1')
%     
% elseif Type == 2   %%% A compléter %%%
%     
%     Impulsion = zeros(Nb_DDL,1);
%     for i = 1:2:Nb_DDL
%         Impulsion(i) = 
%     end
%     V0 = 
%     sim('Model_2')
% end
% 
% % Calcul de la flèche de la poutre + Animation.    %%% A compléter %%%
% [v_chargement] = 






