%========================================================================
% This script is used to specify exact solutions for TZ test.
% A filename.edp file that contains all the necessary information for FF++ 
% is generated. Change macro funcDefFILE()  "filename.edp" in
% runScript to pass the TZ information to FF++ code.
% 
% by Longfei Li 12142015
%========================================================================


% Modify here to specify different exact solutions
Ue='(0.5*t+1.0)*(x+y+1.0)';  
Ve='(0.5*t+1.0)*(x-y+2.0)';
Pe='(0.5*t+1.0)*(x+y-1.0)';
filename = 'TZFunctions';     % do not add suffix .edp in filename
nb = 4;                       % number of boundaries of the domain

%===================== Do Not Change ===================================
% call this function to do the symbolic computation and output the
% filename.edp file.
twilightzonePreparation(Ue,Ve,Pe,4,filename); 
%========================================================================