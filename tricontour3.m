function [c,h]=tricontour3(tri,x,y,z,nv)
%Longfei 20160909: plot contour lines in 3d for triangular mesh

% [C,H] = TRICONTOUR(...) returns contour matrix C as described in CONTOURC
% and a vector of handles H to the created patch objects.
% H can be used to set patch properties.
% CLABEL(C) or CLABEL(C,H) labels the contour levels.


if nargin<5
	error('Not Enough Input Arguments.')
end
x=x(:);	% convert input data into column vectors
y=y(:);
z=z(:);

%plot contour line
[c,h]=tricontour(tri,x,y,z,nv);

% change the contour line z values to match the function z value
hold on;
F = scatteredInterpolant(x,y,z);
for i=1:numel(h)
    xdata=get(h(i),'XData');
    ydata=get(h(i),'YData');
    zdata = F(xdata,ydata);
    set(h(i), 'ZData',zdata);
end
hold off;


end