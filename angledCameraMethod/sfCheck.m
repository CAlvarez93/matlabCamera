%% sfCheck
%   outputs what the skew factor is supposed to be
%   and what the percent error is between the
%   calculated sf and what it should be
function [ sf, pe ] = sfCheck(pix_height, obj_height, a, cam_height, skew_factor)

  sf = (obj_height - cam_height + a)/pix_height;
  pe = abs((sf - skew_factor)/sf);
  
end