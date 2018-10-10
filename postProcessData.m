function postProcessData(varargin)
% this function generate latex table for output errors in specified folder
folder='';
isprint=false; % print on screen
isPlot=false;
savePlot=false;
nStart=1; % starting grids
for i=1:nargin
    line = varargin{i};
    if(strncmp(line,'-f=',3))
        folder = line(4:end);
    end
    if(strncmp(line,'-ns=',4))
        nStart = sscanf(line,'-ns=%d');
    end
    if(strcmp(line,'-p'))
        isprint=true;
    end
    if(strcmp(line,'-plot'))
        isPlot=true;
    end
    if(strcmp(line,'-save'))
        savePlot=true;
    end
end
if strcmp(folder,'')
    fprintf('Provide the folder name that holds the data\n\n')
    fprintf('Usage:\npostProcessData -f=folder_name [-p (print ratios on screen)]\n')
    return
end


filename = strcat(folder,'/',folder,'errors.txt'); % input data
texfilename = strcat(folder,'/',folder,'Table.tex'); % output tex table



fid = fopen(filename);

%fid2 = fopen('temp.txt','w');
%isSkip = true;
fgetl(fid); % read ------> , discard 


eof = false;
gridNumber = 0;
while (~eof)
    gridNumber=gridNumber+1;
    Linf = fgetl(fid);
    L2 = fgetl(fid);
    H1 = fgetl(fid);
    eof = ~ischar(fgetl(fid));
    error.Linf(gridNumber,:) = sscanf(Linf,'%f %f %f %f')';
    error.L2(gridNumber,:) = sscanf(L2,'%f %f %f %f')';
    error.H1(gridNumber,:) = sscanf(H1,'%f %f %f %f')';
end

fclose(fid);
ratios.Linf = zeros(size(error.Linf));
ratios.L2 = zeros(size(error.L2));
ratios.H1 = zeros(size(error.H1));

ratios.Linf(2:end,:) = error.Linf(1:end-1,:)./error.Linf(2:end,:);
ratios.L2(2:end,:) = error.L2(1:end-1,:)./error.L2(2:end,:);
ratios.H1(2:end,1:end-1) = error.H1(1:end-1,1:end-1)./error.H1(2:end,1:end-1);

if(isprint)
    fprintf('ratio of erros in Linf norm:\n');
    ratios.Linf
    fprintf('ratio of erros in L2 norm:\n');
    ratios.L2
    fprintf('ratio of erros in H1 norm:\n'); 
    ratios.H1
end


% write latex table
% latexformat = GN, ErrU, ratio ,ErrV, ratio, Errp, ratio, Errdiv, ratio
latexformat = '%s & %5.2e & %5.2f  & %5.2e  & %5.2f  & %5.2e  & %5.2f  & %5.2e  & %5.2f \\\\ \\hline\n';

rateformat ='rate & %5.2f &        & %5.2f  &        & %5.2f  &        & %5.2f  &       \\\\ \\hline\n';      
   
fid = fopen(texfilename,'w');
fprintf(fid,'%% this tex file is generated by postProcessData.m\n\n\n\n');
fprintf(fid,'\\begin{figure}[hbt] \n\\begin{center}');


% Linf norm table
fprintf(fid,'\n\n\n\\begin{tabular}{|c|c|c|c|c|c|c|c|c|} \\hline \n');
%fprintf(fid,'\\multicolumn{9}{|c|}{\\strutt $L_{\inf}$ norm} \\\\ \\hline \n');
fprintf(fid,'\\strutt~~$G_j$~~& $||E_j^{(u)}||_{\\infty}$ & $r$ & $||E_j^{(v)}||_{\\infty}$ & $r$ & $||E_j^{(p)}||_{\\infty}$ & $r$ & $||E_j^{\\nabla\\cdot \\uv}||_{\\infty}$  & $r$  \\\\ \\hline \n');
for i=1:gridNumber
   fprintf(fid,latexformat,strcat('G',num2str(i)),error.Linf(i,1),ratios.Linf(i,1),error.Linf(i,2),ratios.Linf(i,2),error.Linf(i,3),ratios.Linf(i,3),error.Linf(i,4), ratios.Linf(i,4)); 
end
fprintf(fid,'\\end{tabular}\n');


% L2 norm table
fprintf(fid,'\n\n\n\\begin{tabular}{|c|c|c|c|c|c|c|c|c|} \\hline \n');
%fprintf(fid,'\\multicolumn{9}{|c|}{\\strutt $L_{\inf}$ norm} \\\\ \\hline \n');
fprintf(fid,'\\strutt~~$G_j$~~& $||E_j^{(u)}||_{2}$ & $r$ & $||E_j^{(v)}||_{2}$ & $r$ & $||E_j^{(p)}||_{2}$ & $r$ & $||E_j^{\\nabla\\cdot \\uv}||_{2}$  & $r$  \\\\ \\hline \n');
for i=1:gridNumber
   fprintf(fid,latexformat,strcat('G',num2str(i)),error.L2(i,1),ratios.L2(i,1),error.L2(i,2),ratios.L2(i,2),error.L2(i,3),ratios.L2(i,3),error.L2(i,4),ratios.L2(i,4)); 
end
fprintf(fid,'\\end{tabular}\n');


% H1 norm table
fprintf(fid,'\n\n\n\\begin{tabular}{|c|c|c|c|c|c|c|c|c|} \\hline \n');
%fprintf(fid,'\\multicolumn{9}{|c|}{\\strutt $L_{\inf}$ norm} \\\\ \\hline \n');
fprintf(fid,'\\strutt~~$G_j$~~& $|E_j^{(u)}|_{H_1}$ & $r$ & $|E_j^{(v)}|_{H_1}$ & $r$ & $|E_j^{(p)}|_{H_1}$ & $r$ & $|E_j^{\\nabla\\cdot \\uv}|_{H_1}$  & $r$  \\\\ \\hline \n');
for i=1:gridNumber
   fprintf(fid,latexformat,strcat('G',num2str(i)),error.H1(i,1),ratios.H1(i,1),error.H1(i,2),ratios.H1(i,2),error.H1(i,3),ratios.H1(i,3),error.H1(i,4),ratios.H1(i,4)); 
end
fprintf(fid,'\\end{tabular}\n');


fprintf(fid,'\\caption{%s}\n', folder);
fprintf(fid,'\\end{center}\n');
fprintf(fid,'\\end{figure}\n');
fclose(fid);



if(isPlot)
   figure
  %options:
   FS=20; %fontsize
   LW=2;  %lineWidth
   MS=10;  %markersize
     
   J=nStart:length(error.Linf(:,1));
   hh=1./(10*2.^(J-1));
   
   M = [ones(length(hh),1),log(hh)']; % matrix to compute convergence rate
   c=M\log(error.Linf(nStart:end,:));
   rate.Linf=c(2,:);
   c=M\log(error.L2(nStart:end,:));
   rate.L2=c(2,:);
   
   loglog(hh,(hh).^2,'k','LineWidth',LW,'MarkerSize',MS);
   hold on
   % Linf
   loglog(hh,error.Linf(nStart:end,1),'r-+','LineWidth',LW,'MarkerSize',MS); 
   loglog(hh,error.Linf(nStart:end,2),'g-+','LineWidth',LW,'MarkerSize',MS);
   loglog(hh,error.Linf(nStart:end,3),'b-+','LineWidth',LW,'MarkerSize',MS);
   loglog(hh,error.Linf(nStart:end,4),'c-+','LineWidth',LW,'MarkerSize',MS);

   % L2
   loglog(hh,error.L2(nStart:end,1),'r--','LineWidth',LW,'MarkerSize',MS);
   loglog(hh,error.L2(nStart:end,2),'g--','LineWidth',LW,'MarkerSize',MS);
   loglog(hh,error.L2(nStart:end,3),'b--','LineWidth',LW,'MarkerSize',MS);
   loglog(hh,error.L2(nStart:end,4),'c--','LineWidth',LW,'MarkerSize',MS);
   hold off
%    legend({'2nd order',....
%        sprintf('$||E(u)||_{\\infty}$ (r=%3.2f)',rate.Linf(1)),...
%        sprintf('$||E(v)||_{\\infty}$ (r=%3.2f)',rate.Linf(2)),...
%        sprintf('$||E(p)||_{\\infty}$ (r=%3.2f)',rate.Linf(3)),...
%        sprintf('$||E(\\nabla\\cdot\\mathbf{u})||_{\\infty}$ (r=%3.2f)',rate.Linf(4)),....
%        sprintf('$||E(u)||_{2}$ (r=%3.2f)',rate.L2(1)),....
%        sprintf('$||E(v)||_{2}$ (r=%3.2f)',rate.L2(2)),...
%        sprintf('$||E(p)||_{2}$ (r=%3.2f)',rate.L2(3)),...
%        sprintf('$||E(\\nabla\\cdot\\mathbf{u})||_{2}$ (r=%3.2f)',rate.L2(4))},....
%        'Location','NorthWest','Interpreter','latex','FontSize',FS-6);
   legend({'2nd order',....
       '$||E(u)||_{\infty}$',...
       '$||E(v)||_{\infty}$',...
       '$||E(p)||_{\infty}$',...
       '$||E(\nabla\cdot\mathbf{u})||_{\infty}$',....
       '$||E(u)||_{2}$',....
       '$||E(v)||_{2}$',...
       '$||E(p)||_{2}$',...
       '$||E(\nabla\cdot\mathbf{u})||_{2}$'},....
       'Location','NorthWest','Interpreter','latex','FontSize',FS);
   
   ylabel('error','FontSize',FS) ;
   set(gca,'FontSize',FS);
   box on
   grid on
   if(savePlot)
        figureName=strcat(folder,'_convRate.eps');
        fprintf('plot saved as: %s\n',figureName);
        print('-depsc2',figureName);
    end


end




end