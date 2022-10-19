function [I] = curvatura_functional(Puntos,parametro,iteraciones)
% Esta función calcula la integral de la curvatura de la curava que se genera en el
% proceso de subdivisión discretizando el funcional de la curvatura.

% Input:
% Puntos: matriz de puntos del triángulo. 

% Output:
% Gráfico de la curva interpolante.
% Valor de la integral de la curvatura aproximadamente. 

% ----------------------------------------------------------------
% 1) Generar puntos sobre la curva
% ----------------------------------------------------------------
[puntos,~,L,a,b] = Subdivision_rule_1(Puntos,parametro,iteraciones);
n = size(puntos,2);
[c,d] = circulo(Puntos);
lambda = (c^2)/((d*L)^2);

%----------------------------------------------------------------
% 2) Calcular el valor del parámetro mediante la fórmula de inversión
%----------------------------------------------------------------
T = inline('-2*omega*(a*y-b*x)/(-2*omega*a*y+2*x*b*omega+L*y)');
t = zeros(1,n);
for i=2:n
    t(i) = T(L,a,b,parametro,puntos(1,i),puntos(2,i));
end

%---------------------------------------------------------------
% 3) Pasemos a calcular el valor de la integral de la curvatura al
% cuadrado.
%---------------------------------------------------------------

% Fórmula de la curvaura
K = inline('(1/2)*b*omega*L*(-1+2*t-2*t^2-2*t*omega+2*t^2*omega)^3/(omega^2*(a^2+b^2)+2*omega*(-2*a^2*omega-2*omega*b^2+L*a)*t+(-6*a*omega*L+4*b^2*omega^2+L^2+2*a*omega^2*L+4*a^2*omega^2)*t^2+2*L*(-1+omega)*(-2*a*omega+L)*t^3+L^2*(-1+omega)^2*t^4)^(3/2)');

% Polinomio de grado 4 "d4t"
d4 = inline('omega^2*(a^2+b^2)+2*omega*(-2*omega*b^2-2*a^2*omega+L*a)*t+(4*b^2*omega^2-6*a*omega*L+L^2+2*a*omega^2*L+4*a^2*omega^2)*t^2+2*L*(-1+omega)*(-2*a*omega+L)*t^3+L^2*(-1+omega)^2*t^4');
% Denominador
D = inline('-1+2*t-2*t^2-2*t*omega+2*t^2*omega');

I = 0;
for i=1:n-1
    m = (t(i)+t(i+1))/2;
    k = K(L,a,b,parametro,m);
    k = k^2;
    dn = d4(L,a,b,parametro,m);
    dn = sqrt(dn);
    dd = D(parametro,m);
    dd = dd^2;
    I = I + (2*(k + lambda)*dn*(abs(t(i+1)-t(i))))/dd;
end