%Donn�es Partie 2 Laboratoire 1
%Par Simon Tanguay et Ahmed Massek
%1897356 et 1784891
%Cr�� le 14 janvier 2019
%Derni�re modification le 21 janvier 2019

clc
clear all

m = 25;
k = 400000;
c = 200000;

x0 = 0;
v0 = 0;

% Force
A = 40;
w = 50;

 sim('Labo partie II')
 
 plot(Deplacement(:,1),Deplacement(:,2))
 
 %Fin du programme