function mySurf(Xplot,Yplot,Zplot,titleMessage,contour)
% surf results with my figOptions
% -- Longfei Li

if(nargin==4) %optional input
    contour=false;
end
if(nargin==3) %optional input
    contour=false;
    titleMessage='untitled';
end




infoPrefix = '--mySurf--: '; % all info displayed by this function includes this prefix

useColormapRainbow; % use rainbow colormap
setupFigure; % setup figure options, linewidth,fontsize ect.

surf(Xplot,Yplot,Zplot);
shading(figOptions.SD);
if(figOptions.CT)
    hold on
    [~,hh]=contour3(Xplot,Yplot,Zplot,figOptions.NL,'k','LineWidth',figOptions.LW);
%  Longfei 10092018: old way of changing lineWidth and Color of contour lines    
%     for i=1:numel(hh)
%         set(hh(i),'EdgeColor','k','LineWidth',figOptions.LW);
%     end
%     hold off
end   
xlabel('x','FontSize',figOptions.FS);
ylabel('y','FontSize',figOptions.FS)
title(titleMessage,'FontSize',figOptions.FS,'Interpreter','Latex');
if(contour)
    view(2)
    colorbar
else
    view(3)
end
set(gca,'FontSize',figOptions.FS);


end