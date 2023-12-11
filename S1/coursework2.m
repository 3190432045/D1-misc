% system
% control coursework 2


ps = tf(1,[1 0 4]);
gs = tf([1 4],1);

gs2 = tf([30 120],[1 50]);

k = 1;
k2 = 1;

kgs = series(k,gs);
kgs2 = series(k2,gs2);

cltf = feedback(ps,kgs);
cltf2 = feedback(ps,kgs2);

oltf = series(ps,gs);
oltf2 = series(ps,gs2);
oltfa = tf([1 4],[1 0 4]);

disp(ps);

%figure rlocus
figure;
rlocus(oltf);
title('oltf Root Locus Plot');

%figure rlocus
figure;
rlocus(oltf2);
title('oltf2 Root Locus Plot');

%figure rlocus
figure;
pzmap(oltf);
title('oltf PZ Map');

%feedback step
figure;
pzmap(cltf);
title('cltf PZ Map');

%feedback step
figure;
pzmap(cltf2);
title('cltf2 PZ Map');

%feedback step
figure;
step(cltf);
title('cltf step responce');

%feedback step
figure;
step(cltf2);
title('cltf2 step responce');
