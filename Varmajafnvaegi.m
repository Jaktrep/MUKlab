function V = Varmajafnvaegi(a,b,beta1,beta2,h)
  % VARMAJAFNVAEGI  Notkun: V = Varmajafnvaegi(a,b,beta1,beta2,h)
  %   Tekur inn lengd bila á x- og y-ásum, stuðla fyrir jaðarskilyrðaföllin
  %   g1 og g2 og skrefastærð. Skilar nálgun á lausn Laplace jöfnunnar
  %   með bútaaðferðinni.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Fjöldi panela skilgreindur út frá skrefastærð.
  N = a/h;
  M = b/h;
  % x- og y-ásar skilgreindir
  xi = 0:h:a;
  yj = 0:h:b;
  % Fallgildi g1 og g2 skilgreind
  g1 = beta1*(cos(2*pi*(yj - 0.5)/b)+1);
  g2 = beta2*(cos(2*pi*yj/b)+1);
  % Vídd fylkisins og vigranna í Ac = b.
  Q = (N+1)*(M+1);
  d = zeros(Q,1);
  A = zeros(Q,Q);
  % Fylki sem tengja þríhyrning númer n við númer hornpunkta sinna.
  % Það eru tvær týpur af þríhyrningum, S og L, þar sem L hefur tvo
  % hornpunkta í efri línu en S hefur aðeins einn hornpunkt í
  % efri línu.
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
  % l_j.l_k skilgreint fyrir týpurnar tvær
  A2 = [0.5, -0.5, 0;
        -0.5, 1, -0.5;
        0, -0.5, 0.5];
  A1 = [0.5, 0, -0.5;
        0, 0.5, -0.5;
        -0.5, -0.5, 1];
  % Stök sett í A sem samsvara einhverju
  for k=1:M*N
    for j = 1:3
      for i = 1:3
        A(L(k,j),L(k,i)) += A1(j,i);
        A(S(k,j),S(k,i)) += A2(j,i);
      end
    end
  end
  % ásar settir á hornalínuna til að nýta jaðarskilyrðin.
  for k=0:M
    A(k*(N+1)+1,:) = 0;
    A((k+1)*(N+1),:) = 0;
    A(k*(N+1)+1,k*(N+1)+1) = 1;
    A((k+1)*(N+1),(k+1)*(N+1)) = 1;
  end
  % d vigurinn er 0 nema þar sem eru jaðarskilyrði.
  d(1:N+1:M*(N+1)+1) = g1;
  d(N+1:N+1:Q) = g2;
  A = sparse(A);
  c = A\d;
  V = zeros(M+1,N+1);
  for k = 0:M
    V(k+1,:) = c(k*(N+1)+1:(k+1)*(N+1));
  end
end
