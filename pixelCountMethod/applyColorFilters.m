function [ out_r, out_g, out_b ] = applyColorFilters( r, g, b, logic, color )
%applyColorFilters sets the color filter for the given rgb channels
% and the given value

  r(logic) = color;
  g(logic) = color;
  b(logic) = color;
    
  out_r = r;
  out_g = g;
  out_b = b;
end