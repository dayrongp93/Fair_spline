function X = retrogsust (M,P)
%Realiza el algoritmo de sustitución retrógada sobre la matriz cuadrada M
%que se asume que esta es triangulizada superiormente y permuta según P

N = size(M, 1);
X = zeros([N 1]);

if M(1,1)==0
   p=-1;
   for k=2:N
       if (M (k,1) ~=0)
           p = k;
           break;
       end
   end
   if (p == -1)
       return;
   end
   aux1 = M(p,:); M(p,:) = M(1,:); M(1,:) = aux1; 
   aux = P(p); P(p) = P(1); P(1) = aux;
   for i=N:-1:1
       S = 0;
       for k=i+1:N
           S = S + M(P(i),k)*X(P(k),1);
       end
       X(P(i),1) = (M(P(i),N+1) - S) / M(P(i),P(i));
   end
end
for i=N:-1:1
    S = 0;
    for k=i+1:N
        S = S + M(P(i),k)*X(P(k),1);
    end
    X(P(i),1) = (M(P(i),N+1) - S) / M(P(i),P(i));
end

