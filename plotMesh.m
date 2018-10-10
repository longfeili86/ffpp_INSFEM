% plot square mesh used for mesh refinement study using matlab

squareMeshFile

tri=T.elements;
X=T.coordinates(:,1);
Y=T.coordinates(:,2);
Z=0*T.coordinates(:,2);

trimesh(tri,X,Y,Z,'LineWidth',2);
axis equal
axis off
set(gca,'FontSize',30)
view(2)

print('-depsc2','squareGrid');


clear
cilcMeshFile

tri=T.elements;
X=T.coordinates(:,1);
Y=T.coordinates(:,2);
Z=0*T.coordinates(:,2);

trimesh(tri,X,Y,Z,'LineWidth',2);
axis equal
axis off
set(gca,'FontSize',30)
view(2)

print('-depsc2','cilcGrid');