clear; close all;
% Step1: x[k]   [1]
% Simulate continuous time
f_s = 400000;    % 400 kHz (alternative sampling rate)
T=0.1;         % 0.1 second
samples=f_s*T; % total number of samples simulated
t=(0:(samples-1))/f_s; %time axis


% Generate bits
f_b=20000;       % bit_rate = 20 kbps
bits=f_b*T;      % number of bits simulated
rand('seed',0);  % 
b=round(rand(1,bits));

% Generate Symbols: QPSK symbols
bits_per_symbol=2;
f_symbol = f_b/bits_per_symbol;    % sym_rate = 10 ksym/s
symbols= bits/bits_per_symbol;     % number of QPSK symbols
samples_per_symbol=f_s/f_symbol;   % number of samples per QPSK symbol (40)
 
b_mat = reshape(b,bits_per_symbol,symbols);  % serial to parallel
b_1 = b_mat(1,:);
b_2 = b_mat(2,:);

j=sqrt(-1);
% sn = -2*(b_1-0.5) + j*-2*(b_2-0.5);  % QPSK symbols
% p_total = sum( abs(sn).^2 )/symbols;
% a = 1/sqrt(p_total);
% sn = sn.* a;
a  =  1/sqrt(2);
xn = a*(-2*(b_1-0.5) + j*-2*(b_2-0.5));  % QPSK symbols

% Step2: x(t)    
% Upsampling to simulate impulses in continuous time
x_up = upsample(xn, samples_per_symbol, samples_per_symbol/2);


% Tx/Rx filter: root raised cosine filter
B_rrcos=sqrt(samples_per_symbol)*firrcos(10*samples_per_symbol,f_symbol/2,0.5,f_s,'rolloff','sqrt');
% order=10x40=400, delay=400 per filter, 
% tx_filter + rx_filter => 800 delays (order)

% x(t) => after up_sampling and transmit filter
xt=filter(B_rrcos,1,x_up);

% Step3: xhat(t)   
% Ideial Channel
c    = [1];                             % channel profile
c_up = upsample(c, samples_per_symbol); % upsampling the channel

% Dispersive channel
%c_up    = [1 zeros(1,samples_per_symbol/4) -.5];       % channel profile: d(t)-0.5d(t-Ts/4)


% % AWGN 
SNR=40; % almost noiselss
N0 = 1/(10^(0.1*SNR));
% N0 = 0.04;    % SNR = 14 dB
 SNR = 10*log10(1/N0)
 sigma_n = sqrt(N0/2);
 sigma_x = std(xt);
 noise = sqrt(samples_per_symbol)*sigma_x*sigma_n*(randn(size(t)) + sqrt(-1)*randn(size(t)));
% %%%%%%%%%%%%%%%%%%%%%%
%noise = 0; %no noise


% convolution of x(t) and c(t)
xc = filter(c_up, 1, xt) + noise;

% Rx filter
xhat=filter(B_rrcos,1,xc);

% Eye Diagram
repetition= 300;     % number of repetitions for the drawing of the eye diagram
EYE = zeros(2*samples_per_symbol, repetition); % Two periods, draw 300(=repetition) times
% EYE = zeros(80, 300);
EYE(:) = xhat(samples_per_symbol*10+1:(2*samples_per_symbol)*repetition+samples_per_symbol*10)';  

figure;
plot(t(1:1:2*samples_per_symbol),real(EYE) ); grid ;
%set(gca,'XTick',0:5e-5:2e-4);
set(gca,'XTick',0:50e-6:200e-6);
title('Eye Diagram of Real(Received QPSK Signal) : No Noise, IdealChannel');
%title('Eye Diagram of Real(Received QPSK Signal) : SNR=14dB, IdealChannel');
%title('Eye Diagram of Real(Received QPSK Signal) : No Noise, Dispersive Channel');
xlabel('time t (sec)');
ylabel('Real(r(t))');
%axis([0, 2e-4, -1.5, 1.5]);


% figure;
% plot(0:2*samples_per_symbol-1,real(EYE)); grid;
% title('Eye Diagram of Real(Received Signal) : SNR=14dB, IdealChannel');
% xlabel('sample, n');
% ylabel('Real(xhat(t))');
% 
% 
% 
% figure;
% plot(0:2*samples_per_symbol-1,imag(EYE)); grid;
% title('Eye Diagram of Imag(Received Signal) : SNR=14dB, IdealChannel');
% xlabel('sample, n');
% ylabel('Imag(xhat(t))');

% Step4: xhat[k]    [1][2]
% Sampling
Ninit=samples_per_symbol*10+samples_per_symbol/2+1; 
xnhat=xhat(Ninit:samples_per_symbol:end);

% calculate bit delays
SymDelay = samples_per_symbol*10/samples_per_symbol; 
%SymDelay=10; % 2000 delay in time map to 10 delay for each symbol
BitDelay = SymDelay * bits_per_symbol;

% parallel to serial
b_1_hat = real(xnhat) < 0;
b_2_hat = imag(xnhat) < 0;

b_mat_hat = [b_1_hat;b_2_hat];
b_hat=reshape(b_mat_hat,1,bits-BitDelay);


% Bit Error Rate Calculation
BER=sum(b_hat~=b(1:end-BitDelay))/length(b_hat)



% plots of sampled received signal snhat and transmitted discrete-time signal xn
figure;
stem(t(1:samples_per_symbol:10*samples_per_symbol), real(xn(1:10)), 'bo'); hold on;
plot(t(1:samples_per_symbol:10*samples_per_symbol), real(xnhat(1:10)),'rx'); hold on;
plot(t(1:1:381), real(sqrt(samples_per_symbol)*xt(20+SymDelay*samples_per_symbol/2:600)),'g-'); hold on;  %tx filter
plot(t(1:1:381), real(xhat(20+SymDelay*samples_per_symbol:800)),'k-'); hold off;                           %tx and rx filter

axis([0, 1e-3, -1.1, 1.1]);

legend('x[k]', 'xhat[k]', 'tx filter', 'tx + rx filter');
title('First 10 samples of QPSK symbol SNR=14dB: real(x[k]) and real(xhat[k])');
xlabel('t (sec)');
ylabel('Amplitude');

figure;
stem(t(1:samples_per_symbol:10*samples_per_symbol), imag(xn(1:10)), 'bo'); hold on;
plot(t(1:samples_per_symbol:10*samples_per_symbol), imag(xnhat(1:10)),'rx'); hold on;
plot(t(1:1:381), imag(sqrt(samples_per_symbol)*xt(20+SymDelay*samples_per_symbol/2:600)),'g-'); hold on;   %tx filter
plot(t(1:1:381), imag(xhat(20+SymDelay*samples_per_symbol:800)),'k-'); hold off;                           %tx and rx filter

legend('x[k]', 'xhat[k]', 'tx filter', 'tx + rx filter');
title('First 10 samples of QPSK symbol SNR=14dB: imag(x[k]) and imag(xhat[k])');
xlabel('t (sec)');
ylabel('Amplitude');
axis([0, 1e-3, -1.1, 1.1]);

