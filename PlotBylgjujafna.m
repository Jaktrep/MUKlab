L = 1;
T = 10;
N = 100;
M = 100;
gamma = 0.5;
C = Bylgjujafna(L,T,N,M,gamma);
xj = 0:(L/N):L; 
plot(xj,C(21,:))
hold on
K = importdata('/Users/mbh/Desktop/bgildi.mat');
isequal(K,C)
plot(xj,K(21,:))
hold off
