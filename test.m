%�s��̓���
A=[1 4;3 2]
B=[1 4]'
C=[2 0]'
%������
D1=B+C
D2=B-C
D3=A*B
%�]�u
D4=A'
%�s��
s1=det(A)
%�t�s��
D5=inv(A)
%�ŗL�l�ƌŗL�x�N�g��
[T,eigA]=eig(A)
A2=T*eigA*inv(T)%�m�F
%���ْl�Ɠ��كx�N�g��
[U,S,V]=svd(A)
A3=U*S*V'%�m�F