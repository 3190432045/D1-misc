Fs = 8000;        % Sampling rate of signal
Fc = 200;         % Carrier frequency
Fi = 10;          % Message frequency
dev = 100;        % Frequency deviation in modulated signal

t = [0:Fs-1]'/Fs; % Sampling times
t = t(1: size(t)/4);

t_sec=linspace(0, length(t)/Fs ,length(t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x= sin(2*pi*Fi*t);


y = fmmod(x,Fc,Fs,dev); % Modulate both channels.

subplot(2,1,1);
plot(t_sec,x, 'b');
axis([0 t_sec(end) -1.2 1.2]); xlabel('time (s)'); ylabel('Message signal');

subplot(2,1,2);
plot(t_sec,y, 'b');
axis([0 t_sec(end) -1.2 1.2]) ; xlabel('time (s)'); ylabel('FM signal');



