function [B, A] = Bylgjujafna(L,T,N,M,gamma)
  h = L/N;
  tau = T/M;
  tk = 0:tau:T;
  f0 = -0.1;
  Q = (N+1)*(M+1);
  A = speye(Q,Q);
  for k=2:M
    for j=1:N-1
      i = (N+1)*k + (j+1);
      A(i,i-2*(N+1):(N+1):i) = [tau^(-2) -2*tau^(-2) (tau^(-2)+2*gamma^2*h^(-2))];
      A(i,i-1:2:i+1) = [-gamma^2*h^(-2) -gamma^2*h^(-2)];
    end
  end
  for j=1:N-1
     i =  (N+1) + j+1;
     A(i,i-1:i+1) = [-gamma^2*h^(-2) (2*tau^(-2)+2*gamma^2*h^(-2)) -gamma^2*h^(-2)];
  end
  bvec = f0*ones(Q,1);
  bvec(N+1:N+1:Q) = 2*sin(6*pi.*tk/T);
  bvec(1:N+1) = 0;
  bvec(N+2:N+1:Q) = 0;
  cvec = A\bvec;
  B = zeros(M+1,N+1);
  for k = 0:M
    B(:,k + 1) = cvec(k*(N+1) + 1:(k+1)*(N+1));
  end
end
