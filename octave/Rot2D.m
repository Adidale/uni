function B = Rot2D (A, alpha)
  C = [cos(alpha) -sin(alpha); sin(alpha) cos(alpha)];
  B = C*A;
endfunction