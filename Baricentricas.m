function [w] = Baricentricas(P,Q)
% Esta función devuelve las coordenadas baricéntricas de un punto interior
% al triángulo. Si las tres son positivas, entonces el punto es interior y
% si una de ellas es negativa, entonces es exterior.

% Input:
% P: puntos del triángulo.
% Q: punto que se va a interpolar.
% tangentes: tangentes a los puntos en P

P = P';
b0 = P(1,:);
b1 = P(2,:);
b2 = P(3,:);

% Encontrar las coordenadas baricéntricas del punto interior al triangulo.

A = [1 1 1;b0(1) b1(1) b2(1);b0(2) b1(2) b2(2)];
b = [1 Q(1) Q(2)]';
X = Gauss(A,b);

% Condiciones para que el punto esté en el interior del triángulo

if X(1)<0 || X(2)<0 || X(3)<0
    % No está en el interior 
    w = -1;
else
    % Está en el interior
    % Encontrar el valor del parámetro w.
    w = sqrt((X(2)^2)/(4*X(1)*X(3)));
end
