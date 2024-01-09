% Alba Peris-Yague. May 12th 2023- check whether there are specific items
% that have better memory than others (item-induced retrograde amnesia). 

clearvars; close all; clc
cd  '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/Raw_data'; %this is the directory with the raw data
subjects = [4:7 9:12 14:75]; %subjects 3,8,13 are left-handed--> excluded

index=0;

emotional_words_all = []; emotional_minusone_all = []; control_words_all = []; control_minusone_words_all = [];

perceptual_words_all = []; perceptual_minusone_all = []; perceptual_control_words_all = []; perceptual_control_minusone_words_all = [];


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
    
    % Get the words list 
    wordrec=[]; i = []; 
    for i=1:40
        wordrec=[wordrec; words((i-1)*16+2:(i-1)*16+15)'];
    end 
    %
    
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
    
    % Add the words % 
    rec(:,3) = wordrec; 
    
    % Add the list numbers
    rec(:,4) = num2cell(repelem((1:40), 1,14))';
    
    % Find SOAs and add an SOA column 
    
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
    
    % find where these lists are 
    % Add an empty rec column 
    rec(:,5) = num2cell(NaN(length(rec),1));
    
    for k = 1:length(rec); % for each trial 
        for soa = 1:10; % because 10 possibilities
            if soa == 1; soa_data = eSOA1; soa_val = 1;
            elseif soa==2; soa_data = eSOA2; soa_val = 2;
            elseif soa == 3; soa_data = eSOA3; soa_val = 3;
            elseif soa == 4; soa_data = eSOA4; soa_val = 4; 
            elseif soa == 5; soa_data = eSOA6; soa_val = 6; 
            elseif soa == 6; soa_data = pSOA1; soa_val = 1; 
            elseif soa == 7; soa_data = pSOA2; soa_val = 2;
            elseif soa == 8; soa_data = pSOA3; soa_val = 3; 
            elseif soa == 9; soa_data = pSOA4; soa_val = 4; 
            elseif soa == 10; soa_data = pSOA6; soa_val = 6;
            end 
            
            for soa_loc=1:length(soa_data); % for each value 
        
                where = find(cell2mat(rec(:,4)) == str2num(soa_data{soa_loc})); % gets the row numbers where a specific SOA is at 
                
                rec(where,5) = num2cell(soa_val); 
            end 
        end 
        
    end 
    
    % Find the emotional oddballs, emotional controls and 
    emotional_words = find(strcmp(rec(:,2),'eo')); % This is where the emotional words are
    emo_minusone_words = find(strcmp(rec(:,2),'eo'))-1; 
    
    control_words = find(strcmp(rec(:,2),'ce'));% control emotional words
    control_minusone_words = find(strcmp(rec(:,2),'ce'))-1;% control emotional words
    
    emotional_words_all = [emotional_words_all; [repmat({sub},20,1) rec(emotional_words,:)]];
    emotional_minusone_all = [emotional_minusone_all; [repmat({sub},20,1) rec(emo_minusone_words,1) repmat({'emo_minus_one'},20,1) rec(emo_minusone_words+1,3) rec(emo_minusone_words,4:5)]];
    
    control_words_all = [control_words_all; [repmat({sub},20,1) rec(control_words,:)]];
    control_minusone_words_all = [control_minusone_words_all; [repmat({sub},20,1) rec(control_minusone_words,1) repmat({'emo_ctrl_minus_one'},20,1) rec(control_minusone_words+1,3) rec(control_minusone_words,4:5)]];
    
    %%%% Add perceptual oddballs as well 
    %If we wanted to save the file single_item_emotion.csv, there is no
    %need to add these lines of code 
    perceptual_words_all = []; perceptual_minusone_all = []; perceptual_control_words_all = []; perceptual_control_minusone_words_all = [];

    perceptual_words = find(strcmp(rec(:,2),'po')); % This is where the emotional words are
    perc_minusone_words = find(strcmp(rec(:,2),'po'))-1; 
    
    percep_control_words = find(strcmp(rec(:,2),'cp'));% control emotional words
    percep_control_minusone_words = find(strcmp(rec(:,2),'cp'))-1;% control emotional words
    
    perceptual_words_all = [perceptual_words_all; [repmat({sub},20,1) rec(perceptual_words,:)]];
    perceptual_minusone_all = [perceptual_minusone_all; [repmat({sub},20,1) rec(perc_minusone_words,1) repmat({'perc_minus_one'},20,1) rec(perc_minusone_words+1,3) rec(perc_minusone_words,4:5)]];
    
    perceptual_control_words_all = [perceptual_control_words_all; [repmat({sub},20,1) rec(percep_control_words,:)]];
    perceptual_control_minusone_words_all = [perceptual_control_minusone_words_all; [repmat({sub},20,1) rec(percep_control_minusone_words,1) repmat({'perc_ctrl_minus_one'},20,1) rec(percep_control_minusone_words+1,3) rec(percep_control_minusone_words,4:5)]];
   
    
    
    clearvars -except index sub emotional_words_all emotional_minusone_all control_words_all control_minusone_words_all  ...
        perceptual_words_all perceptual_minusone_all perceptual_control_words_all perceptual_control_minusone_words_all

    cd  '/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/Raw_data'; %this is the directory with the raw data

end

% Merge all the data
%data_R = [emotional_words_all; emotional_minusone_all; control_words_all; control_minusone_words_all];

data_R = [emotional_words_all; emotional_minusone_all; control_words_all; control_minusone_words_all; ...
    perceptual_words_all; perceptual_minusone_all; perceptual_control_words_all; perceptual_control_minusone_words_all];

for i = 1:length(data_R);
    if find(strcmp(data_R(i,2),'0'))
        data_R(i,2) = {'0'};
    else
        data_R(i,2) = {'1'};
    end
end

% Add a new column specifying wether the oddball is emotional or perceptual
% and rename it. 

i = []; 

for i = 1:length(data_R); 
    if find(strcmp(data_R(i,3), 'eo')) 
        data_R(i,7) = {'emotional'}; 
        data_R(i,3) = {'oddball'}; 
        
    elseif find(strcmp(data_R(i,3), 'ce')) 
        data_R(i,7) = {'emotional'}; 
        data_R(i,3) = {'control'}; 
        
    elseif find(strcmp(data_R(i,3), 'emo_minus_one')) 
        data_R(i,7) = {'emotional'}; 
        data_R(i,3) = {'oddball_minus_one'}; 
        
    elseif find(strcmp(data_R(i,3), 'emo_ctrl_minus_one'))
        data_R(i,7) = {'emotional'}; 
        data_R(i,3) = {'control_minus_one'}; 
        
    elseif find(strcmp(data_R(i,3), 'po')) 
        data_R(i,7) = {'perceptual'};
        data_R(i,3) = {'oddball'}; 
        
    elseif find(strcmp(data_R(i,3), 'cp')) 
        data_R(i,7) = {'perceptual'}; 
        data_R(i,3) = {'control'}; 
        
    elseif find(strcmp(data_R(i,3), 'perc_minus_one')) 
        data_R(i,7) = {'perceptual'}; 
        data_R(i,3) = {'oddball_minus_one'}; 
        
    elseif find(strcmp(data_R(i,3), 'perc_ctrl_minus_one'))
        data_R(i,7) = {'perceptual'}; 
        data_R(i,3) = {'control_minus_one'}; 
    end 
end 

cd('/Users/albaperis/OneDrive - UAM/PhDUPM_/Von Restroff WP3/Paper_github/Odd_SOA_CRP_Code_Reviewed/PerisYague2023/Raw_Results')

%data_R = cell2table(data_R, 'VariableNames',{'subject', 'recall', 'item_who', 'word_who', 'list', 'soa'});
%writetable(data_R, 'single_item_emotion.csv'); % write R table
data_R = cell2table(data_R, 'VariableNames',{'subject', 'recall', 'item_who', 'word_who', 'list', 'soa', 'listtype'});
writetable(data_R, 'glmer_single_item_emotion.csv'); % write R table

% Now manually remove odd characters from csv file (just write words
% without the accents with replace on excel before going to R)



