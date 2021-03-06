%%問題設定
A=1; b=1; c=1;  %システム
Q=1; R=10;   %雑音
N=300;  %データ数
%% 観測データの生成
% 雑音信号の生成
    v = randn(N,1)*sqrtm(Q);    %システム雑音
    w = randn(N,1)*sqrtm(R);    %観測雑音
% 状態空間モデルを用いた時系列データの生成
    x = zeros(N,1); y = zeros(N,1); %記憶領域の確保
    y(1) = c'*x(1,:)'+w(1);
    for k = 2:N
        x(k,:) = A*x(k-1,:)'+b*v(k-1);
        y(k) = c'*x(k,:)'+w(k);
    end
%% カルマンフィルタによる状態推定
% 推定値記憶領域の確保
    xhat = zeros(N,1);
% 初期推定値
    P = 0; xhat(1,:) = 0;
% 推定値の時間更新
    for k = 2:N
        [xhat(k,:),P,G] = kf(A,b,0,c,Q,R,0,y(k),xhat(k-1,:),P);
    end
%% 結果の表示
    figure(1),clf
    plot(1:N,y,'k:',1:N,x,'r--',1:N,xhat,'b-')
    xlabel('No. of samples')
    legend('measured','true','estimate')
    
%%線形カルマンフィルタのfunction文
function [xhat_new,P_new, G] = kf(A,B,Bu,C,Q,R,u,y,xhat,P)
% KF 線形カルマンフィルタの更新
% [xhat_new,P_new, G] = kf(A,B,Bu,C,Q,R,u,y,xhat,P)
% 線形カルマンフィルタの推定値更新を行う
% 引数:
%   A,B,h,C: 対象システム
%           x(k+1) = Ax(k) + Bv(k) + BU u(k)
%           y(k) = C'x(k) + w(k)
%           のシステム行列
%   Q,R: 雑音v,wの共分散行列. v,w は正規性白色雑音で
%           E[v(k)] = E[w(k)] = 0
%           E[v(k)'v(k)] = Q, E[w(k)'w(k)] = R
%       であることを想定
%   u: 状態更新前時点での制御入力 u(k-1)
%   y: 状態更新後時点での観測出力 y(k)
% 戻り値:
%   xhat_new: 更新後の状態推定値 xhat(k)
%   P_new: 更新後の誤差共分散行列 P(k)
%   G: カルマンゲイン
% 参考:
%   非線形システムへの拡張: EKF, UKF
% 列ベクトルに整形
 xhat = xhat(:); u = u(:); y = y(:);
%事前推定値
 xhatm = A*xhat + Bu*u; %状態
 Pm = A*P*A' + B*Q*B';   %誤差共分散
%カルマンゲイン行列
 G = Pm*C/(C'*Pm*C+R);
% 事後推定値
 xhat_new = xhatm + G * (y-C'*xhat);    %状態
 P_new = (eye(size(A))-G*C') * Pm;  %誤差共分散
end
 