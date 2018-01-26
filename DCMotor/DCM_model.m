R = 1; %��R
L = 1; %�C���_�N�^���X
J = 1; %�������[�����g
b = 1; %�S�����C�W��
Ke = 1; %�U�N�d�͒萔
Kt = 1; %�g���N�萔

Kb = 1; %�t�B�[�h�o�b�N�Q�C��

G1 = tf(Kt, [L R],'inputname','voltage',...
    'outputname','torque');
G2 = tf(1,[J b],'inputname','torque',...
    'outputname','angular');
dcm = ss(G2) * [G1 , 1];
dcm = feedback(dcm,Kb,1,1);  

stepplot(dcm(1));
