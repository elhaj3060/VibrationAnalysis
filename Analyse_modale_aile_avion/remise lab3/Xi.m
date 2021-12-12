function [xi] = Xi(x,BiL,Longueur)

% Description
%
% Cette fonction permet de calculer le i�me mode propre th�orique de
% l'aile (sans moteur ni carburant)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables d'entr�e
%
% x: Coordonn�es des points de discr�tisation de l'aile
% BiL: i�me valeur de betak L
% Longueur: Longueur de l'aile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables de sortie

% xi: Mode propre en fonction de la position x.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Informations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Impl�mentation

%%% A compl�ter %%% (utiliser des .* et ./)
ci = ((cos(BiL)+sin(BiL)).*exp(-BiL)+1)./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
di = -(cos(BiL)-sin(BiL)+exp(-BiL))./(1+2.*sin(BiL).*exp(-BiL)-exp(-2.*BiL));
ai = ci-di.*exp(-BiL);

%for i=1:5
xi = ai.*sin((BiL/Longueur).*x)-cos((BiL/Longueur)*x)+ci.*exp(-(BiL/Longueur).*x)+di*exp((BiL/Longueur).*(x-Longueur)); 
%end