%Alba Peris-Yague

%Get all trials lags separated by those where the odd was Remembered vs not
%(controls)

%Column 15=subject, column 16=list number, column 17=type of oddball,
%column 18=SOA, column 19=position oddball

%This script combines the code with functions from the Computational Memory
%Lab which are avaibalable here: http://memory.psych.upenn.edu/Behavioral_toolbox

%% Run the analysis for transitions to and from emotional oddballs 
clearvars 
dir= '/Code';
dir_func= %Behavioral_toolbox here 
cd(dir)

load emotional_v1_CRP

cd(dir_func)

emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

% E all by SOA
E_all_SOA=str2double(emotional_v1_CRP);
list_length=14;
CRP_all_by_SOA_E_final=[];
SOA=[1:4,6];

for i=1:5;
    soa=SOA(i);
    soa_where=E_all_SOA(:,18)==soa;
    dataset_E=E_all_SOA(soa_where,:);
    subjects_E=E_all_SOA(soa_where,15);
    
    CRP_all_by_SOA_E=lag_crp(dataset_E,subjects_E,list_length);
    CRP_all_by_SOA_E=[CRP_all_by_SOA_E repmat(soa,70,1)];
    CRP_all_by_SOA_E_final=[CRP_all_by_SOA_E_final; CRP_all_by_SOA_E];
    
    clearvars -except dir dir_func emotional_v1_CRP E_all_SOA list_length CRP_all_by_SOA_E_final SOA 
end 

E_CRP_SOA_all=num2cell(CRP_all_by_SOA_E_final);
s=num2cell(unique(E_all_SOA(:,15)));
m5=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) E_CRP_SOA_all(:,9)];
m4=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) E_CRP_SOA_all(:,10)];
m3=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) E_CRP_SOA_all(:,11)];
m2=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) E_CRP_SOA_all(:,12)];
m1=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) E_CRP_SOA_all(:,13)];

p5=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) E_CRP_SOA_all(:,19)];
p4=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) E_CRP_SOA_all(:,18)];
p3=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) E_CRP_SOA_all(:,17)];
p2=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) E_CRP_SOA_all(:,16)];
p1=[[s;s;s;s;s] E_CRP_SOA_all(:,28) repmat({'E'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) E_CRP_SOA_all(:,15)];

all_CRP_E_SOA_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

%

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 
 
emotional_v1_CRP=str2double(Remembered_emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));

data=NaN(850,29);

for i=1:length(emotional_v1_CRP);
    oddnum=emotional_v1_CRP(i,19);
position=find(emotional_v1_CRP(i,1:14)==oddnum);
total_row=sum(emotional_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [emotional_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] emotional_v1_CRP(i,15) emotional_v1_CRP(i,18)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28) data(j,29)]; %29 is SOA
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;
SOA=[1:4 6]; %sort this by SOA
i=[];

for soa_length=1:5
    soa=SOA(soa_length);
    i=lag(:,29)==soa;
    lagsoa=lag(i,:);

for a=1:length(subj); 
    rows=lagsoa(:,28)==subj(a,1);
    lagsubj=lagsoa(rows,1:28); %changed from here down all the lags to lagsubj 
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

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1) soa];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1) soa];

clearvars -except lag_crp_subj lag_crp_after_subj index lagsoa lag subj all_transitions emotional_v1_CRP dir all_CRP_E_R rvf_CRP_E_R s soa SOA soa_length all_CRP_E_SOA_R

end

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP dir all_CRP_E_R rvf_CRP_E_R s soa SOA soa_length all_CRP_E_SOA_R

end 


m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);

m5=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) lag_crp_subj(:,9)];
m4=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) lag_crp_subj(:,10)];
m3=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) lag_crp_subj(:,11)];
m2=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) lag_crp_subj(:,12)];
m1=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) lag_crp_subj(:,13)];

p5=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) lag_crp_subj(:,19)];
p4=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) lag_crp_subj(:,18)];
p3=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) lag_crp_subj(:,17)];
p2=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) lag_crp_subj(:,16)];
p1=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'E'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) lag_crp_subj(:,15)];

E_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) lag_crp_after_subj(:,9)];
m4=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) lag_crp_after_subj(:,10)];
m3=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) lag_crp_after_subj(:,11)];
m2=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) lag_crp_after_subj(:,12)];
m1=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) lag_crp_after_subj(:,13)];

p5=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) lag_crp_after_subj(:,19)];
p4=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) lag_crp_after_subj(:,18)];
p3=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) lag_crp_after_subj(:,17)];
p2=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) lag_crp_after_subj(:,16)];
p1=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'E'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) lag_crp_after_subj(:,15)];

E_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

E_ToFrom_R=[E_before; E_after];

%Calculate nanmean (23.6.21)
% E_to_backwards_mean= [num2cell([cell2mat(lag_crp_subj(:,28)) cell2mat(lag_crp_subj(:,29)) mean(cell2mat(lag_crp_subj(1:350,9:13)),2,'omitnan')]) repmat({'to'},350,1) repmat({'backwards'},350,1)];
% E_to_forwards_mean = [num2cell([cell2mat(lag_crp_subj(:,28)) cell2mat(lag_crp_subj(:,29)) mean(cell2mat(lag_crp_subj(1:350,15:19)),2,'omitnan')]) repmat({'to'},350,1) repmat({'forwards'},350,1)];
% 
% E_from_backwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28)) cell2mat(lag_crp_after_subj(:,29)) mean(cell2mat(lag_crp_after_subj(1:350,9:13)),2,'omitnan')]) repmat({'from'},350,1) repmat({'backwards'},350,1)];
% E_from_forwards_mean= [num2cell([cell2mat(lag_crp_after_subj(:,28)) cell2mat(lag_crp_after_subj(:,29)) mean(cell2mat(lag_crp_after_subj(1:350,15:19)),2,'omitnan')]) repmat({'from'},350,1) repmat({'forwards'},350,1)];
% 
% E_lag_collapsed= [E_to_backwards_mean; E_to_forwards_mean; E_from_backwards_mean; E_from_forwards_mean];
% 
% E_lag_collapsed_R=array2table(E_lag_collapsed, 'VariableNames',{'subject', 'SOA','CRPmean', 'transition', 'direction'});
%writetable(E_lag_collapsed_R, 'E_lag_collapsed_R.csv');

%% CRP in transitions to and from Perceptual Oddballs 

clearvars -except E_ToFrom_R all_CRP_E_SOA_R

dir= '/Code';
dir_func= %Behavioral toolbox here
cd(dir)

load perceptual_v1_CRP

cd(dir_func)

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%E all by SOA
P_all_SOA=str2double(perceptual_v1_CRP);
list_length=14;
CRP_all_by_SOA_P_final=[];
SOA=[1:4,6];

for i=1:5;
    soa=SOA(i);
    soa_where=P_all_SOA(:,18)==soa;
    dataset_P=P_all_SOA(soa_where,:);
    subjects_P=P_all_SOA(soa_where,15);
    
    CRP_all_by_SOA_P=lag_crp(dataset_P,subjects_P,list_length);
    CRP_all_by_SOA_P=[CRP_all_by_SOA_P repmat(soa,70,1)];
    CRP_all_by_SOA_P_final=[CRP_all_by_SOA_P_final; CRP_all_by_SOA_P];
    
    clearvars -except dir dir_func perceptual_v1_CRP P_all_SOA list_length CRP_all_by_SOA_P_final SOA E_ToFrom_R all_CRP_E_SOA_R
end 

P_CRP_SOA_all=num2cell(CRP_all_by_SOA_P_final);
s=num2cell(unique(P_all_SOA(:,15)));
m5=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) P_CRP_SOA_all(:,9)];
m4=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) P_CRP_SOA_all(:,10)];
m3=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) P_CRP_SOA_all(:,11)];
m2=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) P_CRP_SOA_all(:,12)];
m1=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) P_CRP_SOA_all(:,13)];

p5=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) P_CRP_SOA_all(:,19)];
p4=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) P_CRP_SOA_all(:,18)];
p3=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) P_CRP_SOA_all(:,17)];
p2=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) P_CRP_SOA_all(:,16)];
p1=[[s;s;s;s;s] P_CRP_SOA_all(:,28) repmat({'P'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) P_CRP_SOA_all(:,15)];

all_CRP_P_SOA_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 
%

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

perceptual_v1_CRP=str2double(Remembered_perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));

data=NaN(832,29);

for i=1:length(perceptual_v1_CRP);
    oddnum=perceptual_v1_CRP(i,19);
position=find(perceptual_v1_CRP(i,1:14)==oddnum);
total_row=sum(perceptual_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [perceptual_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] perceptual_v1_CRP(i,15) perceptual_v1_CRP(i,18)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28) data(j,29)];
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;

SOA=[1:4 6]; %sort this by SOA
i=[]; soa=[]; soa_length=[];

for soa_length=1:5
    soa=SOA(soa_length);
    i=lag(:,29)==soa;
    lagsoa=lag(i,:);

for a=1:length(subj); 
    rows=lagsoa(:,28)==subj(a,1);
    lagsubj=lagsoa(rows,1:28); %changed from here down all the lags to lagsubj 
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

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1) soa];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1) soa];

clearvars -except lag_crp_subj lag_crp_after_subj index lag lagsoa subj all_transitions emotional_v1_CRP dir E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R soa SOA soa_length all_CRP_P_SOA_R all_CRP_E_SOA_R
end

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP dir E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R soa SOA soa_length all_CRP_P_SOA_R all_CRP_E_SOA_R

end 


m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);
m5=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) lag_crp_subj(:,9)];
m4=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) lag_crp_subj(:,10)];
m3=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) lag_crp_subj(:,11)];
m2=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) lag_crp_subj(:,12)];
m1=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) lag_crp_subj(:,13)];

p5=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) lag_crp_subj(:,19)];
p4=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) lag_crp_subj(:,18)];
p3=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) lag_crp_subj(:,17)];
p2=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) lag_crp_subj(:,16)];
p1=[lag_crp_subj(:,28) lag_crp_subj(:,29) repmat({'P'},350,1) repmat({'to'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) lag_crp_subj(:,15)];

P_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'5'},350,1) lag_crp_after_subj(:,9)];
m4=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'4'},350,1) lag_crp_after_subj(:,10)];
m3=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'3'},350,1) lag_crp_after_subj(:,11)];
m2=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'2'},350,1) lag_crp_after_subj(:,12)];
m1=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Backwards'},350,1) repmat({'1'},350,1) lag_crp_after_subj(:,13)];

p5=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'5'},350,1) lag_crp_after_subj(:,19)];
p4=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'4'},350,1) lag_crp_after_subj(:,18)];
p3=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'3'},350,1) lag_crp_after_subj(:,17)];
p2=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'2'},350,1) lag_crp_after_subj(:,16)];
p1=[lag_crp_after_subj(:,28) lag_crp_after_subj(:,29) repmat({'P'},350,1) repmat({'from'},350,1) repmat({'Forwards'},350,1) repmat({'1'},350,1) lag_crp_after_subj(:,15)];

P_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

P_ToFrom_R=[P_before; P_after];

%% Concatenate the R outputs
ToFrom_CRP_SOA_R=array2table([E_ToFrom_R; P_ToFrom_R], 'VariableNames',{'subject', 'SOA','oddballtype', 'transition', 'direction', 'wordposition', 'CRP'});

cd     '/Raw_Results';

%writetable(ToFrom_CRP_SOA_R, 'ToFrom_CRP_SOA_R.csv');

all_CRP_SOA=array2table([all_CRP_E_SOA_R; all_CRP_P_SOA_R], 'VariableNames',{'subject','SOA','oddballtype','direction','wordposition','CRP'});

%writetable(all_CRP_SOA, 'all_CRP_SOA_R.csv');
