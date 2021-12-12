function [xij_dd] = Xij_dd(x,BiL,BjL,Longueur)

% Description
%
% Cette fonction permet de calculer le produit phii''(x)*phij''(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables d'entrée
%
% x: Coordonnées des points de discrétisation de l'aile
% BiL: ième valeur de betak L
% BjL: jème valeur de betak L
% Longueur: Longueur de l'aile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables de sortie

% xij_dd: Valeur du produit xi''(x)*xj''(x) en fonction de x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Implémentation
c_i = ((cos(BiL)+sin(BiL)).*exp(-BiL)+1)./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
d_i = -(cos(BiL)-sin(BiL)+exp(-BiL))./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
a_i = c_i-d_i.*exp(-BiL);


c_j = ((cos(BjL)+sin(BjL)).*exp(-BjL)+1)./(1+2.*sin(BjL).*exp(-BjL)-exp(-2.*BjL));
d_j = -(cos(BjL)-sin(BjL)+exp(-BjL))./(1+2.*sin(BjL).*exp(-BjL)-exp(-2.*BjL));
a_j = c_j-d_j.*exp(-BjL);

%%% A compléter %%% (utiliser des .* et ./)

xi_dd=(BiL/Longueur)^2*(-a_i*cos((BiL/Longueur)*x)-(BiL/Longueur)*sin((BiL/Longueur)*x)+c_i*exp(-(BiL/Longueur)*x)...
    +d_i*exp((BiL/Longueur)*(x-Longueur)));
xj_dd=(BjL/Longueur)^2*(-a_j*cos((BjL/Longueur)*x)-(BjL/Longueur)*sin((BjL/Longueur)*x)+c_j*exp(-(BjL/Longueur)*x)...
    +d_j*exp((BjL/Longueur)*(x-Longueur)));

xij_dd = xi_dd.*xj_dd;

