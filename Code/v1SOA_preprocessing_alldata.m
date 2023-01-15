%Alba Peris-Yague 

%The goal of this script is to merge all data from exp v1 in which each
%column 1-14 is the position of the oddballs at encoding and the cells
%contain the position in which each word was recalled. If 0= not recalled. 

% Raw data was obtained from: /VariableSOA/Variable_SOA_70

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
    load totalhits
    totalhits=totalhits';
%get data

for rowI = 1:40 
    if strcmp('v',files(rowI).name(end)) %compare strings
        list_num = sscanf(files(rowI).name,'%6c_'); %scan the files that start with %d is an integer number i.e no decimals 
        list_rec = readtable(files(rowI).name); %read all the files
        list_rec = table2cell (list_rec); 
        resp=list_rec(:,1)';
        hits_list=totalhits(rowI,1);
    end 
    
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
    if  find(strncmpi(list_rec,'ce', 2))
        [positioncontrol,ccol]=find(strncmpi(list_rec,'ce',2)); %position control list
    else find(strncmpi(list_rec,'cp',2))
        [positioncontrol,ccol]=find(strncmpi(list_rec,'cp',2));
    end
    
    data(rowI+(index-1)*40, 1:21)=[resp sub rowI typeod SOA positionodball positioncontrol hits_list];
end 
    cd ..

end 


%delete the rows that have a mistake
data(156,:)=[]; %sub 7, list 36
data(191,:)=[]; %sub 9, list 32
data(405,:)=[]; %sub 16, list 7 
data(784,:)=[]; %sub25, list 27
data(1631,:)=[];%sub 46, list 35
data(1824,:)=[]; %sub 51, list 29
data(1874,:)=[]; %sub 52, list 40
data(2275,:)=[]; %sub 63, list 2
data(2370,:)=[]; %sub 65, list 18
data(2613,:)=[];%sub 71, list 22
data(1079,:)=[];%sub33, row 3
data(2166,:)=[];%sub60, list 14
data(2345,:)=[];%sub64, list 35
data(2500,:)=[];%sub68 list 32
data(2372,:)=[];%sub65 list 24
data(1501,:)=[]; %sub43 list 26
data(1517,:)=[]; %sub44 list3


alldata=data(~cellfun(@isempty,data(:,1)),:); %delete the empty rows from excluded subjects/lists
alldata(:,1:21)=cellfun(@num2str, data(:,1:21), 'UniformOutput', false);
%data=array2table(data,'VariableNames',{'1', '2', '3', '4', '5', '6', '7', '8','9',...
    %'10', '11', '12', '13', '14', 'subject', 'list', 'typeOD','SOA', 'position_od','position_control','hitslist'});

cd '/Code'

save alldata alldata

