function [puntos,points,L,a,b] = Subdivision_rule_1(Puntos,parametro,iteraciones)
% Esta función genera puntos sobre una cónica y la grafica utilizando la Regla de
% Subdivisión planteada en la tesis de Rafael. Esta función trabaja
% utilizando tríos de puntos y un parámetro "w" asociado a cada trío.
% Tabién el usuario debe introducir la cantidad de iteraciones que desea
% que se ejecuten.

% Input:
% Puntos: matriz de puntos del triángulo. 

% Output:
% Gráfico de la curva interpolante. 
% Puntos sobre la gráfica.

w = zeros(1,iteraciones + 1);
w(1) = parametro;
Px = zeros(iteraciones+1,3+2*(2^(iteraciones)-1));
Px(1,:) = [Puntos(:,1)' zeros(1,2*(2^(iteraciones)-1))];
Py = zeros(iteraciones+1,3+2*(2^(iteraciones)-1));
Py(1,:) = [Puntos(:,2)' zeros(1,2*(2^(iteraciones)-1))];

for n = 1:iteraciones
    l = 3+2*(2^(n)-1);
    for j = 2:(n+1)
        w(j) = sqrt((1+w(j-1))/2);
        % Para los de indice par
        % Hay que diferenciarlo en los casos cuando es múltiplo de 4 o no
        for i = 1:2^(j-1)
            % Cuando no es múltiplo de 4
            if round(i/2)~=i/2
                Px(j,2*i) = (Px(j-1,i)+w(j-1)*Px(j-1,i+1))/(1+w(j-1));
                Py(j,2*i) = (Py(j-1,i)+w(j-1)*Py(j-1,i+1))/(1+w(j-1));
            else
            % Cuando es múltiplo de 4
                Px(j,2*i) = (w(j-1)*Px(j-1,i)+Px(j-1,i+1))/(1+w(j-1));
                Py(j,2*i) = (w(j-1)*Py(j-1,i)+Py(j-1,i+1))/(1+w(j-1));
            end
        end
    end
    for j = 2:iteraciones+1
        w(j) = sqrt((1+w(j-1))/2);
        % Para los de indice impar
        Px(j,1) = Px(j-1,1);
        Px(j,l) = Px(j-1,3+2*(2^(n-1)-1));
        Py(j,1) = Py(j-1,1);
        Py(j,l) = Py(j-1,3+2*(2^(n-1)-1));
        for i = 1:2^(j-1)-1
            Px(j,2*i+1) = (Px(j,2*i+2)+Px(j,2*i))/2;
            Py(j,2*i+1) = (Py(j,2*i+2)+Py(j,2*i))/2;
        end
    end
end

% Los puntos que tenemos que representar son los de indice impar.
m = 3+2*(2^(iteraciones-1)-1);
points = zeros(2,m);
for i = 1:m
    points(:,i)=[Px(iteraciones+1,2*i-1) Py(iteraciones+1,2*i-1)];
end
% % subplot(1,2,1)
% hold on
% % title('Curva interpolante')
% plot(points(1,:),points(2,:),'b','LineWidth',1)
% plot([Px(1,1) Px(1,2) Px(1,3)],[Py(1,1) Py(1,2) Py(1,3)],'--rs','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)
% hold off

% Trabajemos ahora en representar la curvatura de la cónica en cada punto
% que generamos sobre ella mediante este algoritmo de subdivisión.

% Primeramente escribamos las cordenadas de los tres puntos del triángulo
% en la forma más simple. Haciendo coincidir el eje de las abcisas con la
% recta que pasa por P_0 y P_2.

deno = sqrt((Puntos(3,1)-Puntos(1,1))^2+(Puntos(3,2)-Puntos(1,2))^2);
changex = @(x,y,x0,x2,y0,y2) ((x-x0)*(x2-x0)+(y-y0)*(y2-y0))/deno;
changey = @(x,y,x0,x2,y0,y2) ((y-y0)*(x2-x0)-(x-x0)*(y2-y0))/deno;
Normalpoints = zeros(size(Puntos));
puntos = zeros(2,m);
for i=1:size(Puntos,1)
    Normalpoints(i,1) = changex(Puntos(i,1),Puntos(i,2),Puntos(1,1),Puntos(3,1),Puntos(1,2),Puntos(3,2));
    Normalpoints(i,2) = changey(Puntos(i,1),Puntos(i,2),Puntos(1,1),Puntos(3,1),Puntos(1,2),Puntos(3,2));
end
% Una vez calculadas las coordenadas en la forma normal para introducirse
% en la fórmula.
L = Normalpoints(3,1);
a = Normalpoints(2,1);
b = abs(Normalpoints(2,2));
for i=1:m
    puntos(1,i) = changex(points(1,i),points(2,i),Puntos(1,1),Puntos(3,1),Puntos(1,2),Puntos(3,2));
    puntos(2,i) = abs(changey(points(1,i),points(2,i),Puntos(1,1),Puntos(3,1),Puntos(1,2),Puntos(3,2)));
end
% subplot(1,2,2)
% plot(t,curvatura)
% title('Gráfica de la curvatuta')
% xlabel('t')
% ylabel('Curvatura')