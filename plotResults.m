function plotResults(varargin)
% this function generate latex table for output errors in specified folder
folder='';
savePlot=false;
solution=0;
isPD = false;
isTZ = false;

plotGrid=false;
plotDiv=false;
plotCurl=false;

%figure options:
figProperty.FS=20; %fontsize
figProperty.LW=2;  %lineWidth
figProperty.MS=10;  %markersize
figProperty.VW=2;  % view (2 or 3)
figProperty.SD='interp';%'faceted';  % shading
figProperty.CT=true;  % plot contour line or not
figProperty.CZ=1;  % contour line z value
figProperty.NL=10;  % number of contour lines



for i=1:nargin
    line = varargin{i};
    if(strncmp(line,'-f=',3))
        folder = line(4:end);
    end
    if(strcmp(line,'-pd'))
        isPD=true;
    end
    if(strcmp(line,'-tz'))
        isTZ=true;
    end  
    if(strcmp(line,'-save'))
        savePlot=true;
    end
    if(strcmp(line,'-div'))
        plotDiv=true;
    end     
    if(strcmp(line,'-curl'))
        plotCurl=true;
    end  
    if(strcmp(line,'-grid'))
        plotGrid=true;
    end      
    if(strcmp(line,'-faceted'))
        figProperty.SD='faceted';
    end   
    if(strncmp(line,'-solution=',10))
        solution = sscanf(line,'-solution=%d');
    end    
    if(strncmp(line,'-nl=',4))
        figProperty.NL = sscanf(line,'-nl=%d');
    end     
    if(strncmp(line,'-view=',6))
        figProperty.VW = sscanf(line,'-view=%d');
        if(figProperty.VW~=2 & figProperty.VW~=3)
            figProperty.VW=2;
            fprintf('-view values can only be 2 and 3. Invalid input ignored, we use the default value 2.\n');
        end
    end      
    if(strncmp(line,'-contour=',9))
        ct = line(10:end);
        if(strcmp(ct,'off') || strcmp(ct,'false'))
          figProperty.CT=false; 
          fprintf('-contour is set to be off.\n');
        else
          figProperty.CT=true;
        end           
    end    
    
end
if strcmp(folder,'')
    fprintf('Provide the folder name that holds the data\n\n')
    fprintf('Usage:\nplotResults -f=folder_name -pd (for periodic data) -save(to save plots) -solution=<n>(to plot solution n) -view=<2/3> -contour=<on/off>\n')
    return
end

% read mesh
if(isPD)
  run(strcat(folder,'/DOFFile.m'));  
else
  T=readMesh(folder);
end

% check if data dimension matches
x=T.coordinates(:,1);
compName=sprintf('u%d',solution);
run(sprintf('%s/%sFile.m',folder,compName));
comp=eval(compName);
nc=length(comp);
nx=length(x);
if(nc~=nx)
    fprintf('Error: data size does not match with number of nodes.\n');
    fprintf('Error: If this is a periodic bc problem, make sure -pd flag is raised.\n');
    return
end

meshPlot=T;
if(isPD)
    meshPlot.elements=delaunay(T.coordinates(:,1:2));
end



if(plotGrid)
    figure
    component='grid';
    plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);
end

figure
component='u';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

figure
component='v';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

figure
component='p';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

if(plotDiv)
    figure
    component='div';
    plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);
end

if(plotCurl)
    figure
    component='curl';
    plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);
end

if(solution>0 && isTZ)
    
figure
component='erru';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

figure
component='errv';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

figure
component='errp';
plotComponent(folder,component,solution,meshPlot,figProperty,savePlot);

end

end