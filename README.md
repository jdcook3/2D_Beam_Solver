# 2D_Beam_Solver
Matlab Function to draw, analyze, and solve deflections of a 2D Beam.
UA CE 432 Project (Fall 2016)

Program Explained
%Add high-level overview

Called Functions
%Add overview of each called function

Data Input:
	NODES
		Column 1: 	X Coordinate
		Column 2: 	Y Coordinate
	MEMBERS
		Column 1: 	Node 1
		Column 2: 	Node 2
		Column 3: 	Material ID (row number for modulus of elasticity)
		Column 4: 	Section ID (row number for Area)
	MATERIALS
		Row 1:		Modulus of Elasticity (called in MEMBERS(:,3))
	SECTIONS
		Row 1:		Section Area
		Row 2:		Moment of Inertia 
	NLOADS
		Column 1:	Node ID that force is acting on
		Column 2:	Force (kips) in Y direction, Right is positive
		Column 3:	Moment (k-in), Counterclockwise is positive
	BOUNDS
		Column 1:	Node ID that for support
		Column 2:	Fixed in Y? (1 for yes, 0 for no)
		Column 3:	Fixed Rotation? (1 for yes, 0 for no)
	MLOADS
		Column 1:	Member ID
		Column 2:	Load Type
		Column 3:	Parameter 1
		Column 4:	Parameter 2
		Column 5:	Parameter 3
