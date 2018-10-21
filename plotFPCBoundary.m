hold on
plot(x,0.*x,'k','LineWidth',figOptions.LW);
plot(x,0.*x+0.41,'k','LineWidth',figOptions.LW);
plot(0*y,y,'k','LineWidth',figOptions.LW);
plot(0*y+2.2,y,'k','LineWidth',figOptions.LW);
th=linspace(0,2*pi,100);
r=0.05;xc=0.2;yc=0.2;
plot(r*cos(th)+xc,r*sin(th)+yc,'k','LineWidth',figOptions.LW);
hold off
