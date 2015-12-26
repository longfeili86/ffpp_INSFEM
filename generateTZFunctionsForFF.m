%========================================================================
% This script is used to specify exact solutions for TZ test.
% A filename.edp file that contains all the necessary information for FF++ 
% is generated. Change macro funcDefFILE()  "filename.edp" in
% runScript to pass the TZ information to FF++ code.
% 
% by Longfei Li 12142015
%========================================================================


% Modify here to specify different exact solutions

%tzPoly1
% Ue='(0.5*t+1.0)*(x+y+1.0)';  
% Ve='(0.5*t+1.0)*(x-y+2.0)';
% Pe='(0.5*t+1.0)*(x+y-1.0)';
% filename = 'tzPoly1Functions';     % do not add suffix .edp in filename

%tzPoly2
% Ue = '(x^2+2*x*y+y^2)*(1+0.5*t+t^2/3.0)';
% Ve = '(x^2-2*x*y-y^2)*(1+0.5*t+t^2/3.0)';
% Pe = '(x^2+0.5*x*y+y^2-1)*(1+0.5*t+t^2/3.0)';
% filename = 'tzPoly2Functions';

%tzPoly2t1
% Ue = '(x^2+2*x*y+y^2)*(1+0.5*t)';
% Ve = '(x^2-2*x*y-y^2)*(1+0.5*t)';
% Pe = '(x^2+0.5*x*y+y^2-1)*(1+0.5*t)';
% filename = 'tzPoly2t1Functions';

%tzTrig1
% Ue = '-a*cos(fx*pi*x)*sin(fx*pi*(y-1))*cos(ft*pi*t)'; 
% Ve = 'a*sin(fx*pi*x)*cos(fx*pi*(y-1))*cos(ft*pi*t)';  
% Pe = 'a*cos(fx*pi*x)*cos(fx*pi*y)*cos(ft*pi*t)';
% filename = 'tzTrig1Functions';

%tzTrig1t1
Ue = '-a*cos(fx*pi*x)*sin(fx*pi*(y-1))*(1+0.5*t)'; 
Ve = 'a*sin(fx*pi*x)*cos(fx*pi*(y-1))*(1+0.5*t)';  
Pe = 'a*cos(fx*pi*x)*cos(fx*pi*y)*(1+0.5*t)';
filename = 'tzTrig1t1Functions';

%===================== Do Not Change ===================================
% call this function to do the symbolic computation and output the
% filename.edp file.
twilightzonePreparation(Ue,Ve,Pe,filename); 
%========================================================================