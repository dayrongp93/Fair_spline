function [optimo] = minimizar(Puntos,iteraciones)
% Esta función calcula el valor óptimo aproximado para minimzar el valor
% del funcional de la curvatura al cuadrado más la longitud de arco. 
% La función calcula el cero para la derivada del argumento del funcional 
% por el método de Newton, dado que el cero de la derivada (en este caso
% nuestra función) es único.

% Input:
% Puntos: matriz de puntos del plano
% iteraciones: son las iteraciones en el proceso de subdivisión.

% Output:
% Valor óptimo del parámetro ya calculado.
% Gráfica de la curva "fair"

% -------------------------------------------------------------
% 1) Vamos a aplicar el método para hallar el cero 
% -------------------------------------------------------------
inicio = 0.2;

% Formula para la derivada para implemetar Newton
h = 0.001;
deriv = @(omega) (dcurvatura_functional(Puntos,omega+h,iteraciones)-dcurvatura_functional(Puntos,omega,iteraciones))/h;

% Método de Newton
while 1
    next = inicio - dcurvatura_functional(Puntos,inicio,iteraciones)/deriv(inicio);
    if abs((inicio-next)/next)<0.5*10^(1-3)
        optimo = next;
        return
    end
    inicio = next;
end





