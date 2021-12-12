%Laboratoire 2 Vibrations
%Auteurs: Simon Tanguay et Ahmed Massek
%Date de creation: 11-02-2019
%Derniere modification: 07-03-2019
clc;clear all;close all;
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
phi=[0;0;-2.77;0];
wombo=48.48; %J'ai changé le nom ici sinon conflit avec diagramme d'amplitude
%Matrices de l'EDM
%Point important, la matrice X des variables DDL suit l'ordre 
%[Za;Zn;Zm;thetaA]
M=[Ma 0 0 0;0 Mn 0 0;0 0 M2m 0;0 0 0 I];
C=[2*cA1+cA2 -cA2 -2*cA1 -2*Lar*cA1+Lav*cA2;-cA2 cA2 0 -Lav*cA2;-2*cA1 0 2*cA1 2*Lar*cA1; -2*Lar*cA1+Lav*cA2 -Lav*cA2 2*Lar*cA1 2*Lar^2*cA1+Lav^2*cA2];
K=[(2*kA1+kA2) -kA2 -2*kA1 -2*kA1*Lar+kA2*Lav; -kA2 kA2+kN 0 -Lav*kA2; -2*kA1 0 2*(kA1+kM) 2*kA1*Lar; -2*kA1*Lar+kA2*Lav -Lav*kA2 2*kA1*Lar Lav^2*kA2+2*Lar^2*kA1];

%Valeurs et vecteurs propres
[Lambda,Phi]=eig(K,M);

    %Frequences naturelles
    wn=[];
    for i=1:4
       wn(i)=sqrt(Phi(i,i));
    end
    
    
%Illustration graphique (papier) des modes propres
%A chaque frequence propre, calculer le vecteur position et normaliser
%selon la composante concernee [Za;Zn;Zm;thetaA]

X_theta=(K-M*wn(1)^2+i*C*wn(1))\F;

X_A=(K-M*wn(2)^2+i*C*wn(2))\F;

X_N=(K-M*wn(3)^2+i*C*wn(3))\F;

X_M=(K-M*wn(4)^2+i*C*wn(4))\F;
%Modele simulink requis ici
sim('Modelesimulink_l2p1');
%Reponse, vitesse et accélération en fonction du temps en accord avec Simulink

    %Za
    figure(1)
  
    subplot(3,1,1);
    hold on
    title('Position verticale de l''avion en fonction du temps');
    xlabel('t');
    ylabel('Za');
    plot(Deplacement(:,1),Deplacement(:,2));
    hold off
  
    subplot(3,1,2);
    hold on
    xlabel('t');
    ylabel('Va');
    title('Vitesse verticale de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,6));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Aa');
    title('Accélération verticale de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,10));
    hold off
    %Zn
    figure(2)
    
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Zn');
    title('Position verticale du train du nez de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,3));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Vn');
    title('Vitesse verticale du train du nez de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,7));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('An');
    title('Accélération verticale du train du nez de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,11));
    hold off
    
    %Zm
    figure(3)
   
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Zm');
    title('Position verticale du train principal de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,4));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Vm');
    title('Vitesse verticale du train principal de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,8));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Am');
    title('Accélération verticale du train principal de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,12));
    hold off
    %thetaA
    figure(4)
    
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Theta');
    title('Orientation de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,5));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Omega');
    title('Orientation de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,9));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Alpha');
    title('Orientation de l''avion en fonction du temps');
    plot(Deplacement(:,1),Deplacement(:,13));
    hold off
%Amplitudes max de chaque DDL
j=1;
w=0:0.05:120;
for n=0:0.05:120
    iX=(K-M*n^2+i*C*wn(1))\F;
    aX(j)=iX(1);
    nX(j)=iX(2);
    mX(j)=iX(3);
    tX(j)=iX(4);
    j=j+1;
end
 figure(5)
    subplot(4,1,1)
    hold on
    xlabel('Fréquence angulaire');
    ylabel('A');
    title('Amplitude de Za selon la fréquence');
    plot(w,abs(aX));
    hold off
    
    subplot(4,1,2)
    hold on
    xlabel('Fréquence angulaire');
    ylabel('A');
    title('Amplitude de Zn selon la fréquence');
    plot(w,abs(nX));
    hold off
    
    subplot(4,1,3)
    hold on
    xlabel('Fréquence angulaire');
    ylabel('A');
    title('Amplitude de Zm selon la fréquence');
    plot(w,abs(mX));
    hold off
    
    subplot(4,1,4)
    hold on
    xlabel('Fréquence angulaire');
    ylabel('A');
    title('Amplitude de Theta selon la fréquence');
    plot(w,abs(tX));
    hold off
    
%Équations modales découplées (partie II)
    %Reorganiser les valeurs propres dans le bon ordre de composantes (idem
    %pour V)
    NeoPhi(1,1)=Phi(2,2);
    NeoPhi(2,2)=Phi(3,3);
    NeoPhi(3,3)=Phi(4,4);
    NeoPhi(4,4)=Phi(1,1);
    
    Neolambda(:,1)=Lambda(:,2);
    Neolambda(:,2)=Lambda(:,3);
    Neolambda(:,3)=Lambda(:,4);
    Neolambda(:,4)=Lambda(:,1);

 Imod=diag(diag(Neolambda'*M*Neolambda)); %masse modale (identité)
 V=NeoPhi; %raideur modale  
 Ctilde=diag(diag(Neolambda'.*C.*Neolambda)); %amortiseement modal
 R=Neolambda'*F; %Forçage modal
    
%Reponse modale du système via Simulink
sim('Modelesimulink_l2p2');
%(demarche similaire au f) de partie I)
DeplacementModal(:,2:5)=(Neolambda*DeplacementModal(:,2:5)')';
DeplacementModal(:,6:9)=(Neolambda*DeplacementModal(:,6:9)')';
DeplacementModal(:,10:13)=(Neolambda*DeplacementModal(:,10:13)')';
%Reponse de position, vitesse et accélération
%Za
    figure(6)
  
    subplot(3,1,1);
    hold on
    title('Position verticale de l''avion en fonction du temps');
    xlabel('t');
    ylabel('Za');
    plot(DeplacementModal(:,1),DeplacementModal(:,2));
    hold off
  
    subplot(3,1,2);
    hold on
    xlabel('t');
    ylabel('Va');
    title('Vitesse verticale de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,6));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Aa');
    title('Accélération verticale de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,10));
    hold off
    %Zn
    figure(7)
    
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Zn');
    title('Position verticale du train du nez de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,3));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Vn');
    title('Vitesse verticale du train du nez de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,7));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('An');
    title('Accélération verticale du train du nez de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,11));
    hold off
    
    %Zm
    figure(8)
   
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Zm');
    title('Position verticale du train principal de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,4));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Vm');
    title('Vitesse verticale du train principal de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,8));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Am');
    title('Accélération verticale du train principal de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,12));
    hold off
    %thetaA
    figure(9)
    
    subplot(3,1,1)
    hold on
    xlabel('t');
    ylabel('Theta');
    title('Orientation de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,5));
    hold off
  
    subplot(3,1,2)
    hold on
    xlabel('t');
    ylabel('Omega');
    title('Orientation de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,9));
    hold off
    
    subplot(3,1,3)
    hold on
    xlabel('t');
    ylabel('Alpha');
    title('Orientation de l''avion en fonction du temps');
    plot(DeplacementModal(:,1),DeplacementModal(:,13));
    hold off
%Soupçon: inversion de A et theta. Comprendre en regardant les graphiques
%Une rafale sur l'avion (2e)
%conditions initiales
