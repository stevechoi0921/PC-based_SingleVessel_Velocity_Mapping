clc
clear all
close all
font_size = 18;
axs_line_width = 2.5;
plot_linewidth = 2.5;
TR = 4;
Fs = 1/TR;

%%
close all
curDir=pwd;
directory=curDir(1:end);
cd(curDir)
load('flow_data_Ar.mat')
load('flow_data_Ve.mat')
mkdir Result_Figures;
figure_folder=strcat(curDir,'/Result_Figures');
nColor = 50;
myColorOrder = distinguishable_colors(nColor);
myColorOrder(3,:) = myColorOrder(7,:); %bright green to dark green
myColorOrder(7,:) = myColorOrder(3,:); %bright green to dark green
myMarkShape ={'o','s','d','^','*','v','>','<','p','h','x','+'};
          
%% Plot Velocity of Arterioles, Venules
nAnimal = 11; 
Scale_factor = 10; % cm/s to mm/s
h=figure();
for iA = 1 : nAnimal
    intensity_data_Ar = flow_data_Ar{iA}(:,1);  
 
    velocity_data_Ar = flow_data_Ar{iA}(:,2).*Scale_factor;  
       mean_ar(:,iA)=mean(velocity_data_Ar);
    plot(intensity_data_Ar,velocity_data_Ar,myMarkShape{iA},'color','r','LineWidth',plot_linewidth);
        
    hold on
    intensity_data_Ve = flow_data_Ve{iA}(:,1);  
    velocity_data_Ve = flow_data_Ve{iA}(:,2).*Scale_factor;  
    mean_ve(:,iA)=mean( velocity_data_Ve);
    plot(intensity_data_Ve,velocity_data_Ve,myMarkShape{iA},'color','b','LineWidth',plot_linewidth);
end
hold off
box off;
xlabel('A-V Map Intensity');
ylabel('Flow Velocity');
xlim([0 1])
ylim([Scale_factor*(-1) Scale_factor])
set(gcf,'color','w');
set(gca,'FontSize',font_size,'FontWeight','Bold');
set(gca,'linewidth',axs_line_width)
set(gcf, 'Position', [500, 500, 600, 500])
strName2 ='Velocity vs Intensity Plot';
strName3 =strName2;
title(strName2);
cd(figure_folder)
saveas(h,strName3,'png');
cd(curDir)
%% Histogram
idx_Vel =2;
clear velocity_data_Ar_list velocity_data_Ve_list;
% nAnimal=5;
for iA = 1 : nAnimal
    nTemp_Ar(:,iA) = size(flow_data_Ar{iA},1);
    nTemp_Ve(:,iA) = size(flow_data_Ve{iA},1);
    
    
    if iA == 1
        velocity_data_Ar_list(:,1) = flow_data_Ar{iA}(:,idx_Vel).*Scale_factor;  
        velocity_data_Ve_list(:,1) = flow_data_Ve{iA}(:,idx_Vel).*Scale_factor;  
    else
        nCurr_Ar = size(flow_data_Ar{iA},1);
        nCurr_Ve = size(flow_data_Ve{iA},1);
        idx_start_Ar = 1+sum(nTemp_Ar(:,1:iA-1),2);
        idx_start_Ve = 1+sum(nTemp_Ve(:,1:iA-1),2);
        velocity_data_Ar_list(idx_start_Ar:idx_start_Ar+nCurr_Ar-1,1) = flow_data_Ar{iA}(:,idx_Vel).*Scale_factor;  
        velocity_data_Ve_list(idx_start_Ve:idx_start_Ve+nCurr_Ve-1,1) = flow_data_Ve{iA}(:,idx_Vel).*Scale_factor;  
    end
    
end
nTotal_Ar = length(velocity_data_Ar_list);
nTotal_Ve = length(velocity_data_Ve_list);
%% Histogram and fit line with velocity_data_Ar_list & velocity_data_Ve_list

h=figure();
nbins = 100;
Dist ='ev';
histo_ve = histfit(velocity_data_Ve_list,nbins,Dist);
histo_ve(1).FaceColor = 'b';
histo_ve(2).Color = 'k';
hold on;
histo_ar = histfit(velocity_data_Ar_list,nbins,Dist);
histo_ar(1).FaceColor = 'r';
histo_ar(2).Color = 'k';
plot(histo_ar(2).XData,histo_ar(2).YData,'-','color',histo_ve(2).Color,'LineWidth',plot_linewidth);
plot(histo_ve(2).XData,histo_ve(2).YData,'-','color',histo_ve(2).Color,'LineWidth',plot_linewidth);
hold off;
xlim([Scale_factor*(-1) Scale_factor]);
ylabel('Count of Vessels');
xlabel('Flow Velocity');
box off;

set(gcf,'color','w');
set(gca,'FontSize',font_size,'FontWeight','Bold');
set(gca,'linewidth',axs_line_width);
set(gcf, 'Position', [500, 500, 600, 500]);
strName10 ='Histogram of Arteriole & Venule Velocity';
title(strName10);
cd(figure_folder)
saveas(h,strName10,'png');
cd(curDir)
%%
h=figure();
nbins = 100;
histo = histfit(velocity_data_Ve_list,nbins,Dist);
histo(1).FaceColor = 'b';
histo(2).Color = 'k';
ylabel('Count of Vessels');
xlabel('Flow Velocity');
xlim([Scale_factor*(-1) Scale_factor]);
box off;

set(gcf,'color','w');
set(gca,'FontSize',font_size,'FontWeight','Bold');
set(gca,'linewidth',axs_line_width);
set(gcf, 'Position', [500, 500, 600, 500]);
strName10 ='Histogram of Venule Velocity';
title(strName10);
cd(figure_folder)
saveas(h,strName10,'png');
cd(curDir)


h=figure();
nbins = 100;
histo = histfit(velocity_data_Ar_list,nbins,Dist);
histo(1).FaceColor = 'r';
histo(2).Color = 'k';
ylabel('Count of Vessels');
xlabel('Flow Velocity');
xlim([Scale_factor*(-1) Scale_factor]);
box off;

set(gcf,'color','w');
set(gca,'FontSize',font_size,'FontWeight','Bold');
set(gca,'linewidth',axs_line_width);
set(gcf, 'Position', [500, 500, 600, 500]);
strName10 ='Histogram of Arteriole Velocity';
title(strName10);
cd(figure_folder)
saveas(h,strName10,'png');
cd(curDir)

%%



