function V = Varmajafnvaegi2(a,b,beta1,beta2,h)
  N = a/h;
  M = b/h;
  Q = (N+1)*(M+1);
  d = zeros(Q,1);
  A = zeros(Q,Q);
  L = zeros(M*N,3);
  S = zeros(M*N,3);
  for j = 1:M
    for i = 1:N
      l = N*(j-1) + i;
      L(l, 1) = (N+1)*(j-1) + i;
      L(l, 2) = (N+1)*(j-1) + i + N + 2;
      L(l, 3) = (N+1)*(j-1) + i + N + 1;
      S(l, 1) = (N+1)*(j-1) + i;
      S(l, 2) = (N+1)*(j-1) + i + 1;
      S(l, 3) = (N+1)*(j-1) + i + N + 2;
    end
  end
  A2 = [0.5, -0.5, 0;
        -0.5, 1, -0.5;
        0, -0.5, 0.5];
  A1 = [0.5, 0, -0.5;
        0, 0.5, -0.5;
        -0.5, -0.5, 1];
  for k=1:M*N
    for j = 1:3
      for i = 1:3
        A(L(k,j),L(k,i)) += A1(j,i);
        A(S(k,j),S(k,i)) += A2(j,i);
      end
    end
  end
  for k=0:M
    A(k*(N+1)+1,:) = 0;
    A((k+1)*(N+1),:) = 0;
    A(k*(N+1)+1,k*(N+1)+1) = 1;
    A((k+1)*(N+1),(k+1)*(N+1)) = 1;
  end

  d(1:N+1:M*(N+1)+1) =  0.5*abs(Gamma((-1) + (-3:0.06:3) + 0.02i));
  d(N+1:N+1:Q) = 5*beta2*(cos(2*pi*(0:h:1)/b)+1);
  A = sparse(A);
  c = A\d;
  V = zeros(M+1,N+1);
  for k = 0:M
    V(k+1,:) = c(k*(N+1)+1:(k+1)*(N+1));
  end
end
