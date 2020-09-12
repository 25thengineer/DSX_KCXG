DAG = NULL;
for exp in blocks:
	1. If node (b) is not defined, a leaf node marked b is constructed and node (b) is defined as this node;
	If the current quaternion is type 0, mark the value of node (b) as N and turn to 4.
	If the current quaternion is type 1, turn to 2. (1).
	If the current quaternion is type 2, then: (I) if node (c) has no definition, then construct a leaf node marked as C and define node (c) as this node, (II) turn to 2. (2).
	2．
	(1) If node (b) is a leaf node marked as a constant, turn to 2. (3), otherwise turn to 3. (1).
	(2) If node (b) and node (c) are leaf nodes marked as constants, turn to 2. (4), otherwise turn to 3. (2).
	(3) Execute OP B (i.e. merge known quantities) and make the new constant P. If node (b) is a newly constructed node when processing the current quaternion, delete it. If node (P) is undefined, a leaf node n marked with P is constructed. Set node (P) = n and turn to 4.
	(4) Execute B OP C (i.e. merge known quantities) so that the new constant obtained is p. If node (b) or node (c) is a newly constructed node when processing the current quaternion, delete it. If node (P) is undefined, a leaf node n marked with P is constructed. Set node (P) = n and turn to 4.
	3．
	(1) Check whether there is a node in DAG whose unique successor is node (b) and marked as op (i.e. find common subexpression). If not, the node n is constructed. Otherwise, the existing node is regarded as its node and the node is set as N, then turn to 4.
	(2) Check whether there is a node in DAG, whose left successor is node (b), right successor is node (c), and marked as op (that is to find common subexpression). If not, the node n is constructed, otherwise the existing node is regarded as its node and the node is set as n. Turn to 4.
	4．
	If node (a) has no definition, a is attached to node n and node (a) = n; otherwise, a is deleted from the set of additional identifiers on node (a) (note that if node (a) is a leaf node, its mark a is not deleted), and a is attached to the new node n and node (a) = n. Turn to the next quaternion.
endfor
return DAG