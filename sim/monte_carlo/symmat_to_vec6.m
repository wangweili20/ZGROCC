function v = symmat_to_vec6(P)
%SYMMAT_TO_VEC6  Map 2x2 symmetric P to 6-dim critic weight (includes omega terms).
v = [P(1,1); P(1,2); P(2,2); 0; 0; 0];
end
