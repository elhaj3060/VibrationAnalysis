function [v_chargement] = Chargement(Deplacement,Longueur,Nb_Elements)

%% Description
%
% Cette fonction permet de calculer la flèche de l'aile en tout point x
% suite au chargement imposé (Balourd ou Rafale de vent)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables d'entrée
%
% Deplacement: Matrice de déplacement obtenu par Simulink
% Longueur: Longueur de l'aile
% Nb_Elements: Nombre d'éléments dans le modèle EF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables de sortie

% v_chargement: Matrice [Nb_Points x Nb_Temps]. Chaque colonne de la
% matrice correspond à la flèche de la poutre à un instant donné.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informations
%
% Auteur: Elias Ghossein
% Date  : 12 Février 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ajouter des 0 à la matrice Déplacement pour tenir compte des DDLs à
% l'encastrement
Nb_Temps = size(Deplacement,1);
Deplacement = [zeros(2,Nb_Temps);Deplacement'];

% Calcul de la longueur de chaque élément et du nombre de DDL actifs dans
% le modèle EF
L = Longueur/Nb_Elements;

% Discrétisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Initialisation de la matrice v_chargement
v_chargement = zeros(Nb_Points,Nb_Temps);

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
    
    % Calcul de la flèche en un point donné, pour tous les temps simulés
    v_chargement(i,:) = N1*Deplacement(j,:) + N2*Deplacement(j+1,:) + N3*Deplacement(j+2,:) + N4*Deplacement(j+3,:);
    
end

% Animation
m = max(max(v_chargement));
n = min(min(v_chargement));
for i = 1:50:Nb_Temps
    figure(1)
    plot(x,v_chargement(:,i))
    axis([0 10 n m])
    pause(0.01)
end