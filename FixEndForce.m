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
    l1 = Para(1);
	l2 = Para(2);
	M = Para(3);
	FSb = -(6*M*l1*l2)/(L^3);
	FMb = ((M * l2)/(L^2))*(l2-2l1);
	FSe = (6*M*l1*l2)/(L^3);
	FMe = ((M * l1)/(L^2))*(l1-2l2);
    Qf = [FSb;FMb;FSe;FMe];
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
    %Assume w1=0. If not, stack with LoadType3
    l1 = Para(1);
    l2 = Para(2);
    w = Para(3);
    FSb = ((w((L-l1)^3))/(20*(L^3)))*((3*L+2*l1(1+(l2/L-l1)+((l2^2)/(L-(l1^2))))-((L2^3)/((L-L1)^2))*(2+(15*L-8*l2)/(L-l1))));
    FMb = (w((L-l1)^3)/(60*(L^2)))*((2*L+3*l1)*(1+(l2/(L-l1))+((l2^2)/((L-l1)^2)))-((3*(l2^3)/((L-l1)^2))*(1+((5*L-4*l2)/(L-l1)))));
    FSe = (w)*(L-l1-l2)-FSb;
    FMe = ((L-l1-l2)/6)*(-w(L-l1+2*l2))+FSb*L-FMb;
    Qf = [FSb;FMb;FSe;FMe];
elseif LoadType==5
    l1 = Para(1);
    l2 = Para(2);
    W = Para(3);
    FAb = (W*l2)/L;
    FAe = (W*l1)/L;
    Qf = [FAb;FAe];
elseif LoadType==6
    l1 = Para(1);
    l2 = Para(2);
    w = Para(3);
    FAb = (w/2*L)*(L-l1-l2)*(L-l1+l2);
    FAe = (w/2*L)*(L-l1-l2)*(L-l1+l2);
    Qf = [FAb;FAe];
elseif LoadType==7
    l1 = Para(1);
    l2 = Para(2);
    MT = Para(3);
    FTb = (MT * l2)/(L);
    FTe = (MT * l1)/(L);
    Qf = [FTb;Fte];
end;