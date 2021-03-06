function Qf = FixEndForce(XY,LoadType,Para)
L = sqrt((XY(2,1)-XY(1,1))^2+(XY(2,2)-XY(1,2))^2);
Qf = zeros(4,1);
if LoadType==1
    l1 = Para(1);
    l2 = Para(2);
    W  = Para(3);
    FSb = -W*l2^2*(3*l1+l2)/L^3;
    FMb = -W*l1*l2^2/L^2;
    FSe = -W*l1^2*(l1+3*l2)/L^3;
    FMe = W*l1^2*l2/L^2;
    Qf = [FSb;FMb;FSe;FMe];
elseif LoadType==2
elseif LoadType==3
    l1 = Para(1);
    l2 = Para(2);
    w  = Para(3);
    FSb = (-w*L/2)*(1-(l1/L^4)*(2*L^3-2*l1^2*L+l1^3)-(l2^3/L^4)*(2*L-l2));
    FMb = (-w*L^2/12)*(1-(l1^2/L^4)*(6*L^2-8*l1*L+3*l1^2)-(l2^3/L^4)*(4*L-3*l2));
    FSe = (-w*L/2)*(1-(l1^3/L^4)*(2*L-l1)-(l2/L^4)*(2*L^3-2*l2^2*L+l2^3));
    FMe = (w*L^2/12)*(1-(l1^3/L^4)*(4*L-3*l1)-(l2^2/L^4)*(6*L^2-8*l2*L+3*l2^2));
    Qf = [FSb;FMb;FSe;FMe];
elseif LoadType==4
elseif LoadType==5
elseif LoadType==6
elseif LoadType==7
end;