%Bryan Strange and Alba Peris-Yague

% The goals of this script are to preprocess the dataset to use for
% Kahana(1996) CMR model (preparation for the functions found in
% http://memory.psych.upenn.edu/Behavioral_toolbox).

%1) Separate the recout document into all the different lists.  
%2) Create one merged document with all the datasets. 

% Set up: Each list has 14 words, one oddball (emotional or
% perceptual). There are a total of 40 lists (20 with an emotional oddball,
% 20 with a perceptual oddball.

%% GET INDIVIDUAL LISTS FOR V1 (LISTS WITH ODDBALLS)
clearvars
cd '/Raw_data'; %this is the directory with the raw data
subjects = [4:7 9:12 14:75]; %subjects 3,8,13 are left-handed--> excluded

index=0;

% Create csv files inside each subejct with the 40 lists of their recalled
% items sepparately 

for sub=subjects
    index=index+1;
    sdir=sprintf('sub%d',sub);

    cd(sdir)


    load pop
    load cpp
    load listtype
    
    emotion_index = find(listtype<20); %lists <20 are lists with an emotional oddball
    percept_index = find(listtype>20); %lists with >20 are lists with a perceptual oddball 
    
    eop=pop(emotion_index); %EOP is the number in each list where the emotional oddball is
    cep=cpp(emotion_index); % for the control word
    pop=pop(percept_index); %POP is the number in each list where the perceptual oddball is    
    cpp=cpp(percept_index); %for the control word
    
    %load sh.txt
    %sh=sh(find(sh));
    [r,words]=xlsread('recout.xls'); %0= not recalled, a number= position of the word recalled
    r=r(:,2);

    rec=[];
    for i=1:40 %it selects from 'r' the corresponding words for each list. Gets rid of the 'nueva lista' and blank cell in between lists. 
        rec=[rec; r((i-1)*16+2:(i-1)*16+15)];
    end


    e=[];
    for i=1:20 %emotional oddball in rec list 
        e=[e 14*(emotion_index(i)-1)+eop(i)];  
    end
    
     p=[]; %perceptual oddball in rec list 
    for i=1:20
        p=[p 14*(percept_index(i)-1)+pop(i)]; 
    end 
    
    %add control words
    ce=[]; %control emotional odball
    for i=1:20
        ce=[ce 14*(emotion_index(i)-1)+cep(i)];
    end

    cp=[]; %control perceptual odball 
    for i=1:20
        cp=[cp 14*(percept_index(i)-1)+cpp(i)];
    end
    
    
    rec=num2cell(rec);
    rec(:,1)=cellfun(@num2str, rec(:,1), 'UniformOutput', false);
    
    
for rowe=e' %indicate where is the emotional oddball 
    rec(rowe,2)={'eo'};
end 

for rowp=p' %indicate where is the perceptual odball 
    rec(rowp,2)={'po'};
end 

for rowce=ce' %indicate where the control emotional word is
    rec(rowce,2)={'ce'};
end 

for rowcp=cp'
    rec(rowcp,2)={'cp'};
end 

%Find in which lists the SOAs are
eSOA1=arrayfun(@num2str,find((rem(listtype,10)==1&listtype<20)),'un',0); %emotional SOA 1
eSOA2=arrayfun(@num2str,find((rem(listtype,10)==2&listtype<20)),'un',0); %emotional SOA 2
eSOA3=arrayfun(@num2str,find((rem(listtype,10)==3&listtype<20)),'un',0); %emotional SOA 3
eSOA4=arrayfun(@num2str,find((rem(listtype,10)==4&listtype<20)),'un',0); %emotional SOA 4
eSOA6=arrayfun(@num2str,find((rem(listtype,10)==6&listtype<20)),'un',0); %emotional SOA 6

pSOA1=arrayfun(@num2str,find((rem(listtype,10)==1&listtype>20)),'un',0); %perceptual SOA 1
pSOA2=arrayfun(@num2str,find((rem(listtype,10)==2&listtype>20)),'un',0); %perceptual SOA 2
pSOA3=arrayfun(@num2str,find((rem(listtype,10)==3&listtype>20)),'un',0); %perceptual SOA 3
pSOA4=arrayfun(@num2str,find((rem(listtype,10)==4&listtype>20)),'un',0); %perceptual SOA 4
pSOA6=arrayfun(@num2str,find((rem(listtype,10)==6&listtype>20)),'un',0); %perceptual SOA 6

% get lists 

beg=1;
for listnum=1:40
    list=rec(beg:(14*listnum),1:2);
    beg=(14*listnum)+1;
    name=sprintf('list%02d.csv',listnum);
    list=cell2table(list);
    list_num=num2str(listnum);
    %find the corresponding SOA for each list and add it to the table
    if any(strcmp(eSOA1,list_num));
        list(:,3)=array2table(repmat(1,14,1));
    elseif any(strcmp(eSOA2,list_num));
        list(:,3)=array2table(repmat(2,14,1));
    elseif any(strcmp(eSOA3, list_num));
        list(:,3)=array2table(repmat(3,14,1));
    elseif any(strcmp(eSOA4, list_num));
        list(:,3)=array2table(repmat(4,14,1));
    elseif any(strcmp(eSOA6, list_num));
        list(:,3)=array2table(repmat(6,14,1));
    elseif any(strcmp(pSOA1,list_num));
        list(:,3)=array2table(repmat(1,14,1));
    elseif any(strcmp(pSOA2,list_num));
        list(:,3)=array2table(repmat(2,14,1));
    elseif any(strcmp(pSOA3, list_num));
        list(:,3)=array2table(repmat(3,14,1));
    elseif any(strcmp(pSOA4, list_num));
        list(:,3)=array2table(repmat(4,14,1));
    elseif any(strcmp(pSOA6, list_num));
        list(:,3)=array2table(repmat(6,14,1));
    end 
    
    writetable(list, name)
end 

    cd ..     
end 

%% CREATE ONE MERGED DATASET FOR V1 DATA
clearvars

subjects = [4:7 9:12 14:75];
index=0;

cd '/Raw_data'


for sub=subjects
    index=index+1;
    sdir=sprintf('sub%d',sub);

    cd(sdir)
    
    analysisdir= pwd;
    files = dir; %upload all the files    
    files=files(6:end);
    
%get data

for rowI = 1:40 
    if strcmp('v',files(rowI).name(end)) %compare strings
        list_num = sscanf(files(rowI).name,'%6c_'); %scan the files that start with %d is an integer number i.e no decimals 
        list_rec = readtable(files(rowI).name); %read all the files
        list_rec = table2cell (list_rec); 
        resp=cell2mat(list_rec(:,1));
    end 
           
    %Find the serial position at encoding of the words at each position
    %recalled. E.g if a word was the 10th word presented at encoding, and
    %the first word recalled; a=10.
    
    %Clean up the data from repeats. Except in sub 33 in which there is a
    %missing serial position (reason for exclusion).
    if sub==7 && rowI==36 ||sub==9 && rowI==32 ||sub==16&&rowI==7 ||sub==25&&rowI==27||sub==46&&rowI==35||sub==51&&rowI==29||sub==52&&rowI==40||sub==63&&rowI==2||sub==65&&rowI==18||sub==71&&rowI==22||sub==33&&rowI==3||sub==60&&rowI==14||sub==68&&rowI==32||sub==64&&rowI==35||sub==65&&rowI==24||sub==43&&rowI==26||sub==44&&rowI==3 %There are repeats/other errors in these subjects & lists, thus they are excluded
    continue 
    end 
    
       if find(resp==1)
           a=find(resp==1);
       else a=0;
       end 
       if find(resp==2)
           b=find(resp==2);
       else b=0;
       end 
       if find(resp==3)
           c=find(resp==3);
       else c=0;
       end 
       if find(resp==4)
           d=find(resp==4);
       else d=0;
       end 
       if find(resp==5)
           e=find(resp==5);
       else e=0;
       end 
       if find(resp==6)
           f=find(resp==6);
       else f=0;
       end    
       if find(resp==7)
           g=find(resp==7);
       else g=0;
       end 
       if find(resp==8)
           h=find(resp==8);
       else h=0;
       end 
       if find(resp==9)
           i=find(resp==9);
       else i=0;
       end 
       if find(resp==10)
           j=find(resp==10);
       else j=0;
       end 
       if find(resp==11)
           k=find(resp==11);
       else k=0;
       end 
       if find(resp==12)
           l=find(resp==12);
       else l=0;
       end 
       if find(resp==13)
           m=find(resp==13);
       else m=0;
       end 
       if find(resp==14)
           n=find(resp==14);
       else n=0;
       end 
    
 
 
       list_final=[a b c d e f g h i j k l m n];
       list_final=num2cell(list_final);

    for i=1:14 %get the category of the oddball in each list (emotional or perceptual)
        if strcmp('eo',list_rec{i,2}) 
            typeod(:,1)= list_rec(i,2);
 
        elseif strcmp('po',list_rec{i,2}) 
            typeod(:,1)=list_rec(i,2); 
        end
    end 
   

  SOA=list_rec(1,3); %get the SOA type 
    
    
    if find(strncmpi(list_rec,'eo', 2))
        [positionodball,col]=find(strncmpi(list_rec,'eo',2)); %position oddball list
    else find(strncmpi(list_rec,'po',2))
        [positionodball,col]=find(strncmpi(list_rec,'po',2));
    end   
    
    %Find the encoding position of the control words
    if find(strncmpi(list_rec,'eo', 2))
        [positioncontrol,col]=find(strncmpi(list_rec,'ce',2)); %position oddball list
    else find(strncmpi(list_rec,'po',2))
        [positioncontrol,col]=find(strncmpi(list_rec,'cp',2));
    end  
       
    data(rowI+(index-1)*40, 1:19)=[list_final sub rowI typeod SOA positionodball];
    
    data_control(rowI+(index-1)*40, 1:20)=[list_final sub rowI typeod SOA positionodball positioncontrol];

end 
    cd ..

end 
 
data=data(~cellfun(@isempty,data(:,1)),:); %delete the empty rows from excluded subjects/lists
data(:,1:19)=cellfun(@num2str, data(:,1:19), 'UniformOutput', false);
data=array2table(data,'VariableNames',{'1', '2', '3', '4', '5', '6', '7', '8','9',...
    '10', '11', '12', '13', '14', 'subject', 'list', 'typeOD','SOA', 'position_od'});
data=sortrows(data,{'typeOD'},{'ascend'}); %sort the data matrix between emotional and perceptual oddballs

e=data(1:1391,1:19);
e=sortrows(e,{'position_od'},{'ascend'});
emotional_v1_CRP=table2array(e);

p=data(1392:2783,1:19);
p=sortrows(p,{'position_od'},{'ascend'});
perceptual_v1_CRP=table2array(p);

%cd '/Code';

%save emotional_v1_CRP emotional_v1_CRP
%save perceptual_v1_CRP perceptual_v1_CRP

% Including the position of the control items
i=[]; 
for i = 1:length(data_control); 
    if strcmp(data_control(i,17), 'po')
        data_control(i,21) = {'pc'};
    elseif strcmp(data_control(i,17), 'eo')
        data_control(i,21) ={'ec'};
    end
end
position_R = [data_control(:,[17,19,15]) ; [data_control(:,21) data_control(:,20) data_control(:,15)]];
position_R = array2table(position_R, 'VariableNames',{'list_type','enc_pos', 'subject'}); 

%cd '/Code';

%writetable(position_R,'oddball_control_position_R.csv')

%% Different data organization 
i =[]; 
data_wide=[]; 
data_wide = [data_control(:,15) data_control(:,19:20)];

for i =1:length(data_control); 
    
    if strcmp(data_control(i,17), 'po')
        data_wide(i,4) = {'perceptual'}; 
    elseif strcmp(data_control(i,17), 'eo')
        data_wide(i,4) = {'emotional'}; 
    end 
        
end 

%cd '/Code';

data_wide = array2table(data_wide, 'VariableNames',{'subject','oddball', 'control','list_type'}); 

%writetable(data_wide,'oddball_control_position_wide_R.csv')

%% Find when the oddballs and controls were recalled
% End up with a matrix of: encoding oddball, recall oddball, encoding
% control recall control, emotional/perceptual 
i=[]; oddlists = {}; ctrlists = {};

for i = 1:length(data_control)
    odd = cell2mat(data_control(i,19)); 
    control = cell2mat(data_control(i,20)); 
    
    oddlists(i,1) = data_control(i,19); %encoding position of the oddball 
    oddlists(i,2) = {find(cell2mat(data_control(i,1:14))==odd)}; %recall position of the oddball
    
    if strcmp(data_control(i,17),'po');
        oddlists(i,3) = {'perceptual'}; 
    elseif strcmp(data_control(i,17), 'eo'); 
        oddlists(i,3) = {'emotional'}; 
    end 
    oddlists(i,4) = data_control(i,15); %subject
    oddlists(i,5) = {'oddball'}; 
    
    ctrlists(i,1) = data_control(i,20); %encoding position of the control 
    ctrlists(i,2) = {find(cell2mat(data_control(i,1:14))==control)}; %recall position of the control
    
    if strcmp(data_control(i,17),'po');
        ctrlists(i,3) = {'perceptual'}; 
    elseif strcmp(data_control(i,17), 'eo'); 
        ctrlists(i,3) = {'emotional'}; 
    end 
    ctrlists(i,4) = data_control(i,15); %subject
    ctrlists(i,5) = {'control'}; 
end

cd '/Raw_Results'

oddlists= array2table(oddlists, 'VariableNames',{'enc_pos','rec_pos', 'list_type','subject', 'item'}); 
ctrlists= array2table(ctrlists, 'VariableNames',{'enc_pos','rec_pos', 'list_type','subject', 'item'}); 

%writetable(oddlists,'oddlists.csv')
%writetable(ctrlists, 'ctrlists.csv')
