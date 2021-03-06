function V = MatlabEddan(a,b,beta1,beta2,h)
  N = a/h;
  M = b/h;
  xi = 0:h:a;
  yj = 0:h:b;
  c = 0.5;
  d = 13;
  %rz = zeros(1,length(yj));
  wf1 = zeros(1,length(yj));
  g2 = 0.5*abs(Gamma((-1) + (-3:0.06:3) + 0.02i));
  %cf = zeros(1,length(yj));
  %for i = 1:length(yj)
  %   cf(1,i) = CantorFunction(yj(i));
  %end
  for n=0:100
      wf1 = wf1 + c^n*cos(d^n*pi*yj);
  end
  g1 = 10*wf1;
  %g2 = 2*cf;
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
  d(1:N+1:M*(N+1)+1) = g1;
  d(N+1:N+1:Q) = g2;
  A = sparse(A);
  c = A\d;
  V = zeros(M+1,N+1);
  for k = 0:M
    V(k+1,:) = c(k*(N+1)+1:(k+1)*(N+1));
  end
end
