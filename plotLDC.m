close all
%this script generate plots for lid-driven cavity results

%resultsName='testLDCSWABEtretched64x64';
resultsName='testLDCStretched64x64';
%resultsName='testMLDCStretched64x64';
%resultsName='testMLDCWABEStretched64x64';

solutionNumber=1000;



Np=101; % number of grids for plotting
Ic=ceil(Np/2); % index of the center grid

[X,Y]=meshgrid(linspace(0,1,Np),linspace(0,1,Np));
fprintf('center point: (%f,%f)\n',X(Ic,Ic),Y(Ic,Ic));


R=interpResultsOnCartitianMesh(X,Y,resultsName,solutionNumber);

tcurr=R.t0+solutionNumber*R.tplot;


cmd=sprintf('plotResults -f=%s -solution=%d -grid -curl',resultsName,solutionNumber);
eval(cmd);

setupFigure

figure
[C,h]=contour(X,Y,R.curl,[-5, -4, -3, -2, -1, -0.5, 0, 0.5, 1, 2, 3],'LineWidth',figOptions.LW,'ShowText','on');
clabel(C,h,'FontSize',figOptions.FS)
colormap jet
title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);


figure
[C,h]=contour(X,Y,R.p-R.p(Ic,Ic),[0.3, 0.17, 0.12, 0.11, 0.09, 0.07, 0.05, 0.02, 0, -0.002],'LineWidth',figOptions.LW,'ShowText','on');
clabel(C,h,'FontSize',figOptions.FS)
colormap jet
title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);


figure

% reference data from GHIA et al. 1982 JCP
giahRe1000.x=[1.,0.9688,0.9609,0.9531,0.9453,0.9063,0.8594,0.8047,...
    0.5000,0.2344,0.2266,0.1563,0.0938,0.0781,0.0703,0.0625,0.0000];
giahRe1000.y=[1.,0.9766,0.9688,0.9609,0.9531,0.8516,0.7344,0.6172,...
    0.5,0.4531,0.2813,0.1719,0.1016,0.0703,0.0625,0.0547,0];
giahRe1000.u=[1,0.65928,0.57492,0.51117,0.46604,0.33304,0.18719,0.05702,...
    -0.06080,-0.10648,-0.27805,-0.38289,-0.29730,-0.22220,-0.20196,-0.18109,0];
giahRe1000.v=[0,-0.21388,-0.27669,-0.33714,-0.39188,-0.51550,-0.42665,-0.31996,...
    0.02526,0.32235,0.33075,0.37095,0.32627,0.30353,0.29012,0.27485,0];

hold on
plot(Y(:,Ic),R.u(:,Ic),'b','LineWidth',figOptions.LW);
plot(giahRe1000.y,giahRe1000.u,'bo','MarkerSize',figOptions.MS);
plot(X(Ic,:),R.v(Ic,:),'r','LineWidth',figOptions.LW);
plot(giahRe1000.x,giahRe1000.v,'ro','MarkerSize',figOptions.MS);
legend('u(0.5,y)','u(0.5,y) (Giah{\it et al.})', 'v(x,0.5)','v(x,0.5) (Giah{\it et al.})','Location','North')

title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);

set(gca,'FontSize',figOptions.FS);

figure
x=linspace(0,1,11);
xx=(cos((1-x)*pi)+1)/2.; % stretch nodes
[xStart,yStart]=meshgrid(xx,xx);
h=streamline(X,Y,R.u,R.v,[xStart(:);0.01;0.07;0.5;0.9],[yStart(:);0.01;0.07;0.55;0.15]);
title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);
set(gca,'FontSize',figOptions.FS);

% ind = zeros(size(h));
% for k = 1:length(h); % essentially, for each stream line.
%     xk = get(h(k),'xdata'); % get its x data
%     if (min(xk)<=0.5 & max(xk)>=0.9) 
%         ind(k)=1; 
%     end    
% end
% % set qualifying streamlines to red.
% set(h(logical(ind)),'color','red');
% delete(h(~logical(ind)));
% 



