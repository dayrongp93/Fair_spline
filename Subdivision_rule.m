function [] = Subdivision_rule(Puntos,parametro,iteraciones)
% Esta función genera puntos sobre una cónica y la grafica utilizando la Regla de
% Subdivisión planteada en la tesis de Rafael. Esta función trabaja
% utilizando tríos de puntos y un parámetro "w" asociado a cada trío.
% Tabién el usuario debe introducir la cantidad de iteraciones que desea
% que se ejecuten.

% Input:
% Puntos: matriz de puntos del triángulo. 

% Output:
% Gráfico de la curva interpolante.

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
hold on
% Grafiquemos la curva interpolante
plot(points(1,:),points(2,:),'r','LineWidth',3)
plot([Px(1,1) Px(1,2) Px(1,3)],[Py(1,1) Py(1,2) Py(1,3)],'-ko','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',10)
