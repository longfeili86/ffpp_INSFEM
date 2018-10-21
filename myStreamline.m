function myStreamline(X,Y,U,V,xs,ys)
% trace out stream line, stop when form almost a closeed curve

stepsize=0.1;
maxStep=4000;
tol=0.1;
n=length(xs);
assert(n==length(ys),'Error: length of xs and ys should be the same.');
Iu = griddedInterpolant(X',Y',U');
Iv = griddedInterpolant(X',Y',V');
f  = @(t,x) [Iu(x(1),x(2));Iv(x(1),x(2))];

xa=min(X(:));
xb=max(X(:));
ya=min(Y(:));
yb=max(Y(:));
axis([xa,xb,ya,yb]);
fprintf('number of start points: %d\n',n);
hold on
for i=1:n
    xp(1)=xs(i);
    yp(1)=ys(i);
    fprintf('start point %d = (%f,%f)\n',i,xp(1),yp(1)); 
    stop=false;
    tOld=0;
    x0=[xp(1);yp(1)];

    xOld=x0;
    step=0;
    dMax=0; % max distance between points with initial points
    stopNextStep=false;  
    while(~stop)
        step=step+1;
        tNew=tOld+stepsize;
        [t,X]=ode23(f,[tOld,tNew],xOld);
        assert(t(end)==tNew,'Error: something wrong with time');    
        xNew=X(end,:);
%         xNew=xOld+stepsize*f(tOld,xOld);
        xp(end+1)=xNew(1);
        yp(end+1)=xNew(2);
        dMax=max(dMax,norm(xNew-x0',2));
        tol=0.5*stepsize*dMax;
        %fprintf('step=%d, tol=%f, norm(xNew-x0,2)=%f\n',step,tol, norm(xNew-x0',2)); 
        if((norm(xNew-x0',2)<tol ) )
            if(stopNextStep==true)
                stop=true;
                fprintf('closed curve\n');
            end
            stopNextStep=true;
        end
        if((norm(xNew-xOld,2)<1e-4 ) )
            stop=true;
            fprintf('stagnation\n');
        end
        if(xNew(1)> xb || xNew(1)<xa || xNew(2)>yb || xNew(2)<ya)
            stop=true;
            fprintf('out of boundary\n');
        end
        if( step>maxStep)
            stop=true;
            fprintf('maxStep reached\n');
        end
        tOld=tNew;
        xOld=xNew;
        % debug:        
%         plot(xNew(1),xNew(2),'o');
%         title(sprintf('xs=%f, ys=%f\n',xs(i),ys(i)));
%         pause(0.01)
    end
    plot(xp,yp,'k','LineWidth',1);
    xp=[];yp=[];
end
hold off
end