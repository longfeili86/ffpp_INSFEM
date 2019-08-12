% clear
% close all
% 
% resultsName='testFPCP4';

run(sprintf('%s/cdFile.m',resultsName));
run(sprintf('%s/clFile.m',resultsName));
run(sprintf('%s/dpFile.m',resultsName));
run(sprintf('%s/maxcdclFile.m',resultsName));
fprintf('max(cd)=%f, t(max(cd))=%f\nmax(cl)=%f,t(max(cl))=%f\n',cdmax,tcdmax,clmax,tclmax);
fprintf('dp(8)=%f\n',dp(end));


%timeInfo=[t0,dt,tplot,tf]
run(sprintf('%s/timeInfoFile.m',resultsName));
n=length(cd);
t=timeInfo(1)+timeInfo(3)*(0:n-1);

figure
plot(t,cd,'k','LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
print('-depsc2',sprintf('%scd.eps',resultsName))

figure
plot(t,cl,'k','LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
print('-depsc2',sprintf('%scl.eps',resultsName))


figure
plot(t,dp,'k','LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
print('-depsc2',sprintf('%sdp.eps',resultsName))


