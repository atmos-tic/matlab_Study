% system_analysis.m
close all
clear all 
5
%% システムの特性解析
%%システムの状態方程式
A=[0 1;-1 -1]
B=[0 1]'
C=[1 0.1]
D=0
sysP=ss(A,B,C,D);

%%極，ゼロ点，伝達関数
poleP=pole(sysP)
zeroP=zero(sysP)
[numP,denP]=ss2tf(A,B,C,D);
tfP=tf(numP,denP)
%%可制御性
Uc=ctrb(A,B)%%可制御性行列Uc
na=rank(Uc) %%nは可制御部分空間の次元
[n,n]=size(A)
if na==n
 disp('可制御')
else
 disp('不可制御')
end
%%可観測性
Uo=obsv (A,C)%%可観測性行列Uc
nb=rank(Uo) %%nbarは可観測部分空間の次元
[n,n]=size(A)
if nb==n
 disp('可観測')
else
 disp('不可観測')
end
%%周波数特性
nw=200;
omega=logspace(-2,1,nw);
[reP,imP]=nyquist(sysP,omega);
[magP,phaseP]=bode(sysP,omega); 
6
%%ベクトル軌跡
figure(1)
plot(reP(:),imP(:),'LineWidth',2)
xlabel('Real')
ylabel('Imag')
title('Vector locus')
grid
%%ボード線図
figure(2)
subplot(2,1,1)
semilogx(omega,20*log10(magP(:)),'LineWidth',2);
xlabel('\omega[rad/s]')
ylabel('gain [dB]')
title('Bode plot')
grid
subplot(2,1,2)
semilogx(omega,phaseP(:),'LineWidth',2);
xlabel('\omega[rad/s]')
ylabel('phase[deg]')
grid 