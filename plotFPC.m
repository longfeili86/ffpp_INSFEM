close all
%this script generate plots for flow past a cylinder results
%resultsName='testFPC';
resultsName='testFPCWABE';

% grid spacing for plotting
h=0.01;
x=0:h:2.2;
y=0:h:0.41;

[X,Y]=meshgrid(x,y);
solutionNumber=100; 



% dp=zeros(1,solutionNumber);
% t=zeros(1,solutionNumber);
% for ss=1:solutionNumber
%     R=interpResultsOnCartitianMesh(X,Y,resultsName,ss);
%     fprintf('dP=%f\n',R.Ip(0.15,0.2)-R.Ip(0.25,0.2));
%     dp(ss)=R.Ip(0.15,0.2)-R.Ip(0.25,0.2);
%     t(ss)=R.t0+ss*R.tplot;
% end
% plot(t,dp)



R=interpResultsOnCartitianMesh(X,Y,resultsName,solutionNumber);


tcurr=R.t0+solutionNumber*R.tplot;

cmd=sprintf('plotResults -f=%s -solution=%d -grid -curl',resultsName,solutionNumber);
%eval(cmd);

setupFigure


figure

% plot FPC domain boundaries
hold on
plot(x,0.*x,'k','LineWidth',figOptions.LW);
plot(x,0.*x+0.41,'k','LineWidth',figOptions.LW);
plot(0*y,y,'k','LineWidth',figOptions.LW);
plot(0*y+2.2,y,'k','LineWidth',figOptions.LW);
% th=linspace(0,2*pi,100);
% r=0.05;xc=0.2;yc=0.2;
% plot(r*cos(th)+xc,r*sin(th)+yc,'k','LineWidth',figOptions.LW);
rectangle('Position',[0.15,0.15,0.1,0.1],'Curvature',[1 1],'FaceColor','r','EdgeColor','r');
%hold off
axis equal
%xlim([min(x),max(x)]);
%ylim([min(y),max(y)]);
d=4;
quiver(X(1:d:end,1:d:end),Y(1:d:end,1:d:end),R.u(1:d:end,1:d:end),R.v(1:d:end,1:d:end),2,'k','LineWidth',1)
axis equal

% streamline
% ns=20;
% ys=linspace(0.01,0.41,ns);
% xs=0*ys+2.15;
% 
% x=linspace(0.05,2.15,30);
% y=linspace(0.01,0.40,8);
% [Xs,Ys]=meshgrid(x,y);
% %h=streamline(X,Y,R.u,R.v,Xs,Ys,[0.1,500]);
% tic;
% myStreamline(X,Y,R.u,R.v,Xs(:),Ys(:));
% toc;
% print('-depsc2','aaaWABEmyStreamline.eps')



