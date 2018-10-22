close all
%this script generate plots for flow past a cylinder results
resultsName='testFPC';
%resultsName='testFPCWABE';

% grid spacing for plotting
h=0.01;
x=0:h:2.2;
y=0:h:0.41;

[X,Y]=meshgrid(x,y);
solutionNumber=37; 


R=interpResultsOnCartitianMesh(X,Y,resultsName,solutionNumber);


tcurr=R.t0+solutionNumber*R.tplot;

cmd=sprintf('plotResults -f=%s -solution=%d -grid -curl -fpc',resultsName,solutionNumber);
eval(cmd);

setupFigure


figure

% plot FPC domain boundaries
plotFPCdomain;
hold on
axis equal
%xlim([min(x),max(x)]);
%ylim([min(y),max(y)]);
d=4;
%quiver(X(1:d:end,1:d:end),Y(1:d:end,1:d:end),R.u(1:d:end,1:d:end),R.v(1:d:end,1:d:end),2,'k','LineWidth',1)
axis equal
hold off

%streamline
ns=20;
ys=linspace(0.01,0.41,ns);
xs=0*ys+2.15;

x=linspace(0.05,2.15,30);
y=linspace(0.01,0.40,8);
[Xs,Ys]=meshgrid(x,y);
h=streamline(X,Y,R.u,R.v,Xs,Ys,[0.1,500]);
tic;
%myStreamline(X,Y,R.u,R.v,Xs(:),Ys(:));
toc;
% print('-depsc2','aaaWABEmyStreamline.eps')



