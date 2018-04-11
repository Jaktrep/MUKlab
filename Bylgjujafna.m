function B = Bylgjujafna(L,T,N,M,gamma)
  % NOTKUN  Bylgjujafna(L,T,N,M,gamma) til að finna nálgunarlausn á bylgjujöfnunni.
  % BYLGJUJAFNA tekur inn lengd á efni, lengd tímabilsins sem á að athuga,
  %    fjölda panela sem á að skipta x-ásnum og tímaásnum upp í
  %    og bylgjuhraða bylgjunnar. Jaðarskilyrðin u(0,t) = u(x,0) = 0,
  %    u(L,t) = 2sin(6pit/T) og du/dt(x,0) = 0 eru notuð til að finna
  %    nálgun á lausn bylgjujöfnunnar.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Stærðir skilgreindar:
  % Skrefastærð eftir x-ás
  h = L/N;
  % Skrefastærð eftir t-ás
  tau = T/M;
  % Punktarnir sem nálgað er á á t-ás
  tk = 0:tau:T;
  % Krafturinn sem er beitt á efnið
  f0 = -0.1;
  % Vídd vigranna og fylkisins
  Q = (N+1)*(M+1);
  % Fylkið A er notað til að finna nálgunarvigurinn
  A = speye(Q,Q);
  % Uppbygging A er eftirfarandi
  % I 0 0 0 0 0 0 ...
  % 0 B 0 0 0 0 0 ...
  % C D E 0 0 0 0 ...
  % 0 C D E 0 0 0 ...
  % 0 0 C D E 0 0 ...
  % . . . . . . . ...
  % þar sem I er N+1 einingarfylki, 0 er núllfylki, B nálgar afleiðujöfnuna
  % þegar t = T/M og C, D og E nálga afleiðujöfnuna restina af leiðinni.
  % Í ákveðnum röðum er þó enn ás á hornalínunni til að pikka út þekkt
  % fallgildi í b vigrinum.
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
  % hægri hlið jöfnunnar Ac = b skilgreind. b vigurinn inniheldur f0
  % allsstaðar nema þar sem er þekkt fallgildi.
  bvec = f0*ones(Q,1);
  bvec(N+1:N+1:Q) = 2*sin(6*pi.*tk/T);
  bvec(1:N+1) = 0;
  bvec(N+2:N+1:Q) = 0;
  cvec = A\bvec;
  % Gildum cvec raðað í samsvarandi hólf í fylkið B.
  B = zeros(M+1,N+1);
  for k = 0:M
    B(:,k + 1) = cvec(k*(N+1) + 1:(k+1)*(N+1));
  end
end
