% system
% control coursework 2


gshs = tf(1,[1 10 16 0],'InputDelay',0.01);

disp(gshs);

%figure
figure;
nyquist(gshs);
title('gshs nyquist Plot');

%
figure;
pzmap(gshs);
title('gshs PZ Map');

%
[mag_margin, phase_margin, crossover_freq, gain_margin] = margin(gshs);
disp(gain_margin);
disp(phase_margin);

figure;
bode(gshs);
title('bode');
