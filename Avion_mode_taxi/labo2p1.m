%Laboratoire 2 Vibrations
%Auteurs: Simon Tanguay et Ahmed Massek
%Date de creation: 11-2-2019
%Derniere modification: 11-2-2019

%Declaration des variables
kN=1732578;
kA2=46266.1;
kM=3891698;
kA1=2895315;

cA2=2962;
cA1=13328;

Mta=47500;
Ma=46266.1;
Mn=145.3;
M2m=544.3*2;
I=1.6961*1000000;

Lav=13.618;
Lar=14.441-Lav;
f=0.01;
F=[0;kN*f;2*kM*f;0];
Phi=[0;0;-2.77;0];
%Matrices de l'EDM
%Point important, la matrice X des variables DDL suit l'ordre 
%[Za;Zn;Zm;thetaA]
M=[Ma 0 0 0;0 Mn 0 0;0 0 M2m 0;0 0 0 I];
C=[2*cA1+cA2 -cA2 -2*cA1 -2*Lar*cA1+Lav*cA2;-cA2 cA2 0 -Lav*cA2;-2*cA1 0 2*cA1 2*Lar*cA1; -2*Lar*cA1+Lav*cA2 -Lav*cA2 2*Lar*cA1 2*Lar^2*cA1+Lav^2*cA2];
K=[(2*kA1+kA2) -kA2 -2*kA1 -2*kA1*Lar+kA2*Lav; -kA2 kA2+kN 0 -Lav*kA2; -2*kA1 0 2*(kA1+kM) 2*kA1*Lar; -2*kA1*Lar+kA2*Lav -Lav*kA2 2*kA1*Lar Lav^2*kA2+2*Lar^2*kA1];

%Valeurs et vecteurs propres
[V,lambda]=eig(K,M);

    %Frequences naturelles
    wn=[];
    for i=1:4
       wn(i)=sqrt(lambda(i,i));
    end
    %Note: frequences propres complexes
    
%Illustration graphique (papier) des modes propres
%A chaque frequence propre, calculer le vecteur position et normaliser
%selon la composante concernee [Za;Zn;Zm;thetaA]

X_theta=(K-M*wn(1)^2+i*C*wn(1))\F;

X_A=(K-M*wn(2)^2+i*C*wn(2))\F;

X_N=(K-M*wn(3)^2+i*C*wn(3))\F;

X_M=(K-M*wn(4)^2+i*C*wn(4))\F;
%Modele simulink requis ici

%Vitesse et accélération en fonction du temps en accord avec Simulink

    %Za
    
    %Zn
    
    %Zm
    
    %thetaA
    
%Amplitudes max de chaque DDL