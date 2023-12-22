%Alba Peris-Yague

%Get all trials lags separated by those where the odd was Remembered vs not
%(controls)

%Column 15=subject, column 16=list number, column 17=type of oddball,
%column 18=SOA, column 19=position oddball

%This script combines the code with functions from the Computational Memory
%Lab which are avaibalable here: http://memory.psych.upenn.edu/Behavioral_toolbox

clearvars; close all; clc
dir=  '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/Code'; %'/Code';
cd(dir)

addpath(genpath('/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/behavioral_toolbox_release1.01')) %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox

load emotional_v1_CRP

emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);
emotional_v1_CRP=str2double(emotional_v1_CRP);

list_length=14; 
emotional_subjects=emotional_v1_CRP(:,15); %emotional subject list 

E_all=emotional_v1_CRP(:,1:14); %emotional data

%cd(dir_func)
E_CRP_all=lag_crp(E_all,emotional_subjects,list_length);
% figure;plot_crp(E_CRP_all)
% title('E_CRP_all')

%Calculate temporal contiguity for all emotional lists
E_temp_contig = temp_fact(E_all,emotional_subjects,list_length);

emotional_v1_CRP=num2cell(emotional_v1_CRP);
emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd Remembered 
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
E_all_odd_forgot=str2double(emotional_v1_CRP(cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));
E_all_odd_rem=str2double(emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));

E_all_odd_forgot_CRP=lag_crp(E_all_odd_forgot(:,1:14), E_all_odd_forgot(:,15), list_length);
% figure;plot_crp(E_all_odd_forgot_CRP)
% title('E_all_odd_forgot_CRP')

E_temp_contig_Eforgotten = temp_fact(E_all_odd_forgot(:,1:14),E_all_odd_forgot(:,15),list_length);

E_all_odd_rem_CRP=lag_crp(E_all_odd_rem(:,1:14), E_all_odd_rem(:,15), list_length);
% figure;plot_crp(E_all_odd_rem_CRP)
% title('E_all_odd_rem_CRP')

E_temp_contig_Erecalled = temp_fact(E_all_odd_rem(:,1:14), E_all_odd_rem(:,15), list_length);

%cd(dir)
%writematrix(E_CRP_all,'E_CRP_all.csv');
%writematrix(E_all_odd_forgot_CRP,'E_CRP_all_forgot.csv');
%writematrix(E_all_odd_rem_CRP,'E_CRP_all_rem.csv');

%Restructure data to R 
E_CRP_all=num2cell(E_CRP_all); 
s=num2cell(unique(emotional_subjects));
%m is lag m5 (-5) m4 (-4) p is lag p1 (+1) p2 (+2)...
m5=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_CRP_all(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_CRP_all(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_CRP_all(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_CRP_all(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_CRP_all(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_CRP_all(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_CRP_all(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_CRP_all(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_CRP_all(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_CRP_all(:,15)];

all_CRP_E_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

E_all_odd_forgot_CRP=num2cell(E_all_odd_forgot_CRP);
m5=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_all_odd_forgot_CRP(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_all_odd_forgot_CRP(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_all_odd_forgot_CRP(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_all_odd_forgot_CRP(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_all_odd_forgot_CRP(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_all_odd_forgot_CRP(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_all_odd_forgot_CRP(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_all_odd_forgot_CRP(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_all_odd_forgot_CRP(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_all_odd_forgot_CRP(:,15)];

forg_E=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

E_all_odd_rem_CRP=num2cell(E_all_odd_rem_CRP);
m5=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_all_odd_rem_CRP(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_all_odd_rem_CRP(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_all_odd_rem_CRP(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_all_odd_rem_CRP(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_all_odd_rem_CRP(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_all_odd_rem_CRP(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_all_odd_rem_CRP(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_all_odd_rem_CRP(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_all_odd_rem_CRP(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_all_odd_rem_CRP(:,15)];

rem_E=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

rvf_CRP_E_R=[forg_E; rem_E];

%% Run the analysis for transitions to and from emotional oddballs 
clearvars -except all_CRP_E_R rvf_CRP_E_R s
dir= '/Code';
dir_func= %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox
cd(dir)

load emotional_v1_CRP

cd(dir_func)

emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 
 
emotional_v1_CRP=str2double(Remembered_emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));

data=NaN(850,28);

for i=1:length(emotional_v1_CRP);
    oddnum=emotional_v1_CRP(i,19);
position=find(emotional_v1_CRP(i,1:14)==oddnum);
total_row=sum(emotional_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [emotional_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] emotional_v1_CRP(i,15)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28)];
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;

for a=1:length(subj); 
    rows=lag(:,28)==subj(a,1);
    lagsubj=lag(rows,1:28); %changed from here down all the lags to lagsubj 
    index=index+1;

actual_transitions=lagsubj(:,13)'; %before
actuals_counts = collect(actual_transitions, all_transitions);

actual_transitions_after=-1*(lagsubj(:,15))'; %changed lag sign 
actual_counts_after=collect(actual_transitions_after, all_transitions);

possible_transitions=lagsubj(:,1:13);
possible_counts=collect(possible_transitions, all_transitions);

possible_transitions_after=-1*(lagsubj(:,15:27)); %changed lag sign 
possible_counts_after=collect(possible_transitions_after,all_transitions);

lag_crp_ap=actuals_counts./possible_counts;
lag_crp_after_ap=actual_counts_after./possible_counts_after;

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1)];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1)];

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP trials dir all_CRP_E_R rvf_CRP_E_R s
end

%cd(dir)
%writematrix(lag_crp_subj, 'E_lag_crp_subj_before.csv')
%writematrix(lag_crp_after_subj,'E_lag_crp_subj_after.csv')

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);
m5=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,9)];
m4=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,10)];
m3=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,11)];
m2=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,12)];
m1=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,13)];

p5=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,19)];
p4=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,18)];
p3=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,17)];
p2=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,16)];
p1=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,15)];

E_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,9)];
m4=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,10)];
m3=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,11)];
m2=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,12)];
m1=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,13)];

p5=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,19)];
p4=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,18)];
p3=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,17)];
p2=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,16)];
p1=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,15)];

E_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

E_ToFrom_R=[E_before; E_after];

%% means omit NaN
 E_to_backwards_mean= [num2cell([cell2mat(lag_crp_subj(:,28)) mean(cell2mat(lag_crp_subj(1:70,9:13)),2,'omitnan')]) repmat({'E'},70,1) repmat({'to'},70,1) repmat({'backwards'},70,1)];
 E_to_forwards_mean = [num2cell([cell2mat(lag_crp_subj(:,28)) mean(cell2mat(lag_crp_subj(1:70,15:19)),2,'omitnan')]) repmat({'E'},70,1) repmat({'to'},70,1) repmat({'forwards'},70,1)];

 E_from_backwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28)) mean(cell2mat(lag_crp_after_subj(1:70,9:13)),2,'omitnan')]) repmat({'E'},70,1) repmat({'from'},70,1) repmat({'backwards'},70,1)];
 E_from_forwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28))  mean(cell2mat(lag_crp_after_subj(1:70,15:19)),2,'omitnan')]) repmat({'E'},70,1) repmat({'from'},70,1) repmat({'forwards'},70,1)];
 
 E_lag_collapsed= [E_to_backwards_mean; E_to_forwards_mean; E_from_backwards_mean; E_from_forwards_mean];
% 
 E_lag_collapsed_R=array2table(E_lag_collapsed, 'VariableNames',{'subject','CRPmean','oddballtype', 'transition', 'direction'});

%% Repeat for perceptual oddballs
%Get all trials lags separated by those where the odd was Remembered vs not

clearvars -except E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R E_lag_collapsed_R

dir= '/Code';
dir_func= %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox
cd(dir)

load perceptual_v1_CRP

cd(dir_func)

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);
perceptual_v1_CRP=str2double(perceptual_v1_CRP);

list_length=14;
perceptual_subjects=perceptual_v1_CRP(:,15);
P_all=perceptual_v1_CRP(:,1:14);

P_all=perceptual_v1_CRP(:,1:14);

P_CRP_all=lag_crp(P_all,perceptual_subjects,list_length);
% figure;plot_crp(P_CRP_all)
% title('P_CRP_all')
P_temp_contig = temp_fact(P_all,perceptual_subjects,list_length);

perceptual_v1_CRP=num2cell(perceptual_v1_CRP);
perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd Remembered 
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
P_all_odd_forgot=str2double(perceptual_v1_CRP(cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));
%Last 2 rows of perceptual_v1_CRP the oddball wasn't recalled so they must
%be added here too. 
P_all_odd_forgot = [P_all_odd_forgot; str2double(perceptual_v1_CRP(1391:1392,:))];
P_all_odd_rem=str2double(perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));

P_all_odd_forgot_CRP=lag_crp(P_all_odd_forgot(:,1:14), P_all_odd_forgot(:,15), list_length);
% figure;plot_crp(P_all_odd_forgot_CRP)
% title('P_all_odd_forgot_CRP')
P_temp_contig_Pforgotten = temp_fact(P_all_odd_forgot(:,1:14), P_all_odd_forgot(:,15), list_length);


P_all_odd_rem_CRP=lag_crp(P_all_odd_rem(:,1:14), P_all_odd_rem(:,15), list_length);
% figure;plot_crp(P_all_odd_rem_CRP)
% title('P_all_odd_rem_CRP')
P_temp_contig_Precalled = temp_fact(P_all_odd_rem(:,1:14), P_all_odd_rem(:,15), list_length);

 

% writematrix(P_CRP_all,'P_CRP_all.csv');
% writematrix(P_all_odd_forgot_CRP,'P_CRP_all_forgot.csv');
% writematrix(P_all_odd_rem_CRP,'P_CRP_all_rem.csv');

P_CRP_all=num2cell(P_CRP_all);
m5=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_CRP_all(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_CRP_all(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_CRP_all(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_CRP_all(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_CRP_all(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_CRP_all(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_CRP_all(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_CRP_all(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_CRP_all(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_CRP_all(:,15)];

all_CRP_P_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

P_all_odd_forgot_CRP=num2cell(P_all_odd_forgot_CRP);
m5=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_all_odd_forgot_CRP(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_all_odd_forgot_CRP(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_all_odd_forgot_CRP(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_all_odd_forgot_CRP(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_all_odd_forgot_CRP(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_all_odd_forgot_CRP(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_all_odd_forgot_CRP(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_all_odd_forgot_CRP(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_all_odd_forgot_CRP(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_all_odd_forgot_CRP(:,15)];

forg_P=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

P_all_odd_rem_CRP=num2cell(P_all_odd_rem_CRP);
m5=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_all_odd_rem_CRP(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_all_odd_rem_CRP(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_all_odd_rem_CRP(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_all_odd_rem_CRP(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_all_odd_rem_CRP(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_all_odd_rem_CRP(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_all_odd_rem_CRP(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_all_odd_rem_CRP(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_all_odd_rem_CRP(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_all_odd_rem_CRP(:,15)];

rem_P=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

rvf_CRP_P_R=[forg_P; rem_P];

%% CRP in transitions to and from Perceptual Oddballs 

clearvars -except E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R E_lag_collapsed_R

dir= '/Code';
dir_func= %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox
cd(dir)

load perceptual_v1_CRP

cd(dir_func)

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

perceptual_v1_CRP=str2double(Remembered_perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));

data=NaN(832,28);

for i=1:length(perceptual_v1_CRP);
    oddnum=perceptual_v1_CRP(i,19);
position=find(perceptual_v1_CRP(i,1:14)==oddnum);
total_row=sum(perceptual_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [perceptual_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] perceptual_v1_CRP(i,15)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28)];
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;

for a=1:length(subj); 
    rows=lag(:,28)==subj(a,1);
    lagsubj=lag(rows,1:28); %changed from here down all the lags to lagsubj 
    index=index+1;

actual_transitions=lagsubj(:,13)'; %before
actuals_counts = collect(actual_transitions, all_transitions);

actual_transitions_after=-1*(lagsubj(:,15))'; %changed lag sign 
actual_counts_after=collect(actual_transitions_after, all_transitions);

possible_transitions=lagsubj(:,1:13);
possible_counts=collect(possible_transitions, all_transitions);

possible_transitions_after=-1*(lagsubj(:,15:27)); %changed lag sign 
possible_counts_after=collect(possible_transitions_after,all_transitions);

lag_crp_ap=actuals_counts./possible_counts;
lag_crp_after_ap=actual_counts_after./possible_counts_after;

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1)];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1)];

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP trials dir E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R E_lag_collapsed_R
end

% cd(dir)
% writematrix(lag_crp_subj, 'P_lag_crp_subj_before.csv')
% writematrix(lag_crp_after_subj,'P_lag_crp_subj_after.csv')

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);
m5=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,9)];
m4=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,10)];
m3=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,11)];
m2=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,12)];
m1=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,13)];

p5=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,19)];
p4=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,18)];
p3=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,17)];
p2=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,16)];
p1=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,15)];

P_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,9)];
m4=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,10)];
m3=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,11)];
m2=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,12)];
m1=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,13)];

p5=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,19)];
p4=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,18)];
p3=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,17)];
p2=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,16)];
p1=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,15)];

P_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

P_ToFrom_R=[P_before; P_after];

%% means omit NaN
 P_to_backwards_mean= [num2cell([cell2mat(lag_crp_subj(:,28)) mean(cell2mat(lag_crp_subj(1:70,9:13)),2,'omitnan')]) repmat({'P'},70,1) repmat({'to'},70,1) repmat({'backwards'},70,1)];
 P_to_forwards_mean = [num2cell([cell2mat(lag_crp_subj(:,28)) mean(cell2mat(lag_crp_subj(1:70,15:19)),2,'omitnan')]) repmat({'P'},70,1) repmat({'to'},70,1) repmat({'forwards'},70,1)];

 P_from_backwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28)) mean(cell2mat(lag_crp_after_subj(1:70,9:13)),2,'omitnan')]) repmat({'P'},70,1) repmat({'from'},70,1) repmat({'backwards'},70,1)];
 P_from_forwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28))  mean(cell2mat(lag_crp_after_subj(1:70,15:19)),2,'omitnan')]) repmat({'P'},70,1) repmat({'from'},70,1) repmat({'forwards'},70,1)];
 
 P_lag_collapsed= [P_to_backwards_mean; P_to_forwards_mean; P_from_backwards_mean; P_from_forwards_mean];

 P_lag_collapsed_R=array2table(P_lag_collapsed, 'VariableNames',{'subject','CRPmean','oddballtype', 'transition', 'direction'});
%
collapsed =[E_lag_collapsed_R; P_lag_collapsed_R];
%writetable(collapsed, 'collapsed_CRP_omitnan.csv');

%% Concatenate the R outputs
CRP_all_R=array2table([all_CRP_E_R; all_CRP_P_R], 'VariableNames',{'subject', 'oddballtype', 'direction', 'wordposition', 'CRP'});
rvf_CRP_R=array2table([rvf_CRP_E_R; rvf_CRP_P_R], 'VariableNames',{'subject', 'oddballtype', 'recall', 'direction', 'wordposition', 'CRP'});
ToFrom_CRP_R=array2table([E_ToFrom_R; P_ToFrom_R], 'VariableNames',{'subject', 'oddballtype', 'transition', 'direction', 'wordposition', 'CRP'});

cd '/Raw_Results';
%writetable (CRP_all_R, 'CRP_all_R.csv');
%writetable(rvf_CRP_R, 'rvf_CRP_R.csv');
%writetable(ToFrom_CRP_R, 'ToFrom_CRP_R.csv');
