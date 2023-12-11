% matlab script file:   
%
% ELEC2021, Communications II
%
% Purpose: demonstrate the AM modulation and demodulation
%

close all;
clear all;

Ts = 1/10000;               % time resultion for simulation of
                            % "analogue" system
t = (0:Ts:0.1-Ts);          % time scale, 1000 samples [0 0.1) seconds

wc = 2*pi*2500;             % carrier angular frequency
wi = 2*pi*50;               % message frequency

s = cos(wi*t);              % message
x = cos(wc*t);              % carrier
A = 1;                      % adjust the AM offset here
%A=0;
gamma = 0.5;               %
%gamma = 1;

s_HF = (A + gamma*s).*x;    % AM modulation

% display modulated data
figure(1);
subplot(211);
plot(t,s_HF);

%hold on; plot(t,s,'r','LineWidth',3);

xlabel('time t [s]');
ylabel('amplitude s_{HF}(t)');
%ylabel('amplitude s(t)');

axis([0 0.1 -2 2]);
%axis([0 0.1 -1 1]);

subplot(212);
f = (0:1/1000/Ts:999/1000/Ts);
S_HF_N = abs(fft(s_HF)/1000);
stem(f,S_HF_N);
axis([2300 2700 0 0.5]);

ylabel('magnitude |S(j2\pi f)|');
xlabel('frequency f [Hz]');



% demodulatio by envelope detection
r_HF = abs(s_HF);                 % absolute value
h = fir1(23,0.1);                  
[r,Zf] = filter(h,1,r_HF);        % LPF
r = filter(h,1,r_HF,Zf);

figure(2)
title('envelope detection');
subplot(211);
plot(t,r_HF);
axis([0 0.1 0 2]);
xlabel('time t [s]');
ylabel('amplitude |r_{HF}(t)|');
subplot(212);
plot(t,2*r);
axis([0 0.1 0 2]);
xlabel('time t [s]');
ylabel('amplitude r(t)');

% coherent demodulation 
x = cos(wc*t);
r_HFtilde = s_HF.*x;
h = [1 1]/2;
r = filter(h,1,r_HFtilde);

figure(3);
subplot(211);
title('coherent demodulation');
R_HFtilde = abs(fft(r_HFtilde)/1000);
stem(f,R_HFtilde);
H = abs(fft(h,1000));
hold on;
plot(f,H,'r');
legend('!\tilde{R}_{HF}(j2\pi f)|','lowpass filter');
xlabel('time f / [Hz]');
ylabel('magnitude');

subplot(212);
plot(t,r);
xlabel('time t / [s]');
ylabel('amplitude r(t)');








