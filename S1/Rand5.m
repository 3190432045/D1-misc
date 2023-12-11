%5 Random Signals

a = -4;
b = 4;
N = 100000;
x = a + (b-a).*rand(1,N);


figure;
subplot(2,1,1);
hist(x);
title('uniform -4 4');
subplot(2,1,2);
cdfplot(x);

ex = 0;
dx = 2;
N = 100000;
x1 = ex + dx.*randn(1,N);


figure;
subplot(2,1,1);
hist(x1);
title('normal 0 2');
subplot(2,1,2);
cdfplot(x1);


ex = 0;
dx = 1;
N = 100;
x1 = ex + dx.*randn(1,N);


figure;
subplot(2,1,1);
hist(x1);
title('normal 0 1 100');
subplot(2,1,2);
cdfplot(x1);

ex = 0;
dx = 1;
N = 500;
x1 = ex + dx.*randn(1,N);


figure;
subplot(2,1,1);
hist(x1);
title('normal 0 1 500');
subplot(2,1,2);
cdfplot(x1);

ex = 0;
dx = 1;
N = 2000;
x1 = ex + dx.*randn(1,N);


figure;
subplot(2,1,1);
hist(x1);
title('normal 0 1 2000');
subplot(2,1,2);
cdfplot(x1);

ex = 0;
dx = 1;
N = 10000;
x1 = ex + dx.*randn(1,N);


figure;
subplot(2,1,1);
hist(x1);
title('normal 0 1 10000');
subplot(2,1,2);
cdfplot(x1);



