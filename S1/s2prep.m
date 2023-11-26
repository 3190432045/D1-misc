% system for s2


g = 9.81;
L = 0.20;
omega1 = sqrt(g/L);

% system function
SysP_s = tf(-omega1^2,[1 0 -omega1^2]);

disp('==========DISP ON==========');
disp(SysP_s);
disp('==========DISP OFF=========');

% rlocus
[R,K] = rlocus(SysP_s);
disp('==========DISP ON==========');
disp(R);
disp(K);
disp('==========DISP OFF=========');

% bode
[MAG,PHASE] = bode(SysP_s);
disp('==========DISP ON==========');
disp(MAG);
disp(PHASE);
disp('==========DISP OFF=========');


t = 0:0.01:20;

[y1,t] = step(SysP_s,t);


%subplot(2,2,1);
plot(t,y1);
title('step responce');
grid on;

%figure rlocus
figure;
rlocus(SysP_s);
title('Root Locus Plot');

%figure bode
figure;
bode(SysP_s);
title('Bode Plot');
