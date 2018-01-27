R = 1; %抵抗
L = 1; %インダクタンス
J = 1; %慣性モーメント
b = 1; %粘性摩擦係数
Ke = 1; %誘起電力定数
Kt = 1; %トルク定数

Kb = 1; %フィードバックゲイン

G1 = tf(Kt, [L R],'inputname','voltage',...
    'outputname','torque');
G2 = tf(1,[J b],'inputname','torque',...
    'outputname','angular');
dcm = ss(G2) * [G1 , 1]; %G1からの入力と外乱トルクの入力
%dcmのフィードバックコントローラKbの出力をプラントDCM入力1に接続
%プラントDCM出力1をフィードバックコントローラKbに入力
feedin = 1;
feedout = 1;
dcm = feedback(dcm,Kb,feedin,feedout);

stepplot(dcm(1)); %dcm(2)の場合、外乱トルクに入力
