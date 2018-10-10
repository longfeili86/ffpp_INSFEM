function T = readMesh(folder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function reads the mesh information in a results 
% Input: folder name of the results
% returns the triangulation with the original the basic fields:
%     T.elements (connectivity)
%     T.coordinates (x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(nargin==0)
    fprintf('Provide the folder name that holds the data\n\n');
    fprintf('Usage:\nreadMesh(folder_name)\n');
    return
end


filename = strcat(folder,'/mesh.msh'); % input data

T=readMsh(filename);
% The following code is wrapped in readMsh.m (Longfei:10082018)
% fprintf('Read mesh information from %s\n', filename);
% fid = fopen(filename);
% LL = fgetl(fid); % read mesh statistics 
% Tn = sscanf(LL,'%f %f %f')';
% fprintf(['************************************\n',...
%         'Mesh information:\n',...
%         'Number of nodes: %d\n',...
%         'Number of Triangles: %d\nNumber of Edges: %d\n',...
%         '************************************\n'],Tn(1),Tn(2),Tn(3));
% numberOfNodes = Tn(1);
% numberOfTriangles = Tn(2);
% numberOfEdges = Tn(3);
% lineNumber=1;
% for i=1:numberOfNodes
%     LL=fgetl(fid);
%     T.coordinates(i,1:2) = sscanf(LL,'%f %f %*f');
%     lineNumber=lineNumber+1;
% end
% T.elements = zeros(numberOfTriangles,3)+999;
% for i= lineNumber+1:lineNumber+numberOfTriangles
%     LL=fgetl(fid);
%     T.elements(i-lineNumber,1:3) = sscanf(LL,'%d %d %d %*d');
% end


end