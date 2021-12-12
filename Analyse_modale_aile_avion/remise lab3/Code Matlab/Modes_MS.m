function [v_AM] = Modes_MS(Q,x,Longueur,BL)

%% Description
%
% Cette fonction permet de calculer les modes propres de votre mod�le �
% partir de la matrice de la matrice Q obtenue par la m�thode des modes
% suppos�es
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables d'entr�e
%
% Q: Matrice de coeffcients obtenue par la m�thode des modes suppos�es
% x: Coordonn�es des points de discr�tisation de l'aile
% Longueur: Longueur de l'aile
% BkL: Vecteur BL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables de sortie

% v_AM: Matrice [Nb_Points x N]. Chaque colonne de la matrice
% correspond � un mode propre en fonction de x.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Impl�mentation

% Nombre de modes calcul�s
N = length(Q);

% Calcul du nombre de points de discr�tisation
Nb_Points = length(x);

% Initialisation de la matrice v_AM
v_AM = zeros(Nb_Points,N);

% Calcul des vecteur propres de l'aile
for i = 1:N
    for n = 1:N  
        v_AM(:,i) = v_AM(:,i) + Q(n,i)*Xi(x,BL(n),Longueur);
    end
    % Normalisation du vecteur propre
    v_AM(:,i) = abs(v_AM(2,i))/(v_AM(2,i))*(v_AM(:,i)/norm(v_AM(:,i)));
end