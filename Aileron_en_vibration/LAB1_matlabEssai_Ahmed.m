clc
clear all
close all

%%Définitions de variables 

% Moment d'inertie HL
I=25; % [kg.m^2]
Meq= I;
% Rigidité du PCU
k=10e6; % [N/m]

% Distance entre le centre de rotation et le point d'attache du PCU
d=20*1e-2; %[m]

% Ratio d’amortissement, PCU opérationnel
zeta1=0.05;

% Ratio d’amortissement, PCU en mode défaillance
zeta2=0.25;


Keq=k*(d^2);

%%partie-1 Construction d'un modèle Simulink

% Fréquence naturelle du systeme
Wn= sqrt(Keq/Meq); % [rad/s]

% Fréquence amortie du système opérationnel
Wd1=sqrt(1-zeta1^2)*Wn;

Wd2=sqrt(1-zeta2^2)*Wn;

Fr_mins=30;
%K_min=....;

%Q(c)

%-Moment d'impulsion
F= 100; % [N.m.s]
t_fin=1;
t=0:0.001:t_fin ;

% % --------------------------- Cas opérationnel ----------------------------
theta0_p=F/I; % [rad/s]
theta1=(theta0_p/Wd1*sin(Wd1*t).*exp(-zeta1*Wn*t));
theta2=(theta0_p/Wd2*sin(Wd2*t).*exp(-zeta2*Wn*t));
figure(1)
hold on
subplot(2,1,1)
plot(t,theta1,'r');
grid('on')
title('Oscillation pour une impulsion de 100 N.m.s avec \zeta_1 = 0.05 en mode opérationnel','FontName','Times New Roman')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')

% % ---------------------------- Cas défaillant -----------------------------
subplot(2,1,2)
plot(t,theta2,'b');
title('Oscillation pour une impulsion de 100 N.m.s avec \zeta_2 = 0.25 en mode défaillant','FontWeight','bold','FontName','Times New Roman')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%partie 2

x0=0;
v0=F/I;
zeta=zeta1;
Ceq=2*zeta*sqrt(Keq*Meq);
A=0;
w=0;
sim('test')
t5=t1;
theta5=theta;
zeta=zeta2;
x0=0;
v0=F/I;
Ceq=2*zeta*sqrt(Keq*Meq);
A=0;
w=0;
sim('test')
zeta5=zeta2;
t55=t1;
theta55=theta;
hold on 
figure(2)
subplot(2,1,1)
plot(t5,theta5,'r');
grid('on')
title('Oscillation pour une impulsion de 100 N.m.s avec \zeta_1 = 0.05 en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
subplot(2,1,2)
plot(t55,theta55,'b');
grid('on')
title('Oscillation pour une impulsion de 100 N.m.s avec \zeta_2 = 0.25 en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')

hold off

% QUESTION C)

% % --------------------------- Cas opérationnel ----------------------------

x0=0;
v0=0;
zeta=zeta1;
Ceq=2*zeta*sqrt(Keq*Meq);

% 1-Premier cas avec un w=50 [rad/s] et A=40 [N.m]
w=50  % [rad/s] ;
A=40  % [N.m]   ;
sim('test')
theta2=theta;
v=v;
figure(4)
hold on
subplot(3,2,1)
plot(t1,theta2,'m');
title('Oscillation pour \omega = 50 rad/s et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')

subplot(3,2,2)
plot(t1,v)
title('Oscillation pour \omega = 50 rad/s et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('Vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')

% 2-Deuxième cas avec un w=100 [rad/s] et A=40 [N.m]
w=100  %[rad/s];
A=40   %[N.m]  ;
sim('test')
theta3=theta;
v=v;
subplot(3,2,3)
plot(t1,theta3,'m');
title('Oscillation pour \omega = 100 rad/s et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')
subplot(3,2,4)
plot(t1,v);
title('Oscillation pour \omega = 50 rad/s et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('Vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')

% 3-Troisième cas avec un w=w_n [rad/s] et A=40 [N.m]
w=Wn;
A=40;
sim('test')
v=v;
theta4=theta;
subplot(3,2,5)
plot(t1,theta4,'m');
title('Oscillation pour \omega = 126.5 rad/s (\omega_n) et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')

subplot(3,2,6)
plot(t1,v);
title('Oscillation pour \omega = 126.5 rad/s (\omega_n) et A = 40 N.m  en mode opérationnel','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('Vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')
x0=0;
v0=0;
hold off

% % --------------------------- Cas défaillant ----------------------------

zeta=zeta2;
Ceq=2*zeta*sqrt(Keq*Meq);

% 1-Premier cas avec un w=50 [rad/s] et A=40 [N.m]
w=50;
A=40;
sim('test')
theta5=theta;
v=v;
figure(5)
hold on
subplot(3,2,1)
plot(t1,theta5,'k');
grid('on')
title('Oscillation pour \omega = 50 rad/s et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')

subplot(3,2,2)
plot(t1,v,'r')
title('Oscillation pour \omega = 50 rad/s et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('Vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')

% 2-Deuxième cas avec un w=100 [rad/s] et A=40 [N.m]
w=100;
A=40;
sim('test')
theta6=theta;
v=v;
subplot(3,2,3)
plot(t1,theta6,'k');
title('Oscillation pour \omega = 100 rad/s et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')

subplot(3,2,4)
plot(t1,v,'r')
title('Oscillation pour \omega = 100 rad/s et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('Vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')

% 3-Troisième cas avec un w=w_n [rad/s] et A=40 [N.m]
w=Wn;
A=40;
sim('test')
v=v;
theta7=theta;
subplot(3,2,5)
plot(t1,theta7,'k');
title('Oscillation pour \omega = 126.5 rad/s (\omega_n) et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('angle de rotation (rad)','FontName','Times New Roman','FontWeight','bold')
grid('on')

subplot(3,2,6)
plot(t1,v,'r');
title('Oscillation pour \omega = 126.5 rad/s (\omega_n) et A = 40 N.m  en mode défaillant','FontName','Times New Roman','FontWeight','bold')
xlabel('temps (s)','FontName','Times New Roman','FontWeight','bold')
ylabel('vitesse de rotation (rad/s)','FontName','Times New Roman','FontWeight','bold')
grid('on')

hold off


%Qd pour chaque cas de zeta

W= Wn-100:0.01:Wn+100;
r=W/Wn;
X1= abs(1./(sqrt((1-r.^2).^2+(2*zeta1*r).^2)));
X2= abs(1./(sqrt((1-r.^2).^2+(2*zeta2*r).^2)));

t_sta=0.7;
i_ini= find(t1>t_sta);
i_ini=i_ini(1);


%graph 1 
t_sta=0.7;
i_ini= find(t1>t_sta);
i_ini1=i_ini(1);

%graph 2 
t_sta=0.4;
i_ini= find(t1>t_sta);
i_ini2=i_ini(1);

%graph 1 
t_sta=0.75;
i_ini= find(t1>t_sta);
i_ini3=i_ini(1);

%graph 2 
t_sta=0.1;
i_ini= find(t1>t_sta);
i_ini4=i_ini(1);

%graph 1 
t_sta=0.2;
i_ini= find(t1>t_sta);
i_ini5=i_ini(1);

%graph 2 
t_sta=0.2;
i_ini= find(t1>t_sta);
i_ini6=i_ini(1);

figure(6)
plot(r,X1,'b',r,X2,'k')


% position ou on est rentré dans le cycle permanent figure 3 (proche 0.8)

theta2=(Wn^2/(A/I))*theta2;
theta3=(Wn^2/(A/I))*theta3;
theta4=(Wn^2/(A/I))*theta4;
theta5=(Wn^2/(A/I))*theta5;
theta6=(Wn^2/(A/I))*theta6;
theta7=(Wn^2/(A/I))*theta7;


hold on
plot(50/Wn,max(theta2(i_ini1:end)),'or');
plot(100/Wn,max(theta3(i_ini1:end)),'or');
plot(Wn/Wn,max(theta4(i_ini1:end)),'or');
plot(50/Wn,max(theta5(i_ini1:end)),'or');
plot(100/Wn,max(theta6(i_ini1:end)),'or');
plot(Wn/Wn,max(theta7(i_ini1:end)),'or');
title('Amplitudes maximales en fonction du ratio de fréquences analytiques r','FontSize',13,'FontWeight','bold','FontName','Times New Roman');
xlabel('r = \omega/\omega_n','FontSize',15,'FontWeight','bold','FontName','Times New Roman');
ylabel('Amplitude |Keq*X/A|','FontSize',15,'FontWeight','bold','FontName','Times New Roman');
set(gca,'Xtick',0:0.1:30) ; set(gca,'Ytick',0:1:12)
legend({'Cas Opérationnel','Cas Défaillant','Amplitude max'},'location','northwest','FontName','Times New Roman');
grid('on')
hold off

