function [v_FEM] = Modes_EF(PHI,x,Longueur,Nb_Elements)

%% Description
%
% Cette fonction permet de calculer les modes propres de votre modèle à
% partir de la matrice des vecteurs propres PHI. Les fonctions de formes
% Ni(x) sont utilisées.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables d'entrée
%
% PHI: Matrice des vecteurs propres obtenus par EF
% x: Coordonnées des points de discrétisation de l'aile
% Longueur: Longueur de l'aile
% Nb_Elements: Nombre d'éléments dans le modèle EF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables de sortie

% v_FEM: Matrice [Nb_Points x Nb_DDL]. Chaque colonne de la matrice
% correspond à un mode propre en fonction de x.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Implémentation

% Calcul de la longueur de chaque élément et du nombre de DDL actifs dans
% le modèle EF
L = Longueur/Nb_Elements;
Nb_DDL = size(PHI,2);

% Calcul du nombre de points de discrétisation
Nb_Points = length(x);

% Initialisation de la matrice v_FEM
v_FEM = zeros(Nb_Points,Nb_DDL);

% Identification du numéro d'élément auquel appartient le ième point de
% l'aile
Numero_Element = ceil(x/L);
Numero_Element(1) = 1;

for i = 1:Nb_Points
    
    % Calcul de x local dans l'élément poutre
    x_local = x(i) - (Numero_Element(i)-1)*L;
    
    % Identification des 4 DDLs 
    j = 2*Numero_Element(i)-1;
    
    % Fonctions de forme
    N1 = (2/L^3)*(x_local^3) - (3/L^2)*(x_local^2) + 1;
    N2 = (1/L^2)*(x_local^3) - (2/L)*(x_local^2) + x_local;
    N3 = (-2/L^3)*(x_local^3) + (3/L^2)*(x_local^2);
    N4 = (1/L^2)*(x_local^3) - (1/L)*(x_local^2);
    
    % Calcul de la flèche à la position i, et ce pour chaque mode propre.
    v_FEM(i,:) = N1*PHI(j,:) + N2*PHI(j+1,:) + N3*PHI(j+2,:) + N4*PHI(j+3,:);
    
end

% Normalisation des vecteurs propres
for i = 1:Nb_DDL
    v_FEM(:,i) = abs(v_FEM(2,i))/(v_FEM(2,i))*(v_FEM(:,i)/norm(v_FEM(:,i)));
end