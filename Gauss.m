function X = Gauss(A,b)

W=[A b];
N = size(A, 1);
P = 1:N;
X = 0;

%Algoritmo de eliminación de Gauss para matrices tridiagonales
 for k=1:N-1
     p=-1;
     for j=k:k+1
         if (W (P(j),k) ~= 0)
             p = j;
             break;
         end
     end
     if (p == -1)
         X = -1;
         break;
     end
     aux = P(p); P(p) = P(k); P(k) = aux;
     for i=k+1:N
        W(P(i),k) = W (P(i),k)/W(P(k), k);
        for j=k+1:N+1
            W(P(i),j) = W(P(i),j) - W(P(i),k)* W(P(k),j);
        end
     end
 end
 if (X~=-1)
    X=retrogsust(W,P);
 end