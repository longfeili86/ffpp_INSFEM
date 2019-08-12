close all
%this script generate plots for lid-driven cavity results

%resultsName='testLDCSWABEtretched64x64';
%resultsName='testLDCStretched64x64';
%resultsName='testMLDCStretched64x64';
resultsName='testMLDCWABEStretched64x64';

solutionNumber=1000;



Np=101; % number of grids for plotting
Ic=ceil(Np/2); % index of the center grid

x=linspace(0,1,Np); x=(cos((1-x)*pi)+1)/2; %x=x-x.*(x-0.5).*(x-1);
y=linspace(0,1,Np); y=(cos((1-y)*pi)+1)/2; %y=y-y.*(y-0.5).*(y-1);
[X,Y]=meshgrid(x,y);
fprintf('center point: (%f,%f)\n',X(Ic,Ic),Y(Ic,Ic));


R=interpResultsOnCartitianMesh(X,Y,resultsName,solutionNumber);

tcurr=R.t0+solutionNumber*R.tplot;


cmd=sprintf('plotResults -f=%s -solution=%d -grid -curl',resultsName,solutionNumber);
%eval(cmd);

setupFigure

% mesh
figure
cmd='plotMsh mesh/squareStretched32x32.msh -save';
eval(cmd);

% contour vorticity
figure
[C,h]=contour(X,Y,R.curl,[-5, -4, -3, -2, -1, -0.5, 0, 0.5, 1, 2, 3],'LineWidth',figOptions.LW,'ShowText','on');
clabel(C,h,'FontSize',figOptions.FS)
axis([0,1,0,1]);
axis equal
%title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);
set(gca,'FontSize',figOptions.FS);
print('-depsc2',sprintf('%sCurlContour.eps',resultsName));

% contour pressure
figure
[C,h]=contour(X,Y,R.p-R.p(Ic,Ic),[0.3, 0.17, 0.12, 0.11, 0.09, 0.07, 0.05, 0.02, 0, -0.002],'LineWidth',figOptions.LW,'ShowText','on');
clabel(C,h,'FontSize',figOptions.FS)
axis([0,1,0,1]);
axis equal

%title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);
set(gca,'FontSize',figOptions.FS);
print('-depsc2',sprintf('%sPressureContour.eps',resultsName));

% plot comparison with Ghia et al. 1982
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
box on;

legend('u(0.5,y)','u(0.5,y) (Giah et al.)', 'v(x,0.5)','v(x,0.5) (Giah et al.)','Location','North')
%title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);
set(gca,'FontSize',figOptions.FS);
print('-depsc2',sprintf('%sComparisonWithGHIA.eps',resultsName));


figure

ysmd=linspace(.99,0.56,10);
xsmd=0*ysmd+0.56;
ns=[3200,2380,1980,1600,1250,920,610,325,205,30];
xslc=[0.05,0.1,0.1,0.05];
yslc=[0.09,0.05,0.0001,0.05,];
xsrc=[ 0.9,  0.9,0.9, 0.01,0.99,0.9999];
ysrc=[ 0.05, 0.1,0.21,0.01,0.01,0.8];
xs=[xsmd,xslc,xsrc];
ys=[ysmd,yslc,ysrc];
ns=[ns,152, 300, 350, 550,290,300,3800];
n=length(xs);
fprintf('n=%d\n',n);
% tic;
%  for i=1:n
%  h=streamline(X,Y,R.u,R.v,xs,ys,[0.1,ns(i)]);
%  set(h,'color','k','LineWidth',figOptions.LW);
%  end
%  toc;
myStreamline(X,Y,R.u,R.v,xs,ys);
axis equal
axis([0,1,0,1]);    
set(gca,'FontSize',figOptions.FS);
box on;
  
print('-depsc2',sprintf('%sStreamline.eps',resultsName));

%  title(sprintf('t=%f',tcurr),'FontSize',figOptions.FS);
%  set(gca,'FontSize',figOptions.FS);

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

% figure
% nm=sqrt(R.u.^2+R.v.^2);
% u=R.u./nm;
% v=R.v./nm;
% quiver(X(1:5:end),Y(1:5:end),u(1:5:end),v(1:5:end))
% axis([0,1,0,1])





