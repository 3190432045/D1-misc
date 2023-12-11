% matlab script file:   
%
% ELEC2021, Communications II
%
% Purpose: demonstrate a phase-locked loop
%
% Univ. of Southampton

close all;
clear all;

Ts = 1/10000;               % time resultion for simulation of "analogue" system

t = (0:Ts:1-Ts);            % time scale, 1000 samples [0 0.1) seconds

wc = 2*pi*1250;             % carrier angular frequency
phi_c = pi/4;               % carrier phase offset


%dwc = 0;                   % carrier frequency offset
dwc = 2*pi*0.2;             % carrier frequency offset

c = 10;                     % sensitivity of VCO [Hz/V]

x = cos((wc+dwc)*t+phi_c);  %received signal: carrier with offsets

e(1) = 0;
u(1) = 0; v(1)=0;
theta(1) = 0; 
for i = 2:length(t),

%  theta(i) = theta(i-1) + wc*Ts + c*e(i-1)*Ts;    % integration of phase
%  v(i) = sin(theta(i));   % VCO output

  theta(i) = theta(i-1) + c*e(i-1)*Ts;    % integration of phase
  time = Ts*(i-1);
 
  v(i) = sin(wc*time + theta(i));   % VCO output

  u(i) = x(i)*v(i); % the demodulated signal

  % loop filter: remove high Frequency component
  if i>= 8,
    U = u(i:-1:i-7);
    e(i) = U*ones(8,1)/4; 
  else
    e(i) = 0;
  end;
  
end;


plot(t,c*e/(2*pi));
'PaperSize',[25 35];

grid on;
xlabel('time [s]');
ylabel('\theta(t) / ( 2\pi ) [rad]');
%print -depsc pll_.eps
%system('epstopdf pll_.eps');






