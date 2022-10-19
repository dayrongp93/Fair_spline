function [num,den] = circulo(Puntos)
% Esta funci�n calcula el valor del par�metro omega para el cual se cumple
% que la curva de B�zier conica que interpola los puntos P0 y P2 con sus
% direcciones tangentes, es un arco de c�rculo.

% La idea es ver si el valor �ptimo que se obtiene al minimizar el valor
% del funcional coincide con el valor que retorna esta funci�n.

% Input:
% Puntos: matriz de puntos del tri�ngulo. 

% Output:
% omega: valor del par�metro.

%------------------------------------------------------
% Primeramente definamos la distancia euclideana entre dos puntos del plano
distancia = @(p1,p2) sqrt((p1(1)-p2(1))^2+(p1(2)-p2(2))^2);

% Daremos otra notaci�n a los puntos del tri�ngulo de control.
P0 = Puntos(1,:);
P1 = Puntos(2,:);
P2 = Puntos(3,:);

% Pasemos ahora a calcular el valor del par�metro omega por la ley de los
% cosenos para un �ngulo base
num1 = (distancia(P2,P0))^2+(distancia(P0,P1))^2-(distancia(P1,P2))^2;
den1 = 2*distancia(P0,P2)*distancia(P1,P0);
% Otro �ngulo base
num2 = (distancia(P1,P2))^2+(distancia(P0,P2))^2-(distancia(P0,P1))^2;
den2 = 2*distancia(P1,P2)*distancia(P2,P0);

alpha = num1/den1;
gama = num2/den2;
beta = pi - acos(alpha) - acos(gama);
angulo = (acos(alpha)+acos(gama))/2;
% dif = abs(acos(alpha)-acos(gama));
den = cos(angulo);
num = sin(beta);