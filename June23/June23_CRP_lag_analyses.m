%Alba Peris-Yague

%Get all trials lags separated by those where the odd was Remembered vs not
%(controls)

%Column 15=subject, column 16=list number, column 17=type of oddball,
%column 18=SOA, column 19=position oddball

%This script combines the code with functions from the Computational Memory
%Lab which are avaibalable here: http://memory.psych.upenn.edu/Behavioral_toolbox

clearvars; close all; clc
%dir=  '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/Code'; %'/Code';
%cd(dir)

rawdata= '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/June23/Raw_data'; 
cd(rawdata)

addpath(genpath('/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/behavioral_toolbox_release1.01')) %Add here the path to the functions from http://memory.psych.upenn.edu/Behavioral_toolbox

%% Run the analysis for transitions to and from emotional oddballs 
clearvars -except rawdata

cd(rawdata)

load emotional_v1_CRP

%cd(dir_func)

emotional_v1_CRP(:,1:20)=cellfun(@num2str,emotional_v1_CRP(:,1:20),'UniformOutput',false);

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:20)=emotional_v1_CRP(j,1:20); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 


%%%%%%%
amnesia = {'amputaci�n', 'asesino', 'morgue', 'parapl�jico', 'sufrimiento', 'terrorista'};

%noamnesia = {'c�ncer', 'nazi', 'sida', 'suicida', 'traidor', 'tumor','violaci�n', 'ahogado', 'asfixia', 'ceguera', 'crimen', 'hambruna', 'masacre', 'plaga'}; 

noamnesia = {'c�ncer', 'nazi', 'sida', 'suicida', 'traidor', 'tumor','violaci�n', 'asfixia', 'masacre'}; % only items that still have increased EO recall vs. ctrl

% highrec = {'amputaci�n', 'c�ncer','morgue', 'nazi','sida','suicida','terrorista','traidor','tumor','violaci�n'}; 
% 
% lowrec = {'ahogado', 'asesino', 'asfixia', 'ceguera','crimen', 'hambruna','masacre', 'parapl�jico','plaga','sufrimiento'}; 

%%%%%%%%

all_items= Remembered_emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :);
i= []; amnesia_data = []; noamnesia_data = []; highrec_data = []; lowrec_data = []; 

for i=1:length(all_items)
    if ismember(all_items(i,20),amnesia) % if it's a list with 'amnesia'
        amnesia_data = [amnesia_data; all_items(i,:)]; 
        
    elseif ismember(all_items(i,20), noamnesia) % if it is NOT 'amnesic'
        noamnesia_data = [noamnesia_data; all_items(i,:)];
    end 
    
end 

% for i=1:length(all_items)
%     if ismember(all_items(i,20),highrec) % if it's a list with 'amnesia'
%         highrec_data = [highrec_data; all_items(i,:)]; 
%         
%     elseif ismember(all_items(i,20), lowrec) % if it is NOT 'amnesic'
%         lowrec_data = [lowrec_data; all_items(i,:)];
%     end 
%     
% end 


%%%% Now loop through 'amnesia' and 'noamnesia'

amn = []; emotional_v1_CRP = []; E_before = []; E_after = []; E_before_all = []; E_after_all = [];

for amn = 1:2;
    
    if amn == 1 %amnesia
        emotional_v1_CRP=str2double(amnesia_data(~cellfun(@isempty,amnesia_data (:,1)), :));
        amnesia_type = 'amn'; 
        
    elseif amn == 2 % no amnesia
        emotional_v1_CRP=str2double(noamnesia_data(~cellfun(@isempty,noamnesia_data (:,1)), :));
        amnesia_type = 'no_amn'; 
    end
    
%     if amn == 1 %high recall items
%         emotional_v1_CRP=str2double(highrec_data(~cellfun(@isempty,highrec_data (:,1)), :));
%         amnesia_type = 'highrec'; 
%         
%     elseif amn == 2 % low recall items 
%         emotional_v1_CRP=str2double(lowrec_data(~cellfun(@isempty,lowrec_data (:,1)), :));
%         amnesia_type = 'lowrec'; 
%     end
    
    
    data=NaN(size(emotional_v1_CRP,1),28);
    
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
    
    lag_crp_subj = []; lag_crp_after_subj = [];
    
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
        
        clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions ...
            emotional_v1_CRP trials dir all_CRP_E_R rvf_CRP_E_R s amn amnesia_type E_before_all ...
            E_after_all rawdata amnesia_data noamnesia_data lowrec_data highrec_data
    end
    
    %cd(dir)
    %writematrix(lag_crp_subj, 'E_lag_crp_subj_before.csv')
    %writematrix(lag_crp_after_subj,'E_lag_crp_subj_after.csv')
    
    m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[];
    
    lag_crp_subj=num2cell(lag_crp_subj);
    m5=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'5'},size(subj,1),1) lag_crp_subj(:,9)];
    m4=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'4'},size(subj,1),1) lag_crp_subj(:,10)];
    m3=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'3'},size(subj,1),1) lag_crp_subj(:,11)];
    m2=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'2'},size(subj,1),1) lag_crp_subj(:,12)];
    m1=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'1'},size(subj,1),1) lag_crp_subj(:,13)];
    
    p5=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'5'},size(subj,1),1) lag_crp_subj(:,19)];
    p4=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'4'},size(subj,1),1) lag_crp_subj(:,18)];
    p3=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'3'},size(subj,1),1) lag_crp_subj(:,17)];
    p2=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'2'},size(subj,1),1) lag_crp_subj(:,16)];
    p1=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'to'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'1'},size(subj,1),1) lag_crp_subj(:,15)];
    
    E_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
    
    E_before_all = [E_before_all; E_before];
    
    m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[];
    
    lag_crp_after_subj=num2cell(lag_crp_after_subj);
    m5=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'5'},size(subj,1),1) lag_crp_after_subj(:,9)];
    m4=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'4'},size(subj,1),1) lag_crp_after_subj(:,10)];
    m3=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'3'},size(subj,1),1) lag_crp_after_subj(:,11)];
    m2=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'2'},size(subj,1),1) lag_crp_after_subj(:,12)];
    m1=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Backwards'},size(subj,1),1) repmat({'1'},size(subj,1),1) lag_crp_after_subj(:,13)];
    
    p5=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'5'},size(subj,1),1) lag_crp_after_subj(:,19)];
    p4=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'4'},size(subj,1),1) lag_crp_after_subj(:,18)];
    p3=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'3'},size(subj,1),1) lag_crp_after_subj(:,17)];
    p2=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'2'},size(subj,1),1) lag_crp_after_subj(:,16)];
    p1=[num2cell(subj) repmat({amnesia_type},size(subj,1),1) repmat({'from'},size(subj,1),1) repmat({'Forwards'},size(subj,1),1) repmat({'1'},size(subj,1),1) lag_crp_after_subj(:,15)];
    
    E_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
    
    E_after_all = [E_after_all; E_after];
    
end

E_ToFrom_R=[E_before_all; E_after_all];

%% Concatenate the R outputs
ToFrom_CRP_R=array2table(E_ToFrom_R, 'VariableNames',{'subject', 'oddballtype', 'transition', 'direction', 'wordposition', 'CRP'});


cd(rawdata);
%writetable (CRP_all_R, 'CRP_all_R.csv');
%writetable(rvf_CRP_R, 'rvf_CRP_R.csv');
writetable(ToFrom_CRP_R, 'ToFrom_CRP_items_amnesia_EOincreased_R.csv');
