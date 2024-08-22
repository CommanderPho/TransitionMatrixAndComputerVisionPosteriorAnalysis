% NEEDLEPLOTGRAD - needleplot of 3D surface from gradient data
%
% Usage:  needleplotgrad(dzdx, dzdy, len, spacing)
%
%        dzdx, dzdy  - 2D arrays of gradient with respect to x and y.
%        len         - length of needle to be plotted.
%        spacing     - sub-sampling interval to be used in the
%                      gradient data. (Plotting every point
%                      is typically not feasible).

% Peter Kovesi  
% www.peterkovesi.com
%
% July 2003

function needleplotgrad(dzdx, dzdy, len, spacing)

  [slant, tilt] = grad2slanttilt(dzdx, dzdy);
  needleplotst(slant, tilt, len, spacing);
