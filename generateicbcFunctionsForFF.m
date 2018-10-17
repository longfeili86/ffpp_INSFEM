%========================================================================
% This script is used to specify ic and bc for non-tz tests
% A filename.edp file that contains all the necessary information for FF++ 
% will be generated.  Change macro funcDefFILE()  "filename.edp" in
% runScript to pass the icbc information to FF++ code.
% 
% by Longfei Li 12142015
% major modification by Longfei Li 10092018
%========================================================================


% Modify here to specify different ic and bc functions


% specify initial conditions for u, v and p
Uic='0';
Vic='0';
Pic='0';

%lid drive cavity
%Uib={Uic,'0','0','1','0'}; %{Uic,Ubc1,Ubc2,...Ubcn}  
%Vib={Vic,'0','0','0','0'}; %{Vic,Vbc1,Vbc2,...Vbcn}  
%Pib={Pic};  %[Pic];
%filename = 'icbcFunctions_LidDrivenCavity';     % do not add suffix .edp in filename

            
%modified lid drive cavity
%Uib={Uic,'0','0','(-tanh((abs(x-0.5)-0.495)/0.01)+1)/2','0'}; %{Uic,Ubc1,Ubc2,...Ubcn}  
%Vib={Vic,'0','0','0','0'}; %{Vic,Vbc1,Vbc2,...Vbcn}  
%Pib={Pic};  %[Pic];
%filename = 'icbcFunctions_modifiedLidDrivenCavity';     % do not add suffix .edp in filename


%flow past a cylinder (base grid)
% bc1: button wall, bc2: outflow, bc3: top wall, bc4: inflow, bc5:
% cylinder
UinNout='0.41^(-2)*sin(pi*t/8)*(6*y*(0.41-y))';
Uib={Uic,'0',UinNout,'0',UinNout,'0'}; %{Uic,Ubc1,Ubc2,...Ubcn}  
Vib={Vic,'0','0','0','0','0'}; %{Vic,Vbc1,Vbc2,...Vbcn}  
Pib={Pic};  %[Pic];
filename = 'icbcFunctions_FlowPastCylinder';     % do not add suffix .edp in filename









%===================== Do Not Change ===================================
assert(length(Uib)==length(Vib),'number of bcs for u and v does not match\n');
nb = length(Uib)-1;             % number of boundaries of the domain  

% call this function to do the symbolic computation and output the
% filename.edp file.
icbcPreparation(Uib,Vib,Pib,nb,filename); 
%========================================================================



