function [optimo] = oro(Puntos,iteraciones)
% Esta función calcula el valor óptimo aproximado para minimzar el valor
% del funcional de la curvatura al cuadrado más la longitud de arco. 
% La función utiliza el método de la sección de oro para hallar el valor
% mínimo del funcional.

% Input:
% Puntos: matriz de puntos del plano
% iteraciones: son las iteraciones en el proceso de subdivisión.

% Output:
% Valor óptimo del parámetro ya calculado.
% Gráfica de la curva "fair"

%----------------------------------------------------------------
% 1) Vamos a aplicar la regla de oro
%----------------------------------------------------------------

% Sabemos que el valor del óptimo no es muy elevado, por lo que podemos
% asumir que el óptimo se encuentra en el itervalo [0 5]

x1 = 0.1;
x4 = 2;
tol = 1e-5;
F1 = (3-sqrt(5))/2;
F2 = 1-F1;
L = x4-x1;
error = norm(L);

x2 = x1 + F1.*L;
x3 = x1 + F2.*L;

f1 = curvatura_functional(Puntos,x1,iteraciones);
f2 = curvatura_functional(Puntos,x2,iteraciones);
f3 = curvatura_functional(Puntos,x3,iteraciones);
f4 = curvatura_functional(Puntos,x4,iteraciones);

while error > tol
    if f3 <= f2
        L = x4 - x2;
        x1 = x2;
        f1 = f2;
        x2 = x3;
        f2 = f3;
        x3 = x4 - F1.*L;
        f3 = curvatura_functional(Puntos,x3,iteraciones);
    else
        L = x3 - x1;
        x4 = x3;
        f4 = f3;
        x3 = x2;
        f3 = f2;
        x2 = x1 + F1.*L;
        f2 = curvatura_functional(Puntos,x2,iteraciones);
    end
    error = norm(L);
end
optimo = x1;



