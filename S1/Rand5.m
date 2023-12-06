%5 Random Signals

a = -4;
b = 4;
N = 100000;
x = a + (b-a).*rand(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x);

ex = 0;
dx = 2;
N = 100000;
x1 = ex + dx.*randn(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x1);

ex = 0;
dx = 1;
N = 100;
x1 = ex + dx.*randn(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x1);

ex = 0;
dx = 1;
N = 500;
x1 = ex + dx.*randn(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x1);

ex = 0;
dx = 1;
N = 2000;
x1 = ex + dx.*randn(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x1);

ex = 0;
dx = 1;
N = 1000;
x1 = ex + dx.*randn(1,N);

disp('==========DISP ON==========');
%disp(x);
disp('==========DISP OFF=========');
figure;
hist(x1);



