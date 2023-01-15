%Alba Peris-Yague
% Calculate how many items are recalled per list per SOA 
clearvars
cd '/Code'

load alldata.mat

% Columns 1:14 are recalled items, column 18 is SOA, column 15 is subject

data=[alldata(:,1:14) alldata(:,18) alldata(:,15)];
data(:,1:16)=cellfun(@num2str,data(:,1:16),'UniformOutput',false);

recall=double(~strcmp(data(:,1:14),'0'));
recall=[recall str2double(data(:,15:16))];

for i=1:length(recall);
    total=sum(recall(i,1:14));
    totalrec(i,1)=total;
end 

totalrec=[totalrec str2double(data(:,15:16))];
totalrec=array2table(totalrec,'VariableNames',{'total_recall_list', 'SOA', 'subject'});

cd '/Raw_Results'

writetable (totalrec,'list_recall_SOA_R.csv');