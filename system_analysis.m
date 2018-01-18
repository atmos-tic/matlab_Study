% system_analysis.m
close all
clear all 
5
%% �V�X�e���̓������
%%�V�X�e���̏�ԕ�����
A=[0 1;-1 -1]
B=[0 1]'
C=[1 0.1]
D=0
sysP=ss(A,B,C,D);

%%�ɁC�[���_�C�`�B�֐�
poleP=pole(sysP)
zeroP=zero(sysP)
[numP,denP]=ss2tf(A,B,C,D);
tfP=tf(numP,denP)
%%���䐫
Uc=ctrb(A,B)%%���䐫�s��Uc
na=rank(Uc) %%n�͉��䕔����Ԃ̎���
[n,n]=size(A)
if na==n
 disp('����')
else
 disp('�s����')
end
%%�ϑ���
Uo=obsv (A,C)%%�ϑ����s��Uc
nb=rank(Uo) %%nbar�͉ϑ�������Ԃ̎���
[n,n]=size(A)
if nb==n
 disp('�ϑ�')
else
 disp('�s�ϑ�')
end
%%���g������
nw=200;
omega=logspace(-2,1,nw);
[reP,imP]=nyquist(sysP,omega);
[magP,phaseP]=bode(sysP,omega); 
6
%%�x�N�g���O��
figure(1)
plot(reP(:),imP(:),'LineWidth',2)
xlabel('Real')
ylabel('Imag')
title('Vector locus')
grid
%%�{�[�h���}
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