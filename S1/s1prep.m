% system


% zeta = 0
servo1 = tf(1,[1 0 1]);
% zeta = 0.5
servo2 = tf(1,[1 1 1]);
% zeta = 1
servo3 = tf(1,[1 2 1]);
% zeta = 2
servo4 = tf(1,[1 4 1]);


t = 0:0.01:20;

[y1,t] = step(servo1,t);

[y2,t] = step(servo2,t);

[y3,t] = step(servo3,t);

[y4,t] = step(servo4,t);


subplot(2,2,1);
plot(t,y1);
title('step responce zeta = 0');
grid on;

subplot(2,2,2);
plot(t,y2);
title('step responce zeta = 0.5');
grid on;

subplot(2,2,3);
plot(t,y3);
title('step responce zeta = 1');
grid on;

subplot(2,2,4);
plot(t,y4);
title('step responce zeta = 2');
grid on;
