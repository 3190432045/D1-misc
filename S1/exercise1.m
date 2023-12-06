% exercise1.m


% Generation of a Unit Sample Sequence

% Generate a vector from -20 to 20
n = -20:20;
% Generate the unit sample sequence
u = [zeros(1,20) 1 zeros(1,20)];
% Plot the unit sample sequence
figure;
stem(n,u);
xlabel('n');
ylabel('u[n]');
axis([-20 20 0 1.2]);

% Generate the ud
ud = [zeros(1,30) 1 zeros(1,10)];

figure;
stem(n,ud);
xlabel('n');
ylabel('ud[n]');
axis([-20 20 0 1.2]);

% Generate the sn
sn = [zeros(1,20) ones(1,21)];

figure;
stem(n,sn);
xlabel('n');
ylabel('sn[n]');
axis([-20 20 0 1.2]);

% Generate the sdn
sdn = [zeros(1,30) ones(1,11)];

figure;
stem(n,sdn);
xlabel('n');
ylabel('sdn[n]');
axis([-20 20 0 1.2]);
