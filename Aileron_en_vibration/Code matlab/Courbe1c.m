%Courbe 1c Laboratoire 1
%Par Simon Tanguay et Ahmed Massek
%1897356 et 1784891
%Créé le 14 janvier 2019
%Dernière modification le 21 janvier 2019

clc
clear
%Courbe 1: PCU opérationnel
i=0;
t(1)=2;
while i<8100
    t(1+i)=2+0.001*i;
    i=i+1;
end
i=1;
while i<8101
    
y(i)=0.1779*sin(126.33*t(i))*exp(-6.3245*t(i));
i=i+1;
end


%Courbe 2: PCU defaillant

i=1;
while i<8101
    
z(i)=0.1807*sin(122.47*t(i))*exp(-31.6225*t(i));
i=i+1;
end

%Tracé des courbes
subplot(2,1,1);
plot(t,z);
subplot(2,1,2);
plot(t,y);

%Fin du programme