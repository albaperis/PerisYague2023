%Calculate the probability of recall depending on oddball position in each
%list. 

%Get all trials lags separated by those where the odd was Remembered vs not
%(controls)

%Column 15=subject, column 16=list number, column 17=type of oddball,
%column 18=SOA, column 19=position oddball, column 20= position of the
%control at encoding 

%This script combines the code with functions from the Computational Memory
%Lab which are avaibalable here: http://memory.psych.upenn.edu/Behavioral_toolbox

clearvars; close all; clc
dir= '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code'; %'/Code';
cd(dir)

addpath(genpath('/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/behavioral_toolbox_release1.01')) %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox

list_length = 14; 

%%% Emotional Oddballs %%% 

load emotional_v1_CRP

positions = unique(emotional_v1_CRP(:,19)); %Get the possible encoding positions of the oddballs

%% quick check of all
all = []; 
all = str2double(emotional_v1_CRP);

all_emo_spc = spc(all(:,1:14), all(:,15), list_length);

plot_spc(all_emo_spc); hold on 
legend('Emotional')

%mean(all_emo_spc)
%std(all_emo_spc)

all_emo_pfr = pfr(all(:,1:14), all(:,15), list_length);

plot_spc(all_emo_pfr); hold on 
legend('Emotional'); title('Probability of first recall')


%%

i= []; where = []; data = [];
for i = 1:length(positions); 
    pos = positions(i); 
    where = strcmp(emotional_v1_CRP(:,19), pos);
    data{i,1} = emotional_v1_CRP(where,:);
    data{i,2} = pos; 
end 

e11 = str2double(data{1,1}); 
e12 = str2double(data{2,1}); 
e7 = str2double(data{3,1}); 
e8 = str2double(data{4,1}); 
e9 = str2double(data{5,1});

e7_spc = spc(e7(:,1:14), e7(:,15), list_length); 
e8_spc = spc(e8(:,1:14), e8(:,15), list_length); 
e9_spc = spc(e9(:,1:14), e9(:,15), list_length); 
e11_spc = spc(e11(:,1:14), e11(:,15), list_length); 
e12_spc = spc(e12(:,1:14), e12(:,15), list_length); 

%%%%% Now check probability of first recall
e7_pfr = pfr(e7(:,1:14), e7(:,15), list_length); 
e8_pfr = pfr(e8(:,1:14), e8(:,15), list_length); 
e9_pfr = pfr(e9(:,1:14), e9(:,15), list_length); 
e11_pfr = pfr(e11(:,1:14), e11(:,15), list_length); 
e12_pfr = pfr(e12(:,1:14), e12(:,15), list_length); 

%plot_spc(e7_pfr);

% Get the possible encoding positions for the control oddballs 
load emo_ctrl
positions= [];
positions = unique(emo_ctrl(:,20)); %Get the possible encoding positions of the oddballs

i= []; where = []; data = [];

for i = 1:length(positions); 
    pos = positions(i); 
    where = strcmp(emo_ctrl(:,20), pos);
    data{i,1} = emo_ctrl(where,:);
    data{i,2} = pos; 
end

ce11 = str2double(data{1,1}); 
ce12 = str2double(data{2,1}); 
ce13 = str2double(data{3,1}); 
ce7 = str2double(data{4,1}); 
ce8 = str2double(data{5,1});

ce7_spc = spc(ce7(:,1:14), ce7(:,15), list_length); 
ce8_spc = spc(ce8(:,1:14), ce8(:,15), list_length); 
ce13_spc = spc(ce13(:,1:14), ce13(:,15), list_length); 
ce11_spc = spc(ce11(:,1:14), ce11(:,15), list_length); 
ce12_spc = spc(ce12(:,1:14), ce12(:,15), list_length);

%%%% Compute probability of first recall
ce7_pfr = pfr(ce7(:,1:14), ce7(:,15), list_length); 
ce8_pfr = pfr(ce8(:,1:14), ce8(:,15), list_length); 
ce13_pfr = pfr(ce13(:,1:14), ce13(:,15), list_length); 
ce11_pfr = pfr(ce11(:,1:14), ce11(:,15), list_length); 
ce12_pfr = pfr(ce12(:,1:14), ce12(:,15), list_length);

plot_spc(ce7_pfr);

%%%%%% Get perceptual data %%%%% 

load perceptual_v1_CRP
positions = unique(perceptual_v1_CRP(:,19));

%% plot all perceptual 
all = []; 
all = str2double(perceptual_v1_CRP);

all_perc_spc = spc(all(:,1:14), all(:,15), list_length);

plot_spc(all_perc_spc); hold on 
legend('Perceptual')

all_perc_pfr = pfr(all(:,1:14), all(:,15), list_length);

plot_spc(all_perc_pfr); hold on 
legend('Perceptual'); title('Probability of first recall')


%%
i= []; where = []; data = []; pos = []; 

for i = 1:length(positions); 
    pos = positions(i); 
    where = strcmp(perceptual_v1_CRP(:,19), pos);
    data{i,1} = perceptual_v1_CRP(where,:);
    data{i,2} = pos; 
end 

p11 = str2double(data{1,1}); 
p12 = str2double(data{2,1}); 
p7 = str2double(data{3,1}); 
p8 = str2double(data{4,1}); 
p9 = str2double(data{5,1});

p7_spc = spc(p7(:,1:14), p7(:,15), list_length); 
p8_spc = spc(p8(:,1:14), p8(:,15), list_length); 
p9_spc = spc(p9(:,1:14), p9(:,15), list_length); 
p11_spc = spc(p11(:,1:14), p11(:,15), list_length);
p12_spc = spc(p12(:,1:14), p12(:,15), list_length);

%%%% Probability of first recall 
p7_pfr = pfr(p7(:,1:14), p7(:,15), list_length); 
p8_pfr = pfr(p8(:,1:14), p8(:,15), list_length); 
p9_pfr = pfr(p9(:,1:14), p9(:,15), list_length); 
p11_pfr = pfr(p11(:,1:14), p11(:,15), list_length);
p12_pfr = pfr(p12(:,1:14), p12(:,15), list_length);

%plot_spc(p7_pfr); 

% Get the possible encoding positions for the control oddballs 
load per_ctrl
positions= [];
positions = unique(per_ctrl(:,20)); %Get the possible encoding positions of the oddballs

i= []; where = []; data = []; pos = [];

for i = 1:length(positions); 
    pos = positions(i); 
    where = strcmp(per_ctrl(:,20), pos);
    data{i,1} = per_ctrl(where,:);
    data{i,2} = pos; 
end

cp11 = str2double(data{1,1}); 
cp12 = str2double(data{2,1}); 
cp13 = str2double(data{3,1}); 
cp7 = str2double(data{4,1}); 
cp8 = str2double(data{5,1});

cp7_spc = spc(cp7(:,1:14), cp7(:,15), list_length); 
cp8_spc = spc(cp8(:,1:14), cp8(:,15), list_length); 
cp13_spc = spc(cp13(:,1:14), cp13(:,15), list_length); 
cp11_spc = spc(cp11(:,1:14), cp11(:,15), list_length); 
cp12_spc = spc(cp12(:,1:14), cp12(:,15), list_length);

%%% Probability of first recall

cp7_pfr = pfr(cp7(:,1:14), cp7(:,15), list_length); 
cp8_pfr = pfr(cp8(:,1:14), cp8(:,15), list_length); 
cp13_pfr = pfr(cp13(:,1:14), cp13(:,15), list_length); 
cp11_pfr = pfr(cp11(:,1:14), cp11(:,15), list_length); 
cp12_pfr = pfr(cp12(:,1:14), cp12(:,15), list_length);

%%%%%% Plot it %%%%% 

emo.xtick = [1,3,5,7,9,11,14];
emo.linecolor = {'magenta'}; 
emo.linetype = {'solid'};
emo.marker = {'circle'};
emo.extras = {'LineWidth',1,'MarkerEdgeColor','magenta', 'MarkerFaceColor','magenta'};
emo.fontsize = 15;
emo.xlabel = struct('size',15); 
emo.ylabel = struct('size',15);

emo_ctrl = emo; 
emo_ctrl.marker = {'star'}; 
emo_ctrl.linecolor = {'red'}; 
emo_ctrl.extras = {'LineWidth',1,'MarkerEdgeColor','red', 'MarkerFaceColor','red'};

perc = emo; 
perc.linecolor = {'cyan'}; 
perc.extras = {'LineWidth',1,'MarkerEdgeColor','cyan', 'MarkerFaceColor','cyan'};

perc_ctrl = perc; 
perc_ctrl.marker = {'star'}; 
perc_ctrl.linecolor = {'blue'}; 
perc_ctrl.extras = {'LineWidth',1,'MarkerEdgeColor','blue', 'MarkerFaceColor','blue'};

%% Plot both 
figure; 
plot_spc(all_emo_spc, emo); hold on 
plot_spc(all_perc_spc, perc); hold on 
legend('Emotional', 'Perceptual'); 

% Calculate together

all = []; 
all = [emotional_v1_CRP; perceptual_v1_CRP]; 

all = str2double(all);

all_spc = spc(all(:,1:14), all(:,15), list_length);

plt.xtick = [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
plt.errorbars = std(all_spc); 

figure; plot_spc(all_spc, plt); 

mean(all_spc)
std(all_spc)

%%
% Emotional and Perceptual lists % 
figure('Position', [198, 292, 802, 505]); 
subplot(231); plot_spc(e7_spc,emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_spc,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(232); plot_spc(e8_spc,emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p8_spc,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(233); plot_spc(e9_spc,emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_spc,perc); hold off
              legend('Emotional', 'Perceptual')
              
subplot(234); plot_spc(e11_spc,emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_spc,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(235); plot_spc(e12_spc,emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_spc,perc); hold off
              legend('Emotional','Perceptual')
              
sgtitle('Recall probability by serial position', 'fontweight', 'bold', 'fontsize',20); 

% Now let's compare it to controls % 
t=figure('Position', [198, 324, 1139, 473]); 
subplot(221); plot_spc(e7_spc,emo); title('Encoding position = 7'); hold on 
              plot_spc(ce7_spc,emo_ctrl); hold on 
              plot_spc(p7_spc,perc); hold on 
              plot_spc(cp7_spc,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              
subplot(222); plot_spc(e8_spc,emo); title('Encoding position = 8'); hold on 
              plot_spc(ce8_spc,emo_ctrl); hold on 
              plot_spc(p8_spc,perc); hold on 
              plot_spc(cp8_spc,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')

subplot(223); plot_spc(e11_spc,emo); title('Encoding position = 11'); hold on 
              plot_spc(ce11_spc,emo_ctrl); hold on 
              plot_spc(p11_spc,perc); hold on
              plot_spc(cp11_spc,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              
subplot(224); plot_spc(e12_spc,emo); title('Encoding position = 12'); hold on 
              plot_spc(ce12_spc,emo_ctrl); hold on 
              plot_spc(p12_spc,perc); hold on
              plot_spc(cp12_spc,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
                           
sgtitle('Recall probability by serial position', 'fontweight', 'bold', 'fontsize',20); 

%For R 
dat= [];
dat= [[num2cell(e7_spc(:,7)) num2cell(unique(e7(:,15))) repmat({'7'},length(e7_spc(:,7)),1) repmat({'emotional'},length(e7_spc(:,7)),1) repmat({'oddball'},length(e7_spc(:,7)),1) repmat({'oddball'},length(e7_spc(:,7)),1)];
 [num2cell(e7_spc(:,7-2)) num2cell(unique(e7(:,15))) repmat({'7'},length(e7_spc(:,7-2)),1) repmat({'emotional'},length(e7_spc(:,7-2)),1) repmat({'oddballm2'},length(e7_spc(:,7-2)),1) repmat({'oddball'},length(e7_spc(:,7-2)),1)];
 [num2cell(e7_spc(:,7-1)) num2cell(unique(e7(:,15))) repmat({'7'},length(e7_spc(:,7-1)),1) repmat({'emotional'},length(e7_spc(:,7-1)),1) repmat({'oddballm1'},length(e7_spc(:,7-1)),1) repmat({'oddball'},length(e7_spc(:,7-1)),1)];
 [num2cell(e7_spc(:,7+1)) num2cell(unique(e7(:,15))) repmat({'7'},length(e7_spc(:,7+1)),1) repmat({'emotional'},length(e7_spc(:,7+1)),1) repmat({'oddballp1'},length(e7_spc(:,7+1)),1) repmat({'oddball'},length(e7_spc(:,7+1)),1)];

[num2cell(ce7_spc(:,7)) num2cell(unique(ce7(:,15))) repmat({'7'},length(ce7_spc(:,7)),1) repmat({'emotional'},length(ce7_spc(:,7)),1) repmat({'control'},length(ce7_spc(:,7)),1) repmat({'control'},length(ce7_spc(:,7)),1)];
[num2cell(ce7_spc(:,7-2)) num2cell(unique(ce7(:,15))) repmat({'7'},length(ce7_spc(:,7-2)),1) repmat({'emotional'},length(ce7_spc(:,7-2)),1) repmat({'controlm2'},length(ce7_spc(:,7-2)),1) repmat({'control'},length(ce7_spc(:,7-2)),1)];
[num2cell(ce7_spc(:,7-1)) num2cell(unique(ce7(:,15))) repmat({'7'},length(ce7_spc(:,7-1)),1) repmat({'emotional'},length(ce7_spc(:,7-1)),1) repmat({'controlm1'},length(ce7_spc(:,7-1)),1) repmat({'control'},length(ce7_spc(:,7-1)),1)];
[num2cell(ce7_spc(:,7+1)) num2cell(unique(ce7(:,15))) repmat({'7'},length(ce7_spc(:,7+1)),1) repmat({'emotional'},length(ce7_spc(:,7+1)),1) repmat({'controlp1'},length(ce7_spc(:,7+1)),1) repmat({'control'},length(ce7_spc(:,7+1)),1)];

[num2cell(cp7_spc(:,7)) num2cell(unique(cp7(:,15))) repmat({'7'},length(cp7_spc(:,7)),1) repmat({'perceptual'},length(cp7_spc(:,7)),1) repmat({'control'},length(cp7_spc(:,7)),1) repmat({'control'},length(cp7_spc(:,7)),1)];
[num2cell(cp7_spc(:,7-2)) num2cell(unique(cp7(:,15))) repmat({'7'},length(cp7_spc(:,7-2)),1) repmat({'perceptual'},length(cp7_spc(:,7-2)),1) repmat({'controlm2'},length(cp7_spc(:,7-2)),1) repmat({'control'},length(cp7_spc(:,7-2)),1)];
[num2cell(cp7_spc(:,7-1)) num2cell(unique(cp7(:,15))) repmat({'7'},length(cp7_spc(:,7-1)),1) repmat({'perceptual'},length(cp7_spc(:,7-1)),1) repmat({'controlm1'},length(cp7_spc(:,7-1)),1) repmat({'control'},length(cp7_spc(:,7-1)),1)];
[num2cell(cp7_spc(:,7+1)) num2cell(unique(cp7(:,15))) repmat({'7'},length(cp7_spc(:,7+1)),1) repmat({'perceptual'},length(cp7_spc(:,7+1)),1) repmat({'controlp1'},length(cp7_spc(:,7+1)),1) repmat({'control'},length(cp7_spc(:,7+1)),1)];

[num2cell(p7_spc(:,7)) num2cell(unique(p7(:,15))) repmat({'7'},length(p7_spc(:,7)),1) repmat({'perceptual'},length(p7_spc(:,7)),1) repmat({'oddball'},length(p7_spc(:,7)),1) repmat({'oddball'},length(p7_spc(:,7)),1)];
[num2cell(p7_spc(:,7-2)) num2cell(unique(p7(:,15))) repmat({'7'},length(p7_spc(:,7-2)),1) repmat({'perceptual'},length(p7_spc(:,7-2)),1) repmat({'oddballm2'},length(p7_spc(:,7-2)),1) repmat({'oddball'},length(p7_spc(:,7-2)),1)];
[num2cell(p7_spc(:,7-1)) num2cell(unique(p7(:,15))) repmat({'7'},length(p7_spc(:,7-1)),1) repmat({'perceptual'},length(p7_spc(:,7-1)),1) repmat({'oddballm1'},length(p7_spc(:,7-1)),1) repmat({'oddball'},length(p7_spc(:,7-1)),1)];
[num2cell(p7_spc(:,7+1)) num2cell(unique(p7(:,15))) repmat({'7'},length(p7_spc(:,7+1)),1) repmat({'perceptual'},length(p7_spc(:,7+1)),1) repmat({'oddballp1'},length(p7_spc(:,7+1)),1) repmat({'oddball'},length(p7_spc(:,7+1)),1)];

[num2cell(e8_spc(:,8)) num2cell(unique(e8(:,15))) repmat({'8'},length(e8_spc(:,8)),1) repmat({'emotional'},length(e8_spc(:,8)),1) repmat({'oddball'},length(e8_spc(:,8)),1) repmat({'oddball'},length(e8_spc(:,8)),1)];
[num2cell(e8_spc(:,8-2)) num2cell(unique(e8(:,15))) repmat({'8'},length(e8_spc(:,8-2)),1) repmat({'emotional'},length(e8_spc(:,8-2)),1) repmat({'oddballm2'},length(e8_spc(:,8-2)),1) repmat({'oddball'},length(e8_spc(:,8-2)),1)];
[num2cell(e8_spc(:,8-1)) num2cell(unique(e8(:,15))) repmat({'8'},length(e8_spc(:,8-1)),1) repmat({'emotional'},length(e8_spc(:,8-1)),1) repmat({'oddballm1'},length(e8_spc(:,8-1)),1) repmat({'oddball'},length(e8_spc(:,8-1)),1)];
[num2cell(e8_spc(:,8+1)) num2cell(unique(e8(:,15))) repmat({'8'},length(e8_spc(:,8+1)),1) repmat({'emotional'},length(e8_spc(:,8+1)),1) repmat({'oddballp1'},length(e8_spc(:,8+1)),1) repmat({'oddball'},length(e8_spc(:,8+1)),1)];

[num2cell(ce8_spc(:,8)) num2cell(unique(ce8(:,15))) repmat({'8'},length(ce8_spc(:,8)),1) repmat({'emotional'},length(ce8_spc(:,8)),1) repmat({'control'},length(ce8_spc(:,8)),1) repmat({'control'},length(ce8_spc(:,8)),1)];
[num2cell(ce8_spc(:,8-2)) num2cell(unique(ce8(:,15))) repmat({'8'},length(ce8_spc(:,8-2)),1) repmat({'emotional'},length(ce8_spc(:,8-2)),1) repmat({'controlm2'},length(ce8_spc(:,8-2)),1) repmat({'control'},length(ce8_spc(:,8-2)),1)];
[num2cell(ce8_spc(:,8-1)) num2cell(unique(ce8(:,15))) repmat({'8'},length(ce8_spc(:,8-1)),1) repmat({'emotional'},length(ce8_spc(:,8-1)),1) repmat({'controlm1'},length(ce8_spc(:,8-1)),1) repmat({'control'},length(ce8_spc(:,8-1)),1)];
[num2cell(ce8_spc(:,8+1)) num2cell(unique(ce8(:,15))) repmat({'8'},length(ce8_spc(:,8+1)),1) repmat({'emotional'},length(ce8_spc(:,8+1)),1) repmat({'controlp1'},length(ce8_spc(:,8+1)),1) repmat({'control'},length(ce8_spc(:,8+1)),1)];

[num2cell(p8_spc(:,8)) num2cell(unique(p8(:,15))) repmat({'8'},length(p8_spc(:,8)),1) repmat({'perceptual'},length(p8_spc(:,8)),1) repmat({'oddball'},length(p8_spc(:,8)),1) repmat({'oddball'},length(p8_spc(:,8)),1)];
[num2cell(p8_spc(:,8-2)) num2cell(unique(p8(:,15))) repmat({'8'},length(p8_spc(:,8-2)),1) repmat({'perceptual'},length(p8_spc(:,8-2)),1) repmat({'oddballm2'},length(p8_spc(:,8-2)),1) repmat({'oddball'},length(p8_spc(:,8-2)),1)];
[num2cell(p8_spc(:,8-1)) num2cell(unique(p8(:,15))) repmat({'8'},length(p8_spc(:,8-1)),1) repmat({'perceptual'},length(p8_spc(:,8-1)),1) repmat({'oddballm1'},length(p8_spc(:,8-1)),1) repmat({'oddball'},length(p8_spc(:,8-1)),1)];
[num2cell(p8_spc(:,8+1)) num2cell(unique(p8(:,15))) repmat({'8'},length(p8_spc(:,8+1)),1) repmat({'perceptual'},length(p8_spc(:,8+1)),1) repmat({'oddballp1'},length(p8_spc(:,8+1)),1) repmat({'oddball'},length(p8_spc(:,8+1)),1)];

[num2cell(cp8_spc(:,8)) num2cell(unique(cp8(:,15))) repmat({'8'},length(cp8_spc(:,8)),1) repmat({'perceptual'},length(cp8_spc(:,8)),1) repmat({'control'},length(cp8_spc(:,8)),1) repmat({'control'},length(cp8_spc(:,8)),1)];
[num2cell(cp8_spc(:,8-2)) num2cell(unique(cp8(:,15))) repmat({'8'},length(cp8_spc(:,8-2)),1) repmat({'perceptual'},length(cp8_spc(:,8-2)),1) repmat({'controlm2'},length(cp8_spc(:,8-2)),1) repmat({'control'},length(cp8_spc(:,8-2)),1)];
[num2cell(cp8_spc(:,8-1)) num2cell(unique(cp8(:,15))) repmat({'8'},length(cp8_spc(:,8-1)),1) repmat({'perceptual'},length(cp8_spc(:,8-1)),1) repmat({'controlm1'},length(cp8_spc(:,8-1)),1) repmat({'control'},length(cp8_spc(:,8-1)),1)];
[num2cell(cp8_spc(:,8+1)) num2cell(unique(cp8(:,15))) repmat({'8'},length(cp8_spc(:,8+1)),1) repmat({'perceptual'},length(cp8_spc(:,8+1)),1) repmat({'controlp1'},length(cp8_spc(:,8+1)),1) repmat({'control'},length(cp8_spc(:,8+1)),1)];

[num2cell(e11_spc(:,11)) num2cell(unique(e11(:,15))) repmat({'11'},length(e11_spc(:,11)),1) repmat({'emotional'},length(e11_spc(:,11)),1) repmat({'oddball'},length(e11_spc(:,11)),1) repmat({'oddball'},length(e11_spc(:,11)),1)];
[num2cell(e11_spc(:,11-2)) num2cell(unique(e11(:,15))) repmat({'11'},length(e11_spc(:,11-2)),1) repmat({'emotional'},length(e11_spc(:,11-2)),1) repmat({'oddballm2'},length(e11_spc(:,11-2)),1) repmat({'oddball'},length(e11_spc(:,11-2)),1)];
[num2cell(e11_spc(:,11-1)) num2cell(unique(e11(:,15))) repmat({'11'},length(e11_spc(:,11-1)),1) repmat({'emotional'},length(e11_spc(:,11-1)),1) repmat({'oddballm1'},length(e11_spc(:,11-1)),1) repmat({'oddball'},length(e11_spc(:,11-1)),1)];
[num2cell(e11_spc(:,11+1)) num2cell(unique(e11(:,15))) repmat({'11'},length(e11_spc(:,11+1)),1) repmat({'emotional'},length(e11_spc(:,11+1)),1) repmat({'oddballp1'},length(e11_spc(:,11+1)),1) repmat({'oddball'},length(e11_spc(:,11+1)),1)];

[num2cell(ce11_spc(:,11)) num2cell(unique(ce11(:,15))) repmat({'11'},length(ce11_spc(:,11)),1) repmat({'emotional'},length(ce11_spc(:,11)),1) repmat({'control'},length(ce11_spc(:,11)),1) repmat({'control'},length(ce11_spc(:,11)),1)];
[num2cell(ce11_spc(:,11-2)) num2cell(unique(ce11(:,15))) repmat({'11'},length(ce11_spc(:,11-2)),1) repmat({'emotional'},length(ce11_spc(:,11-2)),1) repmat({'controlm2'},length(ce11_spc(:,11-2)),1) repmat({'control'},length(ce11_spc(:,11-2)),1)];
[num2cell(ce11_spc(:,11-1)) num2cell(unique(ce11(:,15))) repmat({'11'},length(ce11_spc(:,11-1)),1) repmat({'emotional'},length(ce11_spc(:,11-1)),1) repmat({'controlm1'},length(ce11_spc(:,11-1)),1) repmat({'control'},length(ce11_spc(:,11-1)),1)];
[num2cell(ce11_spc(:,11+1)) num2cell(unique(ce11(:,15))) repmat({'11'},length(ce11_spc(:,11+1)),1) repmat({'emotional'},length(ce11_spc(:,11+1)),1) repmat({'controlp1'},length(ce11_spc(:,11+1)),1) repmat({'control'},length(ce11_spc(:,11+1)),1)];

[num2cell(p11_spc(:,11)) num2cell(unique(p11(:,15))) repmat({'11'},length(p11_spc(:,11)),1) repmat({'perceptual'},length(p11_spc(:,11)),1) repmat({'oddball'},length(p11_spc(:,11)),1) repmat({'oddball'},length(p11_spc(:,11)),1)];
[num2cell(p11_spc(:,11-2)) num2cell(unique(p11(:,15))) repmat({'11'},length(p11_spc(:,11-2)),1) repmat({'perceptual'},length(p11_spc(:,11-2)),1) repmat({'oddballm2'},length(p11_spc(:,11-2)),1) repmat({'oddball'},length(p11_spc(:,11-2)),1)];
[num2cell(p11_spc(:,11-1)) num2cell(unique(p11(:,15))) repmat({'11'},length(p11_spc(:,11-1)),1) repmat({'perceptual'},length(p11_spc(:,11-1)),1) repmat({'oddballm1'},length(p11_spc(:,11-1)),1) repmat({'oddball'},length(p11_spc(:,11-1)),1)];
[num2cell(p11_spc(:,11+1)) num2cell(unique(p11(:,15))) repmat({'11'},length(p11_spc(:,11+1)),1) repmat({'perceptual'},length(p11_spc(:,11+1)),1) repmat({'oddballp1'},length(p11_spc(:,11+1)),1) repmat({'oddball'},length(p11_spc(:,11+1)),1)];

[num2cell(cp11_spc(:,11)) num2cell(unique(cp11(:,15))) repmat({'11'},length(cp11_spc(:,11)),1) repmat({'perceptual'},length(cp11_spc(:,11)),1) repmat({'control'},length(cp11_spc(:,11)),1) repmat({'control'},length(cp11_spc(:,11)),1)];
[num2cell(cp11_spc(:,11-2)) num2cell(unique(cp11(:,15))) repmat({'11'},length(cp11_spc(:,11-2)),1) repmat({'perceptual'},length(cp11_spc(:,11-2)),1) repmat({'controlm2'},length(cp11_spc(:,11-2)),1) repmat({'control'},length(cp11_spc(:,11-2)),1)];
[num2cell(cp11_spc(:,11-1)) num2cell(unique(cp11(:,15))) repmat({'11'},length(cp11_spc(:,11-1)),1) repmat({'perceptual'},length(cp11_spc(:,11-1)),1) repmat({'controlm1'},length(cp11_spc(:,11-1)),1) repmat({'control'},length(cp11_spc(:,11-1)),1)];
[num2cell(cp11_spc(:,11+1)) num2cell(unique(cp11(:,15))) repmat({'11'},length(cp11_spc(:,11+1)),1) repmat({'perceptual'},length(cp11_spc(:,11+1)),1) repmat({'controlp1'},length(cp11_spc(:,11+1)),1) repmat({'control'},length(cp11_spc(:,11+1)),1)];

[num2cell(e12_spc(:,11)) num2cell(unique(e12(:,15))) repmat({'12'},length(e12_spc(:,12)),1) repmat({'emotional'},length(e12_spc(:,12)),1) repmat({'oddball'},length(e12_spc(:,12)),1) repmat({'oddball'},length(e12_spc(:,12)),1)];
[num2cell(e12_spc(:,11-2)) num2cell(unique(e12(:,15))) repmat({'12'},length(e12_spc(:,12-2)),1) repmat({'emotional'},length(e12_spc(:,12-2)),1) repmat({'oddballm2'},length(e12_spc(:,12-2)),1) repmat({'oddball'},length(e12_spc(:,12-2)),1)];
[num2cell(e12_spc(:,11-1)) num2cell(unique(e12(:,15))) repmat({'12'},length(e12_spc(:,12-1)),1) repmat({'emotional'},length(e12_spc(:,12-1)),1) repmat({'oddballm1'},length(e12_spc(:,12-1)),1) repmat({'oddball'},length(e12_spc(:,12-1)),1)];
[num2cell(e12_spc(:,11+1)) num2cell(unique(e12(:,15))) repmat({'12'},length(e12_spc(:,12+1)),1) repmat({'emotional'},length(e12_spc(:,12+1)),1) repmat({'oddballp1'},length(e12_spc(:,12+1)),1) repmat({'oddball'},length(e12_spc(:,12+1)),1)];

[num2cell(ce12_spc(:,12)) num2cell(unique(ce12(:,15))) repmat({'12'},length(ce12_spc(:,12)),1) repmat({'emotional'},length(ce12_spc(:,12)),1) repmat({'control'},length(ce12_spc(:,12)),1) repmat({'control'},length(ce12_spc(:,12)),1)];
[num2cell(ce12_spc(:,12-2)) num2cell(unique(ce12(:,15))) repmat({'12'},length(ce12_spc(:,12-2)),1) repmat({'emotional'},length(ce12_spc(:,12-2)),1) repmat({'controlm2'},length(ce12_spc(:,12-2)),1) repmat({'control'},length(ce12_spc(:,12-2)),1)];
[num2cell(ce12_spc(:,12-1)) num2cell(unique(ce12(:,15))) repmat({'12'},length(ce12_spc(:,12-1)),1) repmat({'emotional'},length(ce12_spc(:,12-1)),1) repmat({'controlm1'},length(ce12_spc(:,12-1)),1) repmat({'control'},length(ce12_spc(:,12-1)),1)];
[num2cell(ce12_spc(:,12+1)) num2cell(unique(ce12(:,15))) repmat({'12'},length(ce12_spc(:,12+1)),1) repmat({'emotional'},length(ce12_spc(:,12+1)),1) repmat({'controlp1'},length(ce12_spc(:,12+1)),1) repmat({'control'},length(ce12_spc(:,12+1)),1)];

[num2cell(p12_spc(:,12)) num2cell(unique(p12(:,15))) repmat({'12'},length(p12_spc(:,12)),1) repmat({'perceptual'},length(p12_spc(:,12)),1) repmat({'oddball'},length(p12_spc(:,12)),1) repmat({'oddball'},length(p12_spc(:,12)),1)];
[num2cell(p12_spc(:,12-2)) num2cell(unique(p12(:,15))) repmat({'12'},length(p12_spc(:,12-2)),1) repmat({'perceptual'},length(p12_spc(:,12-2)),1) repmat({'oddballm2'},length(p12_spc(:,12-2)),1) repmat({'oddball'},length(p12_spc(:,12-2)),1)];
[num2cell(p12_spc(:,12-1)) num2cell(unique(p12(:,15))) repmat({'12'},length(p12_spc(:,12-1)),1) repmat({'perceptual'},length(p12_spc(:,12-1)),1) repmat({'oddballm1'},length(p12_spc(:,12-1)),1) repmat({'oddball'},length(p12_spc(:,12-1)),1)];
[num2cell(p12_spc(:,12+1)) num2cell(unique(p12(:,15))) repmat({'12'},length(p12_spc(:,12+1)),1) repmat({'perceptual'},length(p12_spc(:,12+1)),1) repmat({'oddballp1'},length(p12_spc(:,12+1)),1) repmat({'oddball'},length(p12_spc(:,12+1)),1)];

[num2cell(cp12_spc(:,12)) num2cell(unique(cp12(:,15))) repmat({'12'},length(cp12_spc(:,12)),1) repmat({'perceptual'},length(cp12_spc(:,11)),1) repmat({'control'},length(cp12_spc(:,12)),1) repmat({'control'},length(cp12_spc(:,12)),1)]
[num2cell(cp12_spc(:,12-2)) num2cell(unique(cp12(:,15))) repmat({'12'},length(cp12_spc(:,12-2)),1) repmat({'perceptual'},length(cp12_spc(:,12-2)),1) repmat({'controlm2'},length(cp12_spc(:,12-2)),1) repmat({'control'},length(cp12_spc(:,12-2)),1)]
[num2cell(cp12_spc(:,12-1)) num2cell(unique(cp12(:,15))) repmat({'12'},length(cp12_spc(:,12-1)),1) repmat({'perceptual'},length(cp12_spc(:,12-1)),1) repmat({'controlm1'},length(cp12_spc(:,12-1)),1) repmat({'control'},length(cp12_spc(:,12-1)),1)]
[num2cell(cp12_spc(:,12+1)) num2cell(unique(cp12(:,15))) repmat({'12'},length(cp12_spc(:,12+1)),1) repmat({'perceptual'},length(cp12_spc(:,12+1)),1) repmat({'controlp1'},length(cp12_spc(:,12+1)),1) repmat({'control'},length(cp12_spc(:,12+1)),1)]];

dat= array2table(dat,'VariableNames',{'recprob','subject','encpos','list_type','item','oddvctrl'});

cd '/Raw_Results'
%writetable(dat,'recall_probability_R.csv')

%% Now plot probability of first recall for data visualization purposes
figure('Position', [198, 292, 802, 505]); 
subplot(231); plot_spc(e7_pfr,emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_pfr,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(232); plot_spc(e8_pfr,emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p8_pfr,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(233); plot_spc(e9_pfr,emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_pfr,perc); hold off
              legend('Emotional', 'Perceptual')
              
subplot(234); plot_spc(e11_pfr,emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_pfr,perc); hold off
              legend('Emotional','Perceptual')
              
subplot(235); plot_spc(e12_pfr,emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_pfr,perc); hold off
              legend('Emotional','Perceptual')
              
sgtitle('Probability of first recall by serial position', 'fontweight', 'bold', 'fontsize',20); 

% Now let's compare it to controls % 
t=figure('Position', [198, 324, 1139, 473]); 

% Add errorbars
emo.errorbars = std(e7_pfr); 
emo_ctrl.errorbars = std(ce7_pfr); 
perc.errorbars = std(p7_pfr); 
perc_ctrl.errorbars = std(cp7_pfr); 

subplot(221); plot_spc(e7_pfr,emo); title('Encoding position = 7'); hold on 
              plot_spc(ce7_pfr,emo_ctrl); hold on 
              plot_spc(p7_pfr,perc); hold on 
              plot_spc(cp7_pfr,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              ylim([-0.2 0.7])
              
% Add errorbars
emo.errorbars = std(e8_pfr); 
emo_ctrl.errorbars = std(ce8_pfr); 
perc.errorbars = std(p8_pfr); 
perc_ctrl.errorbars = std(cp8_pfr);               
              
subplot(222); plot_spc(e8_pfr,emo); title('Encoding position = 8'); hold on 
              plot_spc(ce8_pfr,emo_ctrl); hold on 
              plot_spc(p8_pfr,perc); hold on 
              plot_spc(cp8_pfr,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              ylim([-0.2 0.7])
              
% Add errorbars
emo.errorbars = std(e11_pfr); 
emo_ctrl.errorbars = std(ce11_pfr); 
perc.errorbars = std(p11_pfr); 
perc_ctrl.errorbars = std(cp11_pfr);
              
subplot(223); plot_spc(e11_pfr,emo); title('Encoding position = 11'); hold on 
              plot_spc(ce11_pfr,emo_ctrl); hold on 
              plot_spc(p11_pfr,perc); hold on
              plot_spc(cp11_pfr,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              ylim([-0.2 0.7])
              
% Add errorbars
emo.errorbars = std(e12_pfr); 
emo_ctrl.errorbars = std(ce12_pfr); 
perc.errorbars = std(p12_pfr); 
perc_ctrl.errorbars = std(cp12_pfr);              
              
subplot(224); plot_spc(e12_pfr,emo); title('Encoding position = 12'); hold on 
              plot_spc(ce12_pfr,emo_ctrl); hold on 
              plot_spc(p12_pfr,perc); hold on
              plot_spc(cp12_pfr,perc_ctrl); hold off
              legend('Emotional oddball','Emotional control', 'Perceptual oddball', 'Perceptual control','location','northeastoutside')
              ylim([-0.2 0.7])
sgtitle('Probability of first recall by serial position', 'fontweight', 'bold', 'fontsize',20); 

%%
%%%%%% Now let's plot it split by SOA  %%%%%% 

% Emotional Oddballs 
soa = unique(e11(:,18));
i = []; dat = []; where = []; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = e11(:,18) == soanum;
    dat = e11(where,:);
    
    e11_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e11_soa{i,2} = soanum; 
    e11_soa{i,3} = unique(dat(:,15));
    where=[]; dat = []; 
    
    where = e12(:,18) == soanum;
    dat = e12(where,:); 
    
    e12_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e12_soa{i,2} = soanum; 
    e12_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = e9(:,18) == soanum;
    dat = e9(where,:); 
    
    e9_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e9_soa{i,2} = soanum; 
    e9_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = e8(:,18) == soanum;
    dat = e8(where,:);
    
    e8_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e8_soa{i,2} = soanum; 
    e8_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = e7(:,18) == soanum;
    dat = e7(where,:);
    
    e7_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e7_soa{i,2} = soanum; 
    e7_soa{i,3} = unique(dat(:,15));

    where=[]; dat = []; 
    
    %control emotional data
    where = ce7(:,18) == soanum; 
    dat = ce7(where,:); 
    
    ce7_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    ce7_soa{i,2} = soanum; 
    ce7_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = ce8(:,18) == soanum; 
    dat = ce8(where,:); 
    
    ce8_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    ce8_soa{i,2} = soanum; 
    ce8_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = ce11(:,18) == soanum; 
    dat = ce11(where,:); 
    
    ce11_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    ce11_soa{i,2} = soanum; 
    ce11_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = ce12(:,18) == soanum; 
    dat = ce12(where,:); 
    
    ce12_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    ce12_soa{i,2} = soanum; 
    ce12_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = ce13(:,18) == soanum; 
    dat = ce13(where,:); 
    
    ce13_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    ce13_soa{i,2} = soanum; 
    ce13_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
       
end 

%%%% Perceptual oddballs 
i = []; where = []; dat =[]; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = p11(:,18) == soanum;
    dat = p11(where,:);
    
    p11_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p11_soa{i,2} = soanum; 
    p11_soa{i,3} = unique(dat(:,15));

    where=[]; dat = []; 
    
    where = p12(:,18) == soanum;
    dat = p12(where,:); 
    
    p12_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p12_soa{i,2} = soanum; 
    p12_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = p9(:,18) == soanum;
    dat = p9(where,:); 
    
    p9_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p9_soa{i,2} = soanum;
    p9_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = p8(:,18) == soanum;
    dat = p8(where,:);
    
    p8_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p8_soa{i,2} = soanum; 
    p8_soa{i,3} = unique(dat(:,15));

    where=[]; dat = [];
    
    where = p7(:,18) == soanum;
    dat = p7(where,:);
    
    p7_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p7_soa{i,2} = soanum; 
    p7_soa{i,3} = unique(dat(:,15));

    where=[]; dat = []; 
    
    % control perceptual data 
    where = cp7(:,18) == soanum; 
    dat = cp7(where,:); 
    
    cp7_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    cp7_soa{i,2} = soanum; 
    cp7_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = cp8(:,18) == soanum; 
    dat = cp8(where,:); 
    
    cp8_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    cp8_soa{i,2} = soanum; 
    cp8_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = cp11(:,18) == soanum; 
    dat = cp11(where,:); 
    
    cp11_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    cp11_soa{i,2} = soanum; 
    cp11_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = cp12(:,18) == soanum; 
    dat = cp12(where,:); 
    
    cp12_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    cp12_soa{i,2} = soanum;
    cp12_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
    
    where = cp13(:,18) == soanum; 
    dat = cp13(where,:); 
    
    cp13_soa{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    cp13_soa{i,2} = soanum; 
    cp13_soa{i,3} = unique(dat(:,15));

    where = []; dat = []; 
       
end 

%%%%%%%%%% Reorganize the data for R %%%%%%%%%%%%%%
i = []; data = {}; dat = {}; 

for i = 1:5; % for all SOAs 
    
    %Emotional lists 
    %enc pos 7 
    dat(:,1) = [num2cell(e7_soa{i,1}(:,7)); num2cell(e7_soa{i,1}(:,7-1)); num2cell(e7_soa{i,1}(:,7-2)); num2cell(e7_soa{i,1}(:,7+1))]; 
    dat(:,2) = num2cell(repmat(e7_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'7'},length(e7_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(e7_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(e7_soa{i,3}),1) ; repmat({'oddball-1'},length(e7_soa{i,3}),1); repmat({'oddball-2'},length(e7_soa{i,3}),1); repmat({'oddball+1'},length(e7_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(e7_soa{i,2}, length(e7_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 8
    dat(:,1) = [num2cell(e8_soa{i,1}(:,8)); num2cell(e8_soa{i,1}(:,8-1)); num2cell(e8_soa{i,1}(:,8-2)); num2cell(e8_soa{i,1}(:,8+1))]; 
    dat(:,2) = num2cell(repmat(e8_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'8'},length(e8_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(e8_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(e8_soa{i,3}),1) ; repmat({'oddball-1'},length(e8_soa{i,3}),1); repmat({'oddball-2'},length(e8_soa{i,3}),1); repmat({'oddball+1'},length(e8_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(e8_soa{i,2}, length(e8_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 11
    dat(:,1) = [num2cell(e11_soa{i,1}(:,11)); num2cell(e11_soa{i,1}(:,11-1)); num2cell(e11_soa{i,1}(:,11-2)); num2cell(e11_soa{i,1}(:,11+1))]; 
    dat(:,2) = num2cell(repmat(e11_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'11'},length(e11_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(e11_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(e11_soa{i,3}),1) ; repmat({'oddball-1'},length(e11_soa{i,3}),1); repmat({'oddball-2'},length(e11_soa{i,3}),1); repmat({'oddball+1'},length(e11_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(e11_soa{i,2}, length(e11_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 12
    dat(:,1) = [num2cell(e12_soa{i,1}(:,12)); num2cell(e12_soa{i,1}(:,12-1)); num2cell(e12_soa{i,1}(:,12-2)); num2cell(e12_soa{i,1}(:,12+1))]; 
    dat(:,2) = num2cell(repmat(e12_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'12'},length(e12_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(e12_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(e12_soa{i,3}),1) ; repmat({'oddball-1'},length(e12_soa{i,3}),1); repmat({'oddball-2'},length(e12_soa{i,3}),1); repmat({'oddball+1'},length(e12_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(e12_soa{i,2}, length(e12_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    % Control emotional words
    %enc pos 7
    dat(:,1) = [num2cell(ce7_soa{i,1}(:,7)); num2cell(ce7_soa{i,1}(:,7-1)); num2cell(ce7_soa{i,1}(:,7-2)); num2cell(ce7_soa{i,1}(:,7+1))]; 
    dat(:,2) = num2cell(repmat(ce7_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'7'},length(ce7_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(ce7_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(ce7_soa{i,3}),1) ; repmat({'control-1'},length(ce7_soa{i,3}),1); repmat({'control-2'},length(ce7_soa{i,3}),1); repmat({'control+1'},length(ce7_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(ce7_soa{i,2}, length(ce7_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 

    %enc pos 8
    dat(:,1) = [num2cell(ce8_soa{i,1}(:,8)); num2cell(ce8_soa{i,1}(:,8-1)); num2cell(ce8_soa{i,1}(:,8-2)); num2cell(ce8_soa{i,1}(:,8+1))]; 
    dat(:,2) = num2cell(repmat(ce8_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'8'},length(ce8_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(ce8_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(ce8_soa{i,3}),1) ; repmat({'control-1'},length(ce8_soa{i,3}),1); repmat({'control-2'},length(ce8_soa{i,3}),1); repmat({'control+1'},length(ce8_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(ce8_soa{i,2}, length(ce8_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 11
    dat(:,1) = [num2cell(ce11_soa{i,1}(:,11)); num2cell(ce11_soa{i,1}(:,11-1)); num2cell(ce11_soa{i,1}(:,11-2)); num2cell(ce11_soa{i,1}(:,11+1))]; 
    dat(:,2) = num2cell(repmat(ce11_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'11'},length(ce11_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(ce11_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(ce11_soa{i,3}),1) ; repmat({'control-1'},length(ce11_soa{i,3}),1); repmat({'control-2'},length(ce11_soa{i,3}),1); repmat({'control+1'},length(ce11_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(ce11_soa{i,2}, length(ce11_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 12
    dat(:,1) = [num2cell(ce12_soa{i,1}(:,12)); num2cell(ce12_soa{i,1}(:,12-1)); num2cell(ce12_soa{i,1}(:,12-2)); num2cell(ce12_soa{i,1}(:,12+1))]; 
    dat(:,2) = num2cell(repmat(ce12_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'12'},length(ce12_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'emotional'},length(ce12_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(ce12_soa{i,3}),1) ; repmat({'control-1'},length(ce12_soa{i,3}),1); repmat({'control-2'},length(ce12_soa{i,3}),1); repmat({'control+1'},length(ce12_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(ce12_soa{i,2}, length(ce12_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    % Perceptual 
    %enc pos 7
    dat(:,1) = [num2cell(p7_soa{i,1}(:,7)); num2cell(p7_soa{i,1}(:,7-1)); num2cell(p7_soa{i,1}(:,7-2)); num2cell(p7_soa{i,1}(:,7+1))]; 
    dat(:,2) = num2cell(repmat(p7_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'7'},length(p7_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(p7_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(p7_soa{i,3}),1) ; repmat({'oddball-1'},length(p7_soa{i,3}),1); repmat({'oddball-2'},length(p7_soa{i,3}),1); repmat({'oddball+1'},length(p7_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(p7_soa{i,2}, length(p7_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 8
    dat(:,1) = [num2cell(p8_soa{i,1}(:,8)); num2cell(p8_soa{i,1}(:,8-1)); num2cell(p8_soa{i,1}(:,8-2)); num2cell(p8_soa{i,1}(:,8+1))]; 
    dat(:,2) = num2cell(repmat(p8_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'8'},length(p8_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(p8_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(p8_soa{i,3}),1) ; repmat({'oddball-1'},length(p8_soa{i,3}),1); repmat({'oddball-2'},length(p8_soa{i,3}),1); repmat({'oddball+1'},length(p8_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(p8_soa{i,2}, length(p8_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 11
    dat(:,1) = [num2cell(p11_soa{i,1}(:,11)); num2cell(p11_soa{i,1}(:,11-1)); num2cell(p11_soa{i,1}(:,11-2)); num2cell(p11_soa{i,1}(:,11+1))]; 
    dat(:,2) = num2cell(repmat(p11_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'11'},length(p11_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(p11_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(p11_soa{i,3}),1) ; repmat({'oddball-1'},length(p11_soa{i,3}),1); repmat({'oddball-2'},length(p11_soa{i,3}),1); repmat({'oddball+1'},length(p11_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(p11_soa{i,2}, length(p11_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 12
    dat(:,1) = [num2cell(p12_soa{i,1}(:,12)); num2cell(p12_soa{i,1}(:,12-1)); num2cell(p12_soa{i,1}(:,12-2)); num2cell(p12_soa{i,1}(:,12+1))]; 
    dat(:,2) = num2cell(repmat(p12_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'12'},length(p12_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(p12_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'oddball'},length(p12_soa{i,3}),1) ; repmat({'oddball-1'},length(p12_soa{i,3}),1); repmat({'oddball-2'},length(p12_soa{i,3}),1); repmat({'oddball+1'},length(p12_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(p12_soa{i,2}, length(p12_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %Control perceptual words 
    %enc pos 7
    dat(:,1) = [num2cell(cp7_soa{i,1}(:,7)); num2cell(cp7_soa{i,1}(:,7-1)); num2cell(cp7_soa{i,1}(:,7-2)); num2cell(cp7_soa{i,1}(:,7+1))]; 
    dat(:,2) = num2cell(repmat(cp7_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'7'},length(cp7_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(cp7_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(cp7_soa{i,3}),1) ; repmat({'control-1'},length(cp7_soa{i,3}),1); repmat({'control-2'},length(cp7_soa{i,3}),1); repmat({'control+1'},length(cp7_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(cp7_soa{i,2}, length(cp7_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 8
    dat(:,1) = [num2cell(cp8_soa{i,1}(:,8)); num2cell(cp8_soa{i,1}(:,8-1)); num2cell(cp8_soa{i,1}(:,8-2)); num2cell(cp8_soa{i,1}(:,8+1))]; 
    dat(:,2) = num2cell(repmat(cp8_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'8'},length(cp8_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(cp8_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(cp8_soa{i,3}),1) ; repmat({'control-1'},length(cp8_soa{i,3}),1); repmat({'control-2'},length(cp8_soa{i,3}),1); repmat({'control+1'},length(cp8_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(cp8_soa{i,2}, length(cp8_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 11
    dat(:,1) = [num2cell(cp11_soa{i,1}(:,11)); num2cell(cp11_soa{i,1}(:,11-1)); num2cell(cp11_soa{i,1}(:,11-2)); num2cell(cp11_soa{i,1}(:,11+1))]; 
    dat(:,2) = num2cell(repmat(cp11_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'11'},length(cp11_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(cp11_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(cp11_soa{i,3}),1) ; repmat({'control-1'},length(cp11_soa{i,3}),1); repmat({'control-2'},length(cp11_soa{i,3}),1); repmat({'control+1'},length(cp11_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(cp11_soa{i,2}, length(cp11_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 
    
    %enc pos 12
    dat(:,1) = [num2cell(cp12_soa{i,1}(:,12)); num2cell(cp12_soa{i,1}(:,12-1)); num2cell(cp12_soa{i,1}(:,12-2)); num2cell(cp12_soa{i,1}(:,12+1))]; 
    dat(:,2) = num2cell(repmat(cp12_soa{i,3},4,1)); %subjects 
    dat(:,3) = repmat({'12'},length(cp12_soa{i,3})*4,1); %enc position
    dat(:,4) = repmat({'perceptual'},length(cp12_soa{i,3})*4,1); %List type 
    dat(:,5) = [repmat({'control'},length(cp12_soa{i,3}),1) ; repmat({'control-1'},length(cp12_soa{i,3}),1); repmat({'control-2'},length(cp12_soa{i,3}),1); repmat({'control+1'},length(cp12_soa{i,3}),1)];
    dat(:,6) = num2cell(repmat(cp12_soa{i,2}, length(cp12_soa{i,3})*4,1)); %SOA
    
    data = [data; dat]; dat = {}; 

    
end 

dat= array2table(data,'VariableNames',{'recprob','subject','encpos','list_type','item', 'soa'});

cd '/Raw_Results'
%writetable(dat,'recall_probability_SOA_R.csv')

%%%%%%%%%%%%%

% Now let's plot it % 
% SOA 1% 
figure('Position', [148   302   852   495]); 
subplot(231); plot_spc(e7_soa{1,1},emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_soa{1,1},perc); hold off 
              
subplot(232); plot_spc(e8_soa{1,1},emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p9_soa{1,1},perc); hold off
              
subplot(233); plot_spc(e9_soa{1,1},emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_soa{1,1},perc); hold off
              
subplot(234); plot_spc(e11_soa{1,1},emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_soa{1,1},perc); hold off
              
subplot(235); plot_spc(e12_soa{1,1},emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_soa{1,1},perc); hold off
sgtitle('Recall probability by serial position SOA = 1', 'fontweight', 'bold', 'fontsize',20); 

% SOA 2 % 
figure('Position', [148   302   852   495]); 
subplot(231); plot_spc(e7_soa{2,1},emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_soa{2,1},perc); hold off 
              
subplot(232); plot_spc(e8_soa{2,1},emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p9_soa{2,1},perc); hold off
              
subplot(233); plot_spc(e9_soa{2,1},emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_soa{2,1},perc); hold off
              
subplot(234); plot_spc(e11_soa{2,1},emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_soa{2,1},perc); hold off
              
subplot(235); plot_spc(e12_soa{2,1},emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_soa{2,1},perc); hold off
sgtitle('Recall probability by serial position SOA = 2', 'fontweight', 'bold', 'fontsize',20);

% SOA 3 
figure('Position', [148   302   852   495]); 
subplot(231); plot_spc(e7_soa{3,1},emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_soa{3,1},perc); hold off 
              
subplot(232); plot_spc(e8_soa{3,1},emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p9_soa{3,1},perc); hold off
              
subplot(233); plot_spc(e9_soa{3,1},emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_soa{3,1},perc); hold off
              
subplot(234); plot_spc(e11_soa{3,1},emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_soa{3,1},perc); hold off
              
subplot(235); plot_spc(e12_soa{3,1},emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_soa{3,1},perc); hold off
sgtitle('Recall probability by serial position SOA = 3', 'fontweight', 'bold', 'fontsize',20);

% SOA 4
figure('Position', [148   302   852   495]); 
subplot(231); plot_spc(e7_soa{4,1},emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_soa{4,1},perc); hold off 
              
subplot(232); plot_spc(e8_soa{4,1},emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p9_soa{4,1},perc); hold off
              
subplot(233); plot_spc(e9_soa{4,1},emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_soa{4,1},perc); hold off
              
subplot(234); plot_spc(e11_soa{4,1},emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_soa{4,1},perc); hold off
              
subplot(235); plot_spc(e12_soa{4,1},emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_soa{4,1},perc); hold off
sgtitle('Recall probability by serial position SOA = 4', 'fontweight', 'bold', 'fontsize',20);

% SOA 6
figure('Position', [148   302   852   495]); 
subplot(231); plot_spc(e7_soa{5,1},emo); title('Odd. encoding position = 7'); hold on 
              plot_spc(p7_soa{5,1},perc); hold off 
              
subplot(232); plot_spc(e8_soa{5,1},emo); title('Odd. encoding position = 8'); hold on 
              plot_spc(p9_soa{5,1},perc); hold off
              
subplot(233); plot_spc(e9_soa{5,1},emo); title('Odd. encoding position = 9'); hold on 
              plot_spc(p9_soa{5,1},perc); hold off
              
subplot(234); plot_spc(e11_soa{5,1},emo); title('Odd. encoding position = 11'); hold on 
              plot_spc(p11_soa{5,1},perc); hold off
              
subplot(235); plot_spc(e12_soa{5,1},emo); title('Odd. encoding position = 12'); hold on 
              plot_spc(p12_soa{5,1},perc); hold off
sgtitle('Recall probability by serial position SOA = 6', 'fontweight', 'bold', 'fontsize',20);



%%%%%% Now let's plot the probability of recall by serial position when the
%%%%%% oddball was recalled and forgotten.

%%%% Emotional Oddballs %%%% 
clearvars -except emo perc emotional_v1_CRP perceptual_v1_CRP positions list_length

j = []; oddnum = []; 

for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
emo_forgotten=emotional_v1_CRP(cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :);
emo_recalled=emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :);

i= []; where_rec = []; where_forg = []; data_rec = []; data_forg = []; 

for i = 1:length(positions); 
    pos = positions(i); 
    where_rec = strcmp(emo_recalled(:,19), pos);
    data_rec{i,1} = emo_recalled(where_rec,:);
    data_rec{i,2} = pos; 
    
    where_forg = strcmp(emo_forgotten(:,19), pos); 
    data_forg{i,1} = emo_forgotten(where_forg,:); 
    data_forg{i,2} = pos;
end 

% Recalled
e11_rec = str2double(data_rec{1,1}); 
e12_rec = str2double(data_rec{2,1}); 
e7_rec = str2double(data_rec{3,1}); 
e8_rec = str2double(data_rec{4,1}); 
e9_rec = str2double(data_rec{5,1});

e7_spc_rec = spc(e7_rec(:,1:14), e7_rec(:,15), list_length); 
e8_spc_rec = spc(e8_rec(:,1:14), e8_rec(:,15), list_length); 
e9_spc_rec = spc(e9_rec(:,1:14), e9_rec(:,15), list_length); 
e11_spc_rec = spc(e11_rec(:,1:14), e11_rec(:,15), list_length); 
e12_spc_rec = spc(e12_rec(:,1:14), e12_rec(:,15), list_length); 


% Forgotten

e11_forg = str2double(data_forg{1,1}); 
e12_forg = str2double(data_forg{2,1}); 
e7_forg = str2double(data_forg{3,1}); 
e8_forg = str2double(data_forg{4,1}); 
e9_forg = str2double(data_forg{5,1});

e7_spc_forg = spc(e7_forg(:,1:14), e7_forg(:,15), list_length); 
e8_spc_forg = spc(e8_forg(:,1:14), e8_forg(:,15), list_length); 
e9_spc_forg = spc(e9_forg(:,1:14), e9_forg(:,15), list_length); 
e11_spc_forg = spc(e11_forg(:,1:14), e11_forg(:,15), list_length); 
e12_spc_forg = spc(e12_forg(:,1:14), e12_forg(:,15), list_length); 


%%%% Perceptual oddballs %%%% 

j = []; oddnum = []; 

for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
perc_forgotten=perceptual_v1_CRP(cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :);
perc_recalled=perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :);

i= []; where_rec = []; where_forg = []; data_rec = []; data_forg = []; 

for i = 1:length(positions); 
    pos = positions(i); 
    where_rec = strcmp(perc_recalled(:,19), pos);
    data_rec{i,1} = perc_recalled(where_rec,:);
    data_rec{i,2} = pos; 
    
    where_forg = strcmp(perc_forgotten(:,19), pos); 
    data_forg{i,1} = perc_forgotten(where_forg,:); 
    data_forg{i,2} = pos;
end 

% Recalled
p11_rec = str2double(data_rec{1,1}); 
p12_rec = str2double(data_rec{2,1}); 
p7_rec = str2double(data_rec{3,1}); 
p8_rec = str2double(data_rec{4,1}); 
p9_rec = str2double(data_rec{5,1});

p7_spc_rec = spc(p7_rec(:,1:14), p7_rec(:,15), list_length); 
p8_spc_rec = spc(p8_rec(:,1:14), p8_rec(:,15), list_length); 
p9_spc_rec = spc(p9_rec(:,1:14), p9_rec(:,15), list_length); 
p11_spc_rec = spc(p11_rec(:,1:14), p11_rec(:,15), list_length); 
p12_spc_rec = spc(p12_rec(:,1:14), p12_rec(:,15), list_length); 


% Forgotten

p11_forg = str2double(data_forg{1,1}); 
p12_forg = str2double(data_forg{2,1}); 
p7_forg = str2double(data_forg{3,1}); 
p8_forg = str2double(data_forg{4,1}); 
p9_forg = str2double(data_forg{5,1});

p7_spc_forg = spc(p7_forg(:,1:14), p7_forg(:,15), list_length); 
p8_spc_forg = spc(p8_forg(:,1:14), p8_forg(:,15), list_length); 
p9_spc_forg = spc(p9_forg(:,1:14), p9_forg(:,15), list_length); 
p11_spc_forg = spc(p11_forg(:,1:14), p11_forg(:,15), list_length); 
p12_spc_forg = spc(p12_forg(:,1:14), p12_forg(:,15), list_length); 


%%%% Now let's plot it %%% 
emo_rec = emo; 
perc_rec = perc; 

emo_forg = emo_rec;
emo_forg.linetype = {'dashed'}; 
emo_forg.marker = {'plus'}; 

perc_forg = perc_rec; 
perc_forg.linetype = {'dashed'}; 
perc_forg.marker = {'plus'}; 

% Emotional and Perceptual lists % 
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_spc_rec,emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_spc_forg, emo_forg); hold on 
              plot_spc(p7_spc_rec, perc_rec); hold on 
              plot_spc(p7_spc_forg, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_spc_rec, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_spc_forg, emo_forg); hold on             
              plot_spc(p8_spc_rec, perc_rec); hold on 
              plot_spc(p8_spc_forg, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_spc_rec,emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_spc_forg, emo_forg); hold on 
              plot_spc(p9_spc_rec,perc_rec); hold on 
              plot_spc(p9_spc_forg,perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_spc_rec,emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_spc_forg,emo_forg); hold on 
              plot_spc(p11_spc_rec, perc_rec); hold on 
              plot_spc(p11_spc_forg,perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_spc_rec,emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_spc_forg,emo_forg); hold on 
              plot_spc(p12_spc_rec, perc_rec); hold on 
              plot_spc(p12_spc_forg,perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position', 'fontweight', 'bold', 'fontsize',20); 

% By SOA % 

% Emotional recalled % 

soa = unique(e11_rec(:,18));
i = []; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = e11_rec(:,18) == soanum;
    dat = e11_rec(where,:);
    
    e11_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e11_soa_rec{i,2} = soanum; 
    where=[]; dat = []; 
    
    where = e12_rec(:,18) == soanum;
    dat = e12_rec(where,:); 
    
    e12_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e12_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e9_rec(:,18) == soanum;
    dat = e9_rec(where,:); 
    
    e9_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e9_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e8_rec(:,18) == soanum;
    dat = e8_rec(where,:);
    
    e8_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e8_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e7_rec(:,18) == soanum;
    dat = e7_rec(where,:);
    
    e7_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e7_soa_rec{i,2} = soanum; 
    where=[]; dat = []; 
       
end 

% Emotional forgotten % 

i = []; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = e11_forg(:,18) == soanum;
    dat = e11_forg(where,:);
    
    e11_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e11_soa_forg{i,2} = soanum; 
    where=[]; dat = []; 
    
    where = e12_forg(:,18) == soanum;
    dat = e12_forg(where,:); 
    
    e12_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e12_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e9_forg(:,18) == soanum;
    dat = e9_forg(where,:); 
    
    e9_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e9_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e8_forg(:,18) == soanum;
    dat = e8_forg(where,:);
    
    e8_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e8_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = e7_forg(:,18) == soanum;
    dat = e7_forg(where,:);
    
    e7_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    e7_soa_forg{i,2} = soanum; 
    where=[]; dat = []; 
       
end 

% Perceptual recalled % 
i = []; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = p11_rec(:,18) == soanum;
    dat = p11_rec(where,:);
    
    p11_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p11_soa_rec{i,2} = soanum; 
    where=[]; dat = []; 
    
    where = p12_rec(:,18) == soanum;
    dat = p12_rec(where,:); 
    
    p12_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p12_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p9_rec(:,18) == soanum;
    dat = p9_rec(where,:); 
    
    p9_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p9_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p8_rec(:,18) == soanum;
    dat = p8_rec(where,:);
    
    p8_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p8_soa_rec{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p7_rec(:,18) == soanum;
    dat = p7_rec(where,:);
    
    p7_soa_rec{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p7_soa_rec{i,2} = soanum; 
    where=[]; dat = []; 
       
end 

% Perceptual forgotten % 
i = []; 

for i = 1:length(soa); 
    soanum = soa(i); 
    
    where = p11_forg(:,18) == soanum;
    dat = p11_forg(where,:);
    
    p11_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p11_soa_forg{i,2} = soanum; 
    where=[]; dat = []; 
    
    where = p12_forg(:,18) == soanum;
    dat = p12_forg(where,:); 
    
    p12_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p12_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p9_forg(:,18) == soanum;
    dat = p9_forg(where,:); 
    
    p9_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p9_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p8_forg(:,18) == soanum;
    dat = p8_forg(where,:);
    
    p8_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p8_soa_forg{i,2} = soanum; 
    where=[]; dat = [];
    
    where = p7_forg(:,18) == soanum;
    dat = p7_forg(where,:);
    
    p7_soa_forg{i,1} = spc(dat(:,1:14), dat(:,15), list_length); 
    p7_soa_forg{i,2} = soanum; 
    where=[]; dat = []; 
       
end 

% SOA 1 %
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_soa_rec{1,1},emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_soa_forg{1,1}, emo_forg); hold on 
              plot_spc(p7_soa_rec{1,1}, perc_rec); hold on 
              plot_spc(p7_soa_forg{1,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_soa_rec{1,1}, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_soa_forg{1,1}, emo_forg); hold on             
              plot_spc(p8_soa_rec{1,1}, perc_rec); hold on 
              plot_spc(p8_soa_forg{1,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_soa_rec{1,1},emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_soa_forg{1,1}, emo_forg); hold on 
              plot_spc(p9_soa_rec{1,1},perc_rec); hold on 
              plot_spc(p9_soa_forg{1,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_soa_rec{1,1},emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_soa_forg{1,1},emo_forg); hold on 
              plot_spc(p11_soa_rec{1,1}, perc_rec); hold on 
              plot_spc(p11_soa_forg{1,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_soa_rec{1,1},emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_soa_forg{1,1},emo_forg); hold on 
              plot_spc(p12_soa_rec{1,1}, perc_rec); hold on 
              plot_spc(p12_soa_forg{1,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position SOA = 1', 'fontweight', 'bold', 'fontsize',20);

%%% SOA 2 %%%
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_soa_rec{2,1},emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_soa_forg{2,1}, emo_forg); hold on 
              plot_spc(p7_soa_rec{2,1}, perc_rec); hold on 
              plot_spc(p7_soa_forg{2,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_soa_rec{2,1}, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_soa_forg{2,1}, emo_forg); hold on             
              plot_spc(p8_soa_rec{2,1}, perc_rec); hold on 
              plot_spc(p8_soa_forg{2,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_soa_rec{2,1},emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_soa_forg{2,1}, emo_forg); hold on 
              plot_spc(p9_soa_rec{2,1},perc_rec); hold on 
              plot_spc(p9_soa_forg{2,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_soa_rec{2,1},emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_soa_forg{2,1},emo_forg); hold on 
              plot_spc(p11_soa_rec{2,1}, perc_rec); hold on 
              plot_spc(p11_soa_forg{2,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_soa_rec{2,1},emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_soa_forg{2,1},emo_forg); hold on 
              plot_spc(p12_soa_rec{2,1}, perc_rec); hold on 
              plot_spc(p12_soa_forg{2,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position SOA = 2', 'fontweight', 'bold', 'fontsize',20);

%%% SOA 3 %%%
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_soa_rec{3,1},emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_soa_forg{3,1}, emo_forg); hold on 
              plot_spc(p7_soa_rec{3,1}, perc_rec); hold on 
              plot_spc(p7_soa_forg{3,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_soa_rec{3,1}, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_soa_forg{3,1}, emo_forg); hold on             
              plot_spc(p8_soa_rec{3,1}, perc_rec); hold on 
              plot_spc(p8_soa_forg{3,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_soa_rec{3,1},emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_soa_forg{3,1}, emo_forg); hold on 
              plot_spc(p9_soa_rec{3,1},perc_rec); hold on 
              plot_spc(p9_soa_forg{3,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_soa_rec{3,1},emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_soa_forg{3,1},emo_forg); hold on 
              plot_spc(p11_soa_rec{3,1}, perc_rec); hold on 
              plot_spc(p11_soa_forg{3,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_soa_rec{3,1},emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_soa_forg{3,1},emo_forg); hold on 
              plot_spc(p12_soa_rec{3,1}, perc_rec); hold on 
              plot_spc(p12_soa_forg{3,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position SOA = 3', 'fontweight', 'bold', 'fontsize',20);

%%% SOA 4 %%%
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_soa_rec{4,1},emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_soa_forg{4,1}, emo_forg); hold on 
              plot_spc(p7_soa_rec{4,1}, perc_rec); hold on 
              plot_spc(p7_soa_forg{4,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_soa_rec{4,1}, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_soa_forg{4,1}, emo_forg); hold on             
              plot_spc(p8_soa_rec{4,1}, perc_rec); hold on 
              plot_spc(p8_soa_forg{4,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_soa_rec{4,1},emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_soa_forg{4,1}, emo_forg); hold on 
              plot_spc(p9_soa_rec{4,1},perc_rec); hold on 
              plot_spc(p9_soa_forg{4,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_soa_rec{4,1},emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_soa_forg{4,1},emo_forg); hold on 
              plot_spc(p11_soa_rec{4,1}, perc_rec); hold on 
              plot_spc(p11_soa_forg{4,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_soa_rec{4,1},emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_soa_forg{4,1},emo_forg); hold on 
              plot_spc(p12_soa_rec{4,1}, perc_rec); hold on 
              plot_spc(p12_soa_forg{4,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position SOA = 4', 'fontweight', 'bold', 'fontsize',20);

%%% SOA 6 %%%
figure('Position', [56, 117, 1325, 680]); 
subplot(231); plot_spc(e7_soa_rec{5,1},emo_rec); title('Odd. encoding position = 7'); hold on 
              plot_spc(e7_soa_forg{5,1}, emo_forg); hold on 
              plot_spc(p7_soa_rec{5,1}, perc_rec); hold on 
              plot_spc(p7_soa_forg{5,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(232); plot_spc(e8_soa_rec{5,1}, emo_rec); title('Odd. encoding position = 8'); hold on 
              plot_spc(e8_soa_forg{5,1}, emo_forg); hold on             
              plot_spc(p8_soa_rec{5,1}, perc_rec); hold on 
              plot_spc(p8_soa_forg{5,1}, perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(233); plot_spc(e9_soa_rec{5,1},emo_rec); title('Odd. encoding position = 9'); hold on 
              plot_spc(e9_soa_forg{5,1}, emo_forg); hold on 
              plot_spc(p9_soa_rec{5,1},perc_rec); hold on 
              plot_spc(p9_soa_forg{5,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(234); plot_spc(e11_soa_rec{5,1},emo_rec); title('Odd. encoding position = 11'); hold on 
              plot_spc(e11_soa_forg{5,1},emo_forg); hold on 
              plot_spc(p11_soa_rec{5,1}, perc_rec); hold on 
              plot_spc(p11_soa_forg{5,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
subplot(235); plot_spc(e12_soa_rec{5,1},emo_rec); title('Odd. encoding position = 12'); hold on 
              plot_spc(e12_soa_forg{5,1},emo_forg); hold on 
              plot_spc(p12_soa_rec{5,1}, perc_rec); hold on 
              plot_spc(p12_soa_forg{5,1},perc_forg); hold off
              legend('E recalled','E forgotten','P recalled', 'P forgotten')
              
sgtitle('Recall probability by serial position SOA = 6', 'fontweight', 'bold', 'fontsize',20);
