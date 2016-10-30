clc
clear all
close all

label = sprintf('obj height,skew factor,distance');
disp(label);

arr = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 20 25 30];

for arg=1:18
  input_dist = arr(arg);
  mainScript
end

for arg=26:43
  input_dist = arr(arg-25);
  mainScript
end