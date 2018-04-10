L = 1;
T = 10;
N = 100;
M = 100;
h = L/N;
tau = T/M;
gamma = 0.5;
xj = 0:h:L;
tk = 0:tau:T;


B = Bylgjujafna(L,T,N,M,gamma);

figure(1)
plot(xj,B(:,21));   
xlabel('x');
ylabel('u(x,t)');
title('Bylgjujafnan: nálgunarlausn u(x,t) við tímann t = 2');

figure(2)
plot(xj,B(:,41));    
xlabel('x');
ylabel('u(x,t)');
title('Bylgjujafnan: nálgunarlausn u(x,t) við tímann t = 4');

figure(3)
plot(xj,B(:,61));  
xlabel('x');
ylabel('u(x,t)');
title('Bylgjujafnan: nálgunarlausn u(x,t) við tímann t = 6');

figure(4)
plot(xj,B(:,81));   
xlabel('x');
ylabel('u(x,t)');
title('Bylgjujafnan: nálgunarlausn u(x,t) við tímann t = 8');

figure(5)
plot(xj,B(:,101));   
xlabel('x');
ylabel('u(x,t)');
title('Bylgjujafnan: nálgunarlausn u(x,t) við tímann t = 10');
