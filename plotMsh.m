function plotMsh(filename,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function plot a mesh file in the msh format
% Input:
%   filename: filename of the msh file
% Output:
%   hh: handle of the mesh plot
%
% Longfei Li 10092018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


if(nargin==0)
    fprintf('Provide filename for the mesh\n\n');
    fprintf('Usage:\nplotMsh(filename) (optional: -save)\n');
    return
end

infoPrefix='---plotMsh--: ';    

savePlot=false;

for i=1:length(varargin)
    line = varargin{i};
    if(strcmp(line,'-save'))
        savePlot=true;
    end
end

setupFigure; % setup figure options, linewidth,fontsize ect.


T=readMsh(filename);
x=T.coordinates(:,1); 
y=T.coordinates(:,2);
tri=T.elements(:,1:3);

trimesh(tri,x,y,'k','LineWidth',figOptions.LW);
axis equal;

xlim([min(x),max(x)]);
ylim([min(y),max(y)]);

set(gca,'FontSize',figOptions.FS);

if(savePlot)
    figureName=strrep(filename,'.msh',''); % strip the extension   
    fprintf('%splot saved as eps file: filename=%s.eps\n',infoPrefix,figureName);
    print('-depsc2',figureName);
end

