function DrawResult(NODES,MEMBERS,d,NSegs)
NMBs = size(MEMBERS,1);
for i=1:NMBs
    NID = MEMBERS(i,1:2);
    XY = NODES(NID,:);
    u = zeros(4,1);
    u(1:2,1) = d(2*NID(1)-1:2*NID(1),1);
    u(3:4,1) = d(2*NID(2)-1:2*NID(2),1);
    DrawMember(XY,u,NSegs);
end;