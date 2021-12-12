function [xij] = Xij(x,BiL,BjL,Longueur)

% Description
%
% Cette fonction permet de calculer le produit phii(x)*phij(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables d'entr�e
%
% x: Coordonn�es des points de discr�tisation de l'aile
% BiL: i�me valeur de betak L
% BjL: j�me valeur de betak L
% Longueur: Longueur de l'aile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables de sortie

% Xij: Valeur du produit Xi(x)*Xj(x) en fonction de x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Impl�mentation

%%% A compl�ter %%% (utiliser des .* et ./)

xi = Xi(x,BiL,Longueur);
xj = Xi(x,BjL,Longueur);

xij = xi.*xj;

