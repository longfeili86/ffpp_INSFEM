close all
setupFigure

% mesh
figure
plotFPCdomain
hold on
cmd='plotMsh mesh/cilc.msh -save';
eval(cmd);
hold off

%this script generate plots for flow past a cylinder results
%resultsName='testFPC';
%resultsName='testFPCP2';
%resultsName='testFPCP4';
%resultsName='testFPCWABE';
%resultsName='testFPCWABEP2';
resultsName='testFPCWABEP4';

plotDragLiftDpForFPC;

% grid spacing for plotting
h=0.01;
x=0:h:2.2;
y=0:h:0.41;

[X,Y]=meshgrid(x,y);
solutionNumber=160; 


R=interpResultsOnCartitianMesh(X,Y,resultsName,solutionNumber);


tcurr=R.t0+solutionNumber*R.tplot;

cmd=sprintf('plotResults -f=%s -solution=%d -grid -curl -pd -fpc',resultsName,solutionNumber);
%eval(cmd);



figure



%streamline
ns=20;
ys=linspace(0.01,0.41,ns);
xs=0*ys+2.15;

x=linspace(0.05,2.15,30);
y=linspace(0.01,0.40,8);
[Xs,Ys]=meshgrid(x,y);
h=streamline(X,Y,R.u,R.v,Xs,Ys,[0.1,500]);
% plot FPC domain boundaries
hold on
plotFPCdomain;
hold off
axis off
print('-depsc2',sprintf('%sStreamline.eps',resultsName))



