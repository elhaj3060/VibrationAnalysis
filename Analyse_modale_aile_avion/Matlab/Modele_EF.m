clc
clear all
close all

%% Dimension de l'aile et propri�t�s  (%%% A compl�ter %%%)
Longueur =
Largeur =
Epaisseur =
Paroi =
E =
RHO =
A =
I =

%% Moteur  (%%% A compl�ter %%%)
LM =  % Emplacement du moteur
MM =  % Masse du moteur

%% Carburant   (%%% A compl�ter %%%)
LC1 =   % D�but de la zone de carburant
LC2 =   % Fin de la zone de carburant
MC  =   % Masse par unit� de longueur

%% Maillage
Nb_Elements = 10;
L = Longueur/Nb_Elements;
DDL = 2*(Nb_Elements+1);

% Matrice de rigidit� et de masse d'une poutre    %%% A compl�ter %%%
K_poutre =
M_poutre =

% Matrice de rigidit� et de masse globale du syst�me    %%% A compl�ter %%%
K = zeros(DDL,DDL);
M = zeros(DDL,DDL);
for i = 1:2:DDL-3
    K(i:i+3,i:i+3) =
    M(i:i+3,i:i+3) =
end

%% Ajout de la masse du moteur   %%% A compl�ter %%%
Noeud =
M() =

%% Ajout de la masse du carburant   %%% A compl�ter %%%
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

%% Calcul des fr�quences propres (num�riquement)    %%% A compl�ter %%%
[PHI,D] =
OMEGA =
PHI = [zeros(2,Nb_DDL);PHI];

%% Calcul des modes propres (num�riquement)

% Discr�tisation de l'aile en 100 points
Nb_Points = 100;
pas = Longueur/(Nb_Points-1);
x=[0:pas:Longueur]';

% Calcul des modes propres    %%% A compl�ter %%%
[v_FEM] =

%% Tracage des 5 premier Modes
Nb_Modes = 5;
for i = 1:Nb_Modes
    figure(i)
    hold on
    plot(x,v_FEM(:,i),'bo')
end


%% Mod�le Simulink   (D�commenter lorsque vous arrivez � la Partie 4 du laboratoire)
% 
% % Type de chargement (1 pour Balourd et 2 pour pour Rafale de vent)
% Type = 1;
% 
% % Amortissement
% C = 0.8*M;
% 
% if Type == 1    %%% A compl�ter %%%
%     
%     w =     % Vitesse de rotation
%     mb =    % Masse du balourd
%     e =     % Excentricit� du balourd
%     F = zeros(Nb_DDL,1);
%     F( ) = ;
%     sim('Model_1')
%     
% elseif Type == 2   %%% A compl�ter %%%
%     
%     Impulsion = zeros(Nb_DDL,1);
%     for i = 1:2:Nb_DDL
%         Impulsion(i) = 
%     end
%     V0 = 
%     sim('Model_2')
% end
% 
% % Calcul de la fl�che de la poutre + Animation.    %%% A compl�ter %%%
% [v_chargement] = 






