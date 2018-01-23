%%���ݒ�
A=1; b=1; c=1;  %�V�X�e��
Q=1; R=10;   %�G��
N=300;  %�f�[�^��
%% �ϑ��f�[�^�̐���
% �G���M���̐���
    v = randn(N,1)*sqrtm(Q);    %�V�X�e���G��
    w = randn(N,1)*sqrtm(R);    %�ϑ��G��
% ��ԋ�ԃ��f����p�������n��f�[�^�̐���
    x = zeros(N,1); y = zeros(N,1); %�L���̈�̊m��
    y(1) = c'*x(1,:)'+w(1);
    for k = 2:N
        x(k,:) = A*x(k-1,:)'+b*v(k-1);
        y(k) = c'*x(k,:)'+w(k);
    end
%% �J���}���t�B���^�ɂ���Ԑ���
% ����l�L���̈�̊m��
    xhat = zeros(N,1);
% ��������l
    P = 0; xhat(1,:) = 0;
% ����l�̎��ԍX�V
    for k = 2:N
        [xhat(k,:),P,G] = kf(A,b,0,c,Q,R,0,y(k),xhat(k-1,:),P);
    end
%% ���ʂ̕\��
    figure(1),clf
    plot(1:N,y,'k:',1:N,x,'r--',1:N,xhat,'b-')
    xlabel('No. of samples')
    legend('measured','true','estimate')
    
%%���`�J���}���t�B���^��function��
function [xhat_new,P_new, G] = kf(A,B,Bu,C,Q,R,u,y,xhat,P)
% KF ���`�J���}���t�B���^�̍X�V
% [xhat_new,P_new, G] = kf(A,B,Bu,C,Q,R,u,y,xhat,P)
% ���`�J���}���t�B���^�̐���l�X�V���s��
% ����:
%   A,B,h,C: �ΏۃV�X�e��
%           x(k+1) = Ax(k) + Bv(k) + BU u(k)
%           y(k) = C'x(k) + w(k)
%           �̃V�X�e���s��
%   Q,R: �G��v,w�̋����U�s��. v,w �͐��K�����F�G����
%           E[v(k)] = E[w(k)] = 0
%           E[v(k)'v(k)] = Q, E[w(k)'w(k)] = R
%       �ł��邱�Ƃ�z��
%   u: ��ԍX�V�O���_�ł̐������ u(k-1)
%   y: ��ԍX�V�㎞�_�ł̊ϑ��o�� y(k)
% �߂�l:
%   xhat_new: �X�V��̏�Ԑ���l xhat(k)
%   P_new: �X�V��̌덷�����U�s�� P(k)
%   G: �J���}���Q�C��
% �Q�l:
%   ����`�V�X�e���ւ̊g��: EKF, UKF
% ��x�N�g���ɐ��`
 xhat = xhat(:); u = u(:); y = y(:);
%���O����l
 xhatm = A*xhat + Bu*u; %���
 Pm = A*P*A' + B*Q*B;   %�덷�����U
%�J���}���Q�C���s��
 G = Pm*C/(C'*Pm*C+R);
% ���㐄��l
 xhat_new = xhatm + G * (y-C'*xhat);    %���
 P_new = (eye(size(A))-G*C') * Pm;  %�덷�����U
end
 