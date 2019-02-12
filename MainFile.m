clear;
clc;
load Inputs\NODES -ASCII;
load Inputs\MEMBERS -ASCII;
load Inputs\MATERIALS -ASCII;
load Inputs\SECTIONS -ASCII;
load Inputs\MLOADS -ASCII;
load Inputs\NLOADS -ASCII;
load Inputs\BOUNDS -ASCII;
NOM = size(MEMBERS,1);
NON = size(NODES,1);
K = zeros(2*NON,2*NON);
for i=1:NOM
    NID = MEMBERS(i,1:2);%Nodal IDs
    MID = MEMBERS(i,3);%Material ID
    SID = MEMBERS(i,4);%Section ID
    XY = NODES(NID,:);%Nodal coordinates
    E = MATERIALS(MID,1);%Elasticity
    I = SECTIONS(SID,2);%Moment of inertial
    Ke = MemberK(XY,E,I);%Member stiffness matrix
    for j=1:2
        for l=1:2
            K(2*NID(j)-1:2*NID(j),2*NID(l)-1:2*NID(l))=K(2*NID(j)-1:2*NID(j),2*NID(l)-1:2*NID(l))+...
                Ke(2*j-1:2*j,2*l-1:2*l);
        end;
    end;
end;
NMBLs = size(MLOADS,1);
Pf = zeros(2*NON,1);
Qfs = zeros(NMBLs,4);%Save fixed-end force vector for each member that has member load
for i=1:NMBLs
    MID = MLOADS(i,1);
    NID = MEMBERS(MID,1:2);
    XY = NODES(NID,:);
    LoadType = MLOADS(i,2);
    Para = MLOADS(i,3:5);
    Qf = FixEndForce(XY,LoadType,Para);
    Qfs(i,:) = Qf';
    Pf(2*NID(1)-1:2*NID(1),1) = Pf(2*NID(1)-1:2*NID(1),1)+Qf(1:2,1);
    Pf(2*NID(2)-1:2*NID(2),1) = Pf(2*NID(2)-1:2*NID(2),1)+Qf(3:4,1);
end;
%-----Calculate Nodal Force Vector--------------
NNL = size(NLOADS,1);%number of nodal loads
P = zeros(2*NON,1);
for i=1:NNL
    NID = NLOADS(i,1);%nodal number
    Fy = NLOADS(i,2);
    Mz = NLOADS(i,3)*12;
    P(2*NID-1,1) = P(2*NID-1,1)+ Fy;
    P(2*NID,1)   = P(2*NID,1)+ Mz;
end;
%Calculate Total Force vector
Pt = P-Pf;
%------Assign Boundary Conditions--------------
NOB = size(BOUNDS,1);%Number of Nodal boundary conditions
for i=1:NOB
    NID = BOUNDS(i,1);%Nodal ID
    FixUy = BOUNDS(i,2);%Fixed in Y displacement or not?
    FixRT = BOUNDS(i,3);%Fixed in Rotation or not?
    if FixUy==1
        K(2*NID-1,:)=0;
        K(2*NID-1,2*NID-1)=1;
        Pt(2*NID-1,1) = 0;
    end;
    if FixRT ==1
        K(2*NID,:)=0;
        K(2*NID,2*NID)=1;
        Pt(2*NID,1) = 0;
    end;
end;
%-----Solve for displacement---------------------
d = K\Pt;
DrawResult(NODES,MEMBERS,d,20);
axis([0,420,-0.5,0.5]);
%-----Calculate the member force-----------------
Qe = zeros(NOM,4);
for i=1:NOM
    NID = MEMBERS(i,1:2);%Nodal IDs
    MID = MEMBERS(i,3);%Material ID
    SID = MEMBERS(i,4);%Section ID
    XY = NODES(NID,:);%Nodal coordinates
    E = MATERIALS(MID,1);%Elasticity
    I = SECTIONS(SID,2);%Moment of inertial
    Ke = MemberK(XY,E,I);%Member stiffness matrix
    u = zeros(4,1);
    u(1:2,1) = d(2*NID(1)-1:2*NID(1),1);
    u(3:4,1) = d(2*NID(2)-1:2*NID(2),1);
    Qe(i,:) = (Ke*u)';
end;
for i=1:NMBLs
    MID = MLOADS(i,1);
    Qe(MID,:) = Qe(MID,:)+Qfs(i,:);
end;
%------------------------------------------------
%DrawBeam(NODES,MEMBERS,'k',2);