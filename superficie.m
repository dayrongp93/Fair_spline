function [X,Y,Z] = superficie(Puntos,eje,s)
% Esta función genera una superficie de revolución que tiene como función
% generatriz la que describen los puntos que se indican.

% Input:
% Puntos: muestra de puntos de la curva generatriz
% eje: eje de simetría de la superficie
% s: Cantidad de divisiones de la superficie

% Output:
% Gráfica de la superficie

x1 = eje(1,1);
y1 = eje(2,1);
x2 = eje(1,2);
y2 = eje(2,2);
% Ángulo de rotación
theta = atan((y2-y1)/(x2-x1));
%-----------------------------------------------------------------------
% 1. Vamos a realizar un cambio de coordenadas adecuado
% Función de cambio de coordenadas
cambiox = @(x,y) x*cos(pi/2-theta) - y*sin(pi/2-theta);
cambioy = @(x,y) x*sin(pi/2-theta) + y*cos(pi/2-theta);

c1 = cambiox(x1,y1);
c2 = cambioy(x1,y1);

n = size(Puntos,2);
P = zeros(2,n);

for i=1:n
    P(1,i) = cambiox(Puntos(1,i),Puntos(2,i)) - c1;
    P(2,i) = cambioy(Puntos(1,i),Puntos(2,i)) - c2;
end

% Ahora vamos a generar la superficie
alpha = linspace(0,2*pi,s);
X = zeros(n,s);
Y = zeros(n,s);
Z = zeros(n,s);
for j=1:s
    alphas = alpha(j);
    for i=1:n
        X(i,j) = P(1,i)*cos(alphas);
        Y(i,j) = P(1,i)*sin(alphas);
        Z(i,j) = P(2,i);
    end
end


