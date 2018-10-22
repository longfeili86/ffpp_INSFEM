function plotFPCdomain

LW=2;

x=[0,2.2];
y=[0,0.41];

plot(x,0.*x,'k','LineWidth',LW);
hold on
plot(x,0.*x+0.41,'k','LineWidth',LW);
plot(0*y,y,'k','LineWidth',LW);
plot(0*y+2.2,y,'k','LineWidth',LW);
rectangle('Position',[0.15,0.15,0.1,0.1],'Curvature',[1 1],'FaceColor','r','EdgeColor','r');
axis equal
hold off
end