a = 2;
b = 1;
beta1 = 1;
beta2 = 2;
h = 1/100;
V = Varmajafnvaegi(a,b,beta1,beta2,h);
xi = 0:h:a;
yj = 0:h:b;

figure(1)
surf(xi,yj,V);
xlabel('x');
ylabel('y');
zlabel('u(x,y)');
title('Þrívítt graf af fletinum');

figure(2)
vaporwave;
colormap(C);
contour(xi,yj,V,100)
xlabel('x');
ylabel('y');
title('Jafnhæðarlínur flatarins');
