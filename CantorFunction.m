%Fallið tekur inn rauntöluna 0 \leq x \leq 1 og skilar Cantor-gildi hennar fx.

function fx = CantorFunction(x)
  y = 1;
  z = 0;
  n = 0;
  if(x == 0.25) 
      fx = 1/3;
  elseif (x == 0.75) 
      fx = 2/3;
  elseif (x == 0) 
      fx = 0;
  elseif (x == 1) 
      fx = 1;
  else
  while n < 200
    n = n+1;
    x = 3*x;
    y = 0.5*y;
    if(x > 2)
      x = x - 2;
      z = z + y;
    elseif (x >= 1.0) 
      fx = y + z;
       end
    end
  end
end
