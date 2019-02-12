function DrawMember(XY,u,NSegs)
% MID = 2;
% NID = MEMBERS(MID,1:2);
% XY = NODES(NID,:);
% u = zeros(4,1);
% u(1:2,1) = d(2*NID(1)-1:2*NID(1),1);
% u(3:4,1) = d(2*NID(2)-1:2*NID(2),1);
% NSegs = 10;
X = zeros(NSegs+1,1);
Y = zeros(NSegs+1,1);
dX = (XY(2,1)-XY(1,1))/NSegs;
dY = (XY(2,2)-XY(1,2))/NSegs;
for i=1:(NSegs+1)
    X(i) = (i-1)*dX;
    Y(i) = (i-1)*dY;
end;
L = sqrt((XY(2,1)-XY(1,1))^2+(XY(2,2)-XY(1,2))^2);
N1 = 2*X.^3/L^3-3*X.^2/L^2+1;
N2 = X.*(1-X/L).^2;
N3 = 3*(X/L).^2-2*(X/L).^3;
N4 = (X.^2/L).*(-1+X/L);
v = N1*u(1)+N2*u(2)+N3*u(3)+N4*u(4);
Yd = Y+v;
Xd = XY(1,1)+X;
line(Xd,Yd);