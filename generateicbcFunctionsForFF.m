%========================================================================
% This script is used to specify ic and bc for non-tz tests
% A filename.edp file that contains all the necessary information for FF++ 
% will be generated.  Change macro funcDefFILE()  "filename.edp" in
% runScript to pass the icbc information to FF++ code.
% 
% by Longfei Li 12142015
%========================================================================


% Modify here to specify different ic and bc functions
Uib=['0','0','0','0','0'];%[Uic,Ubc1,Ubc2,...Ubcn]  
Vib=['0','0','0','0','0'];%[Vic,Vbc1,Vbc2,...Vbcn]  

filename = 'icbcFunctions';     % do not add suffix .edp in filename
nb = 4;                   % number of boundaries of the domain  

%===================== Do Not Change ===================================
% call this function to do the symbolic computation and output the
% filename.edp file.
icbcPreparation(Uib,Vib,nb,filename); 
%========================================================================



