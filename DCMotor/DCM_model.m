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
dcm = ss(G2) * [G1 , 1]; %G1����̓��͂ƊO���g���N�̓���
%dcm�̃t�B�[�h�o�b�N�R���g���[��Kb�̏o�͂��v�����gDCM����1�ɐڑ�
%�v�����gDCM�o��1���t�B�[�h�o�b�N�R���g���[��Kb�ɓ���
feedin = 1;
feedout = 1;
dcm = feedback(dcm,Kb,feedin,feedout);

stepplot(dcm(1)); %dcm(2)�̏ꍇ�A�O���g���N�ɓ���
