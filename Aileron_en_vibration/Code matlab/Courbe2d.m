%Courbe 2d Laboratoire 1
%Par Simon Tanguay et Ahmed Massek
%1897356 et 1784891
%Créé le 21 janvier 2019
%Dernière modification le 21 janvier 2019

clc
clear all

%Définir constantes

    %Amplitude vibratoire
    Theta1=0.1779;
    Theta2=0.1802;
    %Ratio r
    r1=50/126.49;
    r2=100/126.49;
    r3=1;
    r=[r1 r2 r3];
    %Amplitude forçage
    A=40;
    %zeta
    z1=0.05;
    z2=0.25;
    %k
    k=400000;

%Trouver les points des 2 courbes
for i=1:4    
    kXF1(i)=1/sqrt((1-(r(i))^2)^2+(2*z1*r(i))^2);
end
for i=1:4    
    kXF2(i)=1/sqrt((1-(r(i))^2)^2+(2*z2*r(i))^2);
end
%Tracer le graphique
hold on
plot(r,kXF1,r,kXF2)

%Fin du programme