function plotComponent(folder,component,solution,mesh,property,savePlot)
% this function plots the component at solution number
% Input:
%   folder: name of results folder
%   component: 'u','v','p','erru','errv','errp','grid'
%   solution: solution number
%   mesh: triangulation with 2 fields mesh.elements and mesh.coordinates
%   property: property for figure, fontsize ect. 
%   savePlot: flag for print plot to eps file
if(nargin<6)
    savePlot=false;
end

%options:
FS=property.FS; %fontsize
LW=property.LW;  %lineWidth
MS=property.MS;  %markersize
VW=property.VW;  %view (2 or 3)
SD=property.SD;  % shading option
CT=property.CT;  % plot contour line or not
CZ=property.CZ;  % contour z value
NL=property.NL;  % number of contour lines

isFPC=property.isFPC;
useColormapRainbow;

x=mesh.coordinates(:,1);
y=mesh.coordinates(:,2);
tri=mesh.elements(:,1:3);

if(strcmp(component,'grid'))
  trimesh(tri,x,y,'k','LineWidth',LW);
  ttl='grid';
else
    compName=sprintf('%s%d',component,solution);
    run(strcat(folder,sprintf('/%sFile.m',compName)));
    comp=eval(compName);
    trisurf(tri, x,y,comp);
    shading(SD);
    zlim([min(comp),max(comp)]);

    if(CT)
        hold on
        [~,hh]=tricontour3(tri, x,y,comp,NL);
        for i=1:numel(hh)
            set(hh(i),'EdgeColor','k','LineWidth',LW)
        end
        hold off
    end
    
    % get the time of the plot
    run(strcat(folder,'/timeInfoFile.m'));
    %timeInfo=[t0,dt,tplot,tf]
    t0=timeInfo(1);
    tplot=timeInfo(3);
    tcurr=t0+solution*tplot;   
    
    if(strcmp(component(1)','e'))
        ttl=sprintf('$E(%c)$ at $t=%.2f$',component(end),tcurr);
    else
        ttl=sprintf('$%s$ at $t=%.2f$',component,tcurr);
    end
    
    view(VW);
    colorbar;
end

if(isFPC)
    hold on
    plotFPCdomain
    hold off
end


axis equal;

xlim([min(x),max(x)]);
ylim([min(y),max(y)]);

title(ttl,'FontSize',FS,'interpreter','latex');
xlabel('$x$','FontSize',FS,'interpreter','latex');
ylabel('$y$','FontSize',FS,'interpreter','latex');
set(gca,'FontSize',FS);
box on

%set(gcf,'renderer','opengl');
%set(gcf,'renderer','painters');
if(savePlot)
    figureName=sprintf('%s_%s%d.eps',folder,component,solution);
    fprintf('plot saved as: %s\n',figureName);
    print('-opengl','-depsc2',figureName);
end


end