function [P2,t1,t3] = BTP(P1,P3,v1,v3)

% Input: 
% P1,P3 - puntos del triángulo
% v1,v3 - vectores directores en los puntos P1 y P3

% Output:
% P2 - tercer punto del triángulo con vertices P1 y P3 con
% vectores v1 y v3 en los respectivos puntos anteriores.

if v3(1)==0 && v1(1)==0
    % Los vectores son colineales
    P2=0;
    t1=0;
    t3=0;
elseif v3(2)/v3(1)==v1(2)/v1(1)
    % Los vectores son colineales
    P2=0;
    t1=0;
    t3=0;
else
    P2=zeros(1,2);
    
    t3=(v1(1)*(P1(2)-P3(2))-v1(2)*(P1(1)-P3(1)))/(v1(1)*v3(2)-v1(2)*v3(1));
    t1=(v3(2)*(P1(1)-P3(1))-v3(1)*(P1(2)-P3(2)))/(-v1(1)*v3(2)+v1(2)*v3(1));
    
    P2(1)=P1(1)+t1*v1(1);
    P2(2)=P1(2)+t1*v1(2);
   
end
