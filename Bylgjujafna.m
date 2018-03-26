function B = Bylgjujafna(L,T,N,M,gamma)
%Skiptipunktar skilgreindir:
h = L/N;
tau = T/M;
xj = 0:h:L;
tk = 0:tau:T;
%Fylki skilgreint:
Q = (N+1)*(M+1);
A = sparse(Q,Q);
A = eye(Q,Q);
for j = 1:N+1
  A(N+2+j,:) = [zeros(1,N+j), -gamma^2*h^(-2), 2*tau^(-2) + 2*gamma^2*h^(-2), - gamma^2*h^(-2), zeros(1, Q - N - j - 3)];
end
for j = 1: Q - 2*N - 3
  A(2*N + 3 + j, :) = [zeros(1,j)]
end
A

%cvec reiknaður
%cvec = A\bvec

end
