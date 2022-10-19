function [val] = dcurvatura_functional(Puntos,parametro,iteraciones)
% Esta función calcula la integral de la derivada respecto al parámetro
% "omega" de la expresión del funcional. Para calcular la derivada de la
% función integral y hallar donde se anula. 

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

%----------------------------------------------------------------
% 2) Calcular el valor del parámetro mediante la fórmula de inversión
%----------------------------------------------------------------
T = inline('-2*omega*(a*y-b*x)/(-2*omega*a*y+2*x*b*omega+L*y)');
t = zeros(1,n);
for i=2:n
    t(i) = T(L,a,b,parametro,puntos(1,i),puntos(2,i));
end

% ---------------------------------------------------------------
% 3) Pasemos a calcular el valor de la integral
% ---------------------------------------------------------------

[c,d] = circulo(Puntos);
lambda = (c^2)/((d*L)^2);

% Derivada de la curvatura al cuadrado respecto a omega
pdB = inline('(1/2)*b^2*omega*L^2*(-1+2*t-2*t^2-2*t*omega+2*t^2*omega)^3*(-2*t*omega^3*a^2-32*L^2*t^5*omega-10*L*t^4*a*omega+4*t^5*L*a*omega-34*t^4*omega^2*L*a+4*t^5*omega^2*L*a+12*t^4*omega^3*L*a-8*t^5*omega^3*L*a-4*L*t^3*a*omega^3+t*omega*L*a-5*t^2*a*omega*L-8*t^2*a*omega^2*L+10*L*t^3*a*omega+32*L*t^3*a*omega^2-18*t*omega^2*a^2-8*t^6*omega^2*L^2+24*t^4*omega^2*a^2-18*t*omega^2*b^2+10*t^6*L^2*omega-11*L^2*t^3*omega-11*L^2*t^4*omega^2+24*t^4*omega^2*b^2+42*t^2*a^2*omega^2+33*L^2*t^4*omega-48*t^3*omega^2*a^2+22*t^5*omega^2*L^2+10*t^2*a^2*omega^3-2*t*omega^3*b^2-48*t^3*omega^2*b^2-16*t^3*omega^3*b^2-16*t^3*omega^3*a^2-2*t^5*omega^3*L^2+8*t^4*omega^3*b^2+8*t^4*omega^3*a^2+2*t^6*omega^3*L^2+10*t^2*b^2*omega^3+42*t^2*b^2*omega^2-14*L^2*t^4+8*L^2*t^3-2*t^2*L^2+12*L^2*t^5+3*b^2*omega^2+3*a^2*omega^2-4*t^6*L^2)/(a^2*omega^2+b^2*omega^2-4*t*omega^2*a^2-4*t*omega^2*b^2+2*t*omega*L*a-6*t^2*a*omega*L+4*t^2*b^2*omega^2+t^2*L^2+2*t^2*a*omega^2*L+4*t^2*a^2*omega^2+4*L*t^3*a*omega-2*L^2*t^3-4*L*t^3*a*omega^2+2*L^2*t^3*omega+L^2*t^4-2*L^2*t^4*omega+L^2*t^4*omega^2)^(7/2)');

% Derivada de la longitud de arco respecto a omaga
pds = inline('-(2*(10*t^2*a^2*omega^2+9*L^2*t^4-2*t*omega^2*a^2+10*t^2*b^2*omega^2-2*t*omega^2*b^2-5*L^2*t^4*omega-3*L^2*t^3-6*t*a^2*omega-6*t*omega*b^2+t*L*a-5*t^2*L*a+14*t^2*omega*b^2+14*t^2*a^2*omega+10*L*a*t^3-18*L*t^4*a*omega+4*t^5*L*a*omega+12*t^4*omega^2*L*a-8*t^5*omega^2*L*a-8*L^2*t^5+2*t^6*L^2-16*t^3*omega*b^2-16*t^3*a^2*omega-10*L*a*t^4+10*L^2*t^5*omega+8*t^4*omega*b^2+8*t^4*a^2*omega+4*t^5*L*a-4*t^6*L^2*omega-16*t^3*omega^2*b^2-16*t^3*omega^2*a^2-2*t^5*omega^2*L^2+8*t^4*omega^2*b^2+8*t^4*omega^2*a^2+2*t^6*omega^2*L^2+a^2*omega+omega*b^2-4*t^2*a*omega*L+16*L*t^3*a*omega-4*L*t^3*a*omega^2))/(sqrt(a^2*omega^2+b^2*omega^2-4*t*omega^2*a^2-4*t*omega^2*b^2+2*t*omega*L*a-6*t^2*a*omega*L+4*t^2*b^2*omega^2+t^2*L^2+2*t^2*a*omega^2*L+4*t^2*a^2*omega^2+4*L*t^3*a*omega-2*L^2*t^3-4*L*t^3*a*omega^2+2*L^2*t^3*omega+L^2*t^4-2*L^2*t^4*omega+L^2*t^4*omega^2)*(-1+2*t-2*t^2-2*t*omega+2*t^2*omega)^3)');

val = 0;
for i=1:n-1
    m = (t(i)+t(i+1))/2;
    I1 = pdB(L,a,b,parametro,m)*(abs(t(i+1)-t(i)));
    I2 = pds(L,a,b,parametro,m)*(abs(t(i+1)-t(i)));
    val = val + I1 + lambda*I2;
end