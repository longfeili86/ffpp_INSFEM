clear
close all

resultsName='testFPCWABE';

numSolutions=139;
for i=1:numSolutions
    run(sprintf('%s/dlp%dFile.m',resultsName,i));
    dlp=eval(sprintf('dlp%d',i));
    cd(i)=dlp(1);
    cl(i)=dlp(2);
    dp(i)=dlp(3);
end
t=0.05*(1:numSolutions);
figure
plot(t,cd);
title('cd')
figure
plot(t,cl,'.-');
title('cl')

figure
plot(t,dp);
title('dp')
