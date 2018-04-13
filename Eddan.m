function V = Eddan(a,b,beta1,beta2,h)
  N = a/h;
  M = b/h;
  xi = 0:h:a;
  yj = 0:h:b;
  wf = zeros(1,length(yj));
  gf = 0.1*(abs(Gamma((-1) - 5*(yj-0.75) - 0.02i)) - abs(Gamma((-1) - 5*(yj-0.25) - 0.02i)));
  for n=0:100
      wf = wf + (0.75)^n*cos(13^n*pi*yj);
  end
  g1 = wf;
  g2 = gf;
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
        A(L(k,j),L(k,i)) = A(L(k,j),L(k,i)) +  A1(j,i);
        A(S(k,j),S(k,i)) = A(S(k,j),S(k,i)) + A2(j,i);
      end
    end
  end
  for k=0:M
    A(k*(N+1)+1,:) = 0;
    A((k+1)*(N+1),:) = 0;
    A(k*(N+1)+1,k*(N+1)+1) = 1;
    A((k+1)*(N+1),(k+1)*(N+1)) = 1;
  end
  d(1:N+1:M*(N+1)+1) = g1;
  d(N+1:N+1:Q) = g2;
  A = sparse(A);
  c = A\d;
  V = zeros(M+1,N+1);
  for k = 0:M
    V(k+1,:) = c(k*(N+1)+1:(k+1)*(N+1));
  end
end
