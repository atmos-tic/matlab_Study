%行列の入力
A=[1 4;3 2]
B=[1 4]'
C=[2 0]'
%加減乗
D1=B+C
D2=B-C
D3=A*B
%転置
D4=A'
%行列式
s1=det(A)
%逆行列
D5=inv(A)
%固有値と固有ベクトル
[T,eigA]=eig(A)
A2=T*eigA*inv(T)%確認
%特異値と特異ベクトル
[U,S,V]=svd(A)
A3=U*S*V'%確認