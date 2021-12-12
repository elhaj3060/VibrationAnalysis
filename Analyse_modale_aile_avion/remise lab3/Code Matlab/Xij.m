function [xij] = Xij(x,BiL,BjL,Longueur)

% Description
%
% Cette fonction permet de calculer le produit phii(x)*phij(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables d'entrée
%
% x: Coordonnées des points de discrétisation de l'aile
% BiL: ième valeur de betak L
% BjL: jème valeur de betak L
% Longueur: Longueur de l'aile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables de sortie

% Xij: Valeur du produit Xi(x)*Xj(x) en fonction de x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Implémentation

%%% A compléter %%% (utiliser des .* et ./)

xi = Xi(x,BiL,Longueur);
xj = Xi(x,BjL,Longueur);

xij = xi.*xj;

