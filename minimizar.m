function [optimo] = minimizar(Puntos,iteraciones)
% Esta funci�n calcula el valor �ptimo aproximado para minimzar el valor
% del funcional de la curvatura al cuadrado m�s la longitud de arco. 
% La funci�n calcula el cero para la derivada del argumento del funcional 
% por el m�todo de Newton, dado que el cero de la derivada (en este caso
% nuestra funci�n) es �nico.

% Input:
% Puntos: matriz de puntos del plano
% iteraciones: son las iteraciones en el proceso de subdivisi�n.

% Output:
% Valor �ptimo del par�metro ya calculado.
% Gr�fica de la curva "fair"

% -------------------------------------------------------------
% 1) Vamos a aplicar el m�todo para hallar el cero 
% -------------------------------------------------------------
inicio = 0.2;

% Formula para la derivada para implemetar Newton
h = 0.001;
deriv = @(omega) (dcurvatura_functional(Puntos,omega+h,iteraciones)-dcurvatura_functional(Puntos,omega,iteraciones))/h;

% M�todo de Newton
while 1
    next = inicio - dcurvatura_functional(Puntos,inicio,iteraciones)/deriv(inicio);
    if abs((inicio-next)/next)<0.5*10^(1-3)
        optimo = next;
        return
    end
    inicio = next;
end





