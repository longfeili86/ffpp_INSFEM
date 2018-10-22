clear
close all

resultsName='testFPCWABE';

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
plot(t,cd);
figure
plot(t,cl);
figure
plot(t,dp);