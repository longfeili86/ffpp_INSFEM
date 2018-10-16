function Results=interpResultsOnCartitianMesh(X,Y,resultsFolder,n)
% Input:
%    X: x coordinate of the interpolating grid
%    Y: y coordinate of the interpolating grid
%   resultsFolder: folder name that holds the results
%               n: solution number
% Output: 
%    U: interpolated results of u on the mesh [X,Y]
%    V: interpolated results of v on the mesh [X,Y]
%    P: interpolated results of p on the mesh [X,Y]
% Culr: interpolated results of curl on the mesh [X,Y]

run(sprintf('%s/DOFFile',resultsFolder));
x=T.coordinates(:,1);
y=T.coordinates(:,2);

comp={'u','v','p','curl'};

for i=1:length(comp) 
    run(sprintf('%s/%s%dFile',resultsFolder,comp{i},n));
    Icomp = scatteredInterpolant(x,y,transpose(eval(sprintf('%s%d',comp{i},n))));
    Results.(comp{i})=Icomp(X,Y);
end




end