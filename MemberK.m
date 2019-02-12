function K = MemberK(XY,E,I)
L = sqrt((XY(2,1)-XY(1,1))^2+(XY(2,2)-XY(1,2))^2);
EI12 = 12*E*I/L^3;
EI6 = 6*E*I/L^2;
EI4 = 4*E*I/L;
EI2 = 2*E*I/L;
K = [EI12,EI6,-EI12,EI6;EI6,EI4,-EI6,EI2;-EI12,-EI6,EI12,-EI6;EI6,EI2,-EI6,EI4];