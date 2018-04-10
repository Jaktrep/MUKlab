a = 2;
b = 1;
beta1 = 1;
beta2 = 2;
h = 1/100;
V = Varmajafnvaegi(a,b,beta1,beta2,h);
xi = 0:h:a;
yj = 0:h:b;
surf(xi,yj,V)
