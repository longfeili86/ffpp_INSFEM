function T=readMsh(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function read a mesh file in the msh format
% Input:
%   filename: filename of the msh file
% Output: returns the triangulation with the original the basic fields:
%     T.elements (connectivity+region label)
%     T.coordinates (x,y)+label
%     T.edges  (e1,e2)+label
% Longfei Li 10092018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==0)
    fprintf('Error: Provide filename for the msh mesh\n\n');
    fprintf('Usage:\nreadMsh(filename)\n');
    return
end

if(~endsWith(filename,'.msh')) 
    filename=strcat(filename,'.msh'); % add suffix to the filename
end


fprintf('Read mesh information from %s\n', filename);
fid = fopen(filename);
LL = fgetl(fid); % read mesh statistics 
Tn = sscanf(LL,'%d %d %d')';
fprintf(['************************************\n',...
        'Mesh information:\n',...
        'Number of nodes: %d\n',...
        'Number of Triangles: %d\n',...
        'Number of Edges: %d\n',...
        '************************************\n'],Tn(1),Tn(2),Tn(3));
T.numberOfNodes = Tn(1);
T.numberOfTriangles = Tn(2);
T.numberOfEdges = Tn(3);
for i=1:T.numberOfNodes
    LL=fgetl(fid);
    T.coordinates(i,1:3) = sscanf(LL,'%f %f %d');  % [x,y,label],label=0:interio, label>0, boundary 
end
T.elements = zeros(T.numberOfTriangles,4)+999;
for i= 1:T.numberOfTriangles
    LL=fgetl(fid);
    T.elements(i,1:4) = sscanf(LL,'%d %d %d %d'); %connectiviy[T1,T2,T3] and region label
end
T.edges = zeros(T.numberOfEdges,3)+999;
for i= 1:T.numberOfEdges
    LL=fgetl(fid);
    T.edges(i,1:3) = sscanf(LL,'%d %d %d');  %[e1,e2] and boundary label
end



