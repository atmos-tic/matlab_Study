%% system_simulation.m
%%�ߓn�����̌v�Z
%%�V�X�e���̌W��
A=[0 1;-1 -1]
B=[0 1]'
C=[2 0]
D=0
sysP=ss (A,B,C,D)
%%�X�e�b�v�����ƃC���p���X���� �����l=0�Ƃ���D
t=0:0.01:10;
y1=step(sysP,t);
y2=impulse(sysP,t);
figure(1)
plot(t,y1,'r',t,y2,'b','LineWidth',2)
xlabel('time[s]')
ylabel('y1,y2')
title('Step and impulse responses')
grid

%%�����l x0, ����u(t)�ɑ΂��鉞��
x0=[1 0]'
t=0:0.01:10;
u=abs(sin(t));
y3=lsim(sysP,u,t,x0);
figure(2)
plot(t,u,'r-.',t,y3,'b','LineWidth',2)
xlabel('time[s]')
ylabel('u,y3')
title('Response with x0 and u(t)')
grid 