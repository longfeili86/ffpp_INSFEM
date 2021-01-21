clear
 close all
% 
%resultsNames={'testFPCP1G1','testFPCP1G2','testFPCP1G4','testFPCR1'};lgd={'$P_1,G_1$','$P_1, G_2$','$P_1, G_4$','$P_1, G_8$'};ttl='P1GnTN';
%resultsNames={'testFPCWABEP1G1','testFPCWABEP1G2','testFPCWABEP1G4','testFPCWABER1'};lgd={'$P_1, G_1$','$P_1, G_2$','$P_1, G_4$','$P_1, G_8$'};ttl='P1GnWABE';

resultsNames={'testFPCP1G1','testFPCP1G2','testFPCP1G4'};lgd={'$(P_1,\mathcal{G}_1)$','$(P_1,\mathcal{G}_2)$','$(P_1,\mathcal{G}_4)$'};ttl='P1GnTN';
%resultsNames={'testFPCWABEP1G1','testFPCWABEP1G2','testFPCWABEP1G4'};lgd={'$(P_1,\mathcal{G}_1)$','$(P_1,\mathcal{G}_2)$','$(P_1,\mathcal{G}_4)$'};ttl='P1GnWABE';
%resultsNames={'testFPCP1G1','testFPCP2G1newdd','testFPCP4newdd'}; lgd={'$(P_1,\mathcal{G}_1)$','$(P_2,\mathcal{G}_1)$','$(P_4,\mathcal{G}_1)$'};ttl='PnG1TN';
%resultsNames={'testFPCWABEP1G1','testFPCWABEP2G1newdd','testFPCWABEP4newdd'};lgd={'$(P_1,\mathcal{G}_1)$','$(P_2,\mathcal{G}_1)$','$(P_4,\mathcal{G}_1)$'};ttl='PnG1WABE';

setupFigure
numRefinement=3;

cc='rkbc'

h1=figure(1)
hold on

h2=figure(2)
hold on


h3=figure(3)
hold on
for i=1:numRefinement
resultsName=resultsNames{i};

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

figure(1)
plot(t,cd,cc(i),'LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
%print('-depsc2',sprintf('%scd.eps',resultsName))

figure(2)
plot(t,cl,cc(i),'LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
%print('-depsc2',sprintf('%scl.eps',resultsName))


figure(3)
plot(t,dp,cc(i),'LineWidth',figOptions.LW);
set(gca,'FontSize',figOptions.FS)
%print('-depsc2',sprintf('%sdp.eps',resultsName))
end

figure(1)
hold off
legend(lgd,'Interpreter','latex','Location','northwest');legend boxoff;
% It is important to set the figure size and limits BEFORE running
% MagInset!
xlim([t(1) t(end)]);
ylim([0,4]);
set(h1, 'Position',[105   647   560   420]);
% Once happy with your figure, add an inset:
MagInset(h1, -1, [3.6 4.4 2.8 3.3], [2.4 4. 0.5 1.5], {'NW','NW';'SE','SE'});
set(gca,'FontSize',15)
xticks([3.6 4 4.4])
print('-depsc2',sprintf('%s_cd.eps',ttl))


figure(2)
hold off
legend(lgd,'Interpreter','latex','Location','northwest');legend boxoff;
% It is important to setthe figure size and limits BEFORE running
% MagInset!
xlim([t(1) t(end)]);
ylim([-0.5,0.5]);
set(h2, 'Position',[105   647   560   420]);
% Once happy with your figure, add an inset:
MagInset(h2, -1, [5.5 6.1 0.4 0.5], [3.0 4.2 0.25 0.45], {'NW','NW';'SE','SE'});
set(gca,'FontSize',15)
print('-depsc2',sprintf('%s_cl.eps',ttl))



figure(3)
hold off
legend(lgd,'Interpreter','latex','Location','northwest');legend boxoff;
% It is important to set the figure size and limits BEFORE running
% MagInset!
xlim([t(1) t(end)]);
ylim([-0.5,3.]);
set(h3, 'Position',[105   647   560   420]);
% Once happy with your figure, add an inset:
MagInset(h3, -1, [7.8 8 -0.15 -0.05], [4 6 0 1.], {'NE','NE';'SW','SW'});
set(gca,'FontSize',15)
print('-depsc2',sprintf('%s_dp.eps',ttl))



