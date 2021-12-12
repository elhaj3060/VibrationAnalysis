function [xi] = Xi(x,BiL,Longueur)

% Description
%
% Cette fonction permet de calculer le ième mode propre théorique de
% l'aile (sans moteur ni carburant)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables d'entrée
%
% x: Coordonnées des points de discrétisation de l'aile
% BiL: ième valeur de betak L
% Longueur: Longueur de l'aile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables de sortie

% xi: Mode propre en fonction de la position x.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Implémentation

%%% A compléter %%% (utiliser des .* et ./)
ci = ((cos(BiL)+sin(BiL)).*exp(-BiL)+1)./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
di = -(cos(BiL)-sin(BiL)+exp(-BiL))./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
ai = ci-di.*exp(-BiL);

%for i=1:5
xi = ai.*sin((BiL/Longueur).*x)-cos((BiL/Longueur)*x)+ci.*exp(-(BiL/Longueur).*x)+di*exp((BiL/Longueur).*(x-Longueur)); 
%end