function B = Bylgjujafna(L,T,N,M,gamma)
  % Skiptipunktar skilgreindir:
  h = L/N;
  tau = T/M;
  xj = 0:h:L;
  tk = 0:tau:T;
  f0 = -0.1;
  % Fylki skilgreint:
  Q = (N+1)*(M+1);
  % A hefur ása á hornalínunni þar sem er ekki einhver stæða, þá
  % er heppilegast að skilgreina það fyrst sem einingarfylki og
  % yfirskrifa svo þau stök sem eiga ekki að vera einn.
  A = speye(Q,Q);
  % Uppbygging fylksins
  % I 0 0 0 0 ...
  % 0 B 0 0 0 ...
  % C D E 0 0 ...
  % 0 C D E 0 ...
  % 0 0 C D E ...
  % . . . . . ...
  for k=0:M - 2
    for l = 2:N
      A((k + 2)*(N + 1) + l, l + k*(N + 1)) = tau^(-2);
      A((k + 2)*(N + 1) + l, l + (k + 1)*(N + 1)) = -2*tau^(-2);
      A((k + 2)*(N + 1) + l, ((k + 2)*(N + 1) + l - 1):((k + 2)*(N + 1) + l + 1)) =  [-gamma^2*h^(-2), tau^(-2) + gamma^2*h^(-2), -gamma^2*h^(-2)];
    end
  end
  A(N+2+1,:) = A(N+2+1,:) + [zeros(1,N+1), -gamma^2*h^(-2), 2*tau^(-2) + 2*gamma^2*h^(-2), - gamma^2*h^(-2), zeros(1, Q - N - 1 - 3)];
  A(N+2+2,:) = [zeros(1,N+2), -gamma^2*h^(-2), 2*tau^(-2) + 2*gamma^2*h^(-2), - gamma^2*h^(-2), zeros(1, Q - N - 2 - 3)];
  for j = 3:N+1
    A(N+2+j,:) = A(N+2+j,:) + [zeros(1,N+j), -gamma^2*h^(-2), 2*tau^(-2) + 2*gamma^2*h^(-2), - gamma^2*h^(-2), zeros(1, Q - N - j - 3)];
  end
  % bvec skilgreindur

  bvec = f0*ones(Q,1);
  bvec(1:N+1) = 0;
  bvec(N+2:N+1:Q) = 0;
  bvec(N+1:N+1:Q) = 2*sin(6*pi.*tk/T);
  %cvec reiknaður
  cvec = A\bvec;
  B = zeros(M+1,N+1);
  for k = 0:M
    B(k+1,:) = cvec(k*(N+1) + 1:(k+1)*(N+1));
  end
end
