totalWidth = length(width);%This is also the height
average = width(1);
totalAverages = 0;

for i= 2:totalWidth
    if(abs(width(i-1)-width(i)) < 100)
        average = mean([average,width(i)]);
    else
        totalAverages = [totalAverages, average];
    end
end