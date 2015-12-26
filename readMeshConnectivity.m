function tri = readMeshConnectivity(varargin)
% this function reads the mesh connectivity information in a results 
% folder
folder='';
for i=1:nargin
    line = varargin{i};
    if(strncmp(line,'-f=',3))
        folder = line(4:end);
    end 
end
if strcmp(folder,'')
    fprintf('Provide the folder name that holds the data\n\n');
    fprintf('Usage:\nreadMeshConnectivity -f=folder_name\n');
    return
end

filename = strcat(folder,'/mesh.msh'); % input data

fprintf('reading mesh connectivity from %s\n', filename);
fid = fopen(filename);
LL = fgetl(fid); % read mesh statistics 
Tn = sscanf(LL,'%f %f %f')';
numberOfNodes = Tn(1);
numberOfTriangles = Tn(2);
numberOfEdges = Tn(3);
lineNumber=1;
for i=1:numberOfNodes
    fgetl(fid);
    lineNumber=lineNumber+1;
end
tri = zeros(numberOfTriangles,3)+999;
for i= lineNumber+1:lineNumber+numberOfTriangles
    LL=fgetl(fid);
    tri(i-lineNumber,1:3) = sscanf(LL,'%d %d %d %*d');
end

end