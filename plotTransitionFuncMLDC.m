% plot transition function for MLDC
% 01/04/2020

filename='mesh/squareStretched64x64.msh';
T=readMsh(filename);

idx=find(T.coordinates(:,2)==1);
x=T.coordinates(idx,1);
y=T.coordinates(idx,2);


resultsName='testMLDCWABEStretched64x64';
u0= @(x)(-tanh((abs(x-0.5)-0.495)/0.01)+1)/2;
solutionNumber=1000;
run(sprintf('%s/%s%dFile',resultsName,'u',solutionNumber));
u=eval(sprintf('%s%d','u',solutionNumber));
plot(x,u(idx),'o-','linewidth',2)
xlim([0,0.2])



