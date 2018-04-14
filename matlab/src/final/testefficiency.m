function n= testefficiency(p,m)
%function to test efficiency function
% p is the probability of the transmission success and m is the range of number of blocks to be tested for

for j=1:m
  n= efficiency(p,j)
end
endfunction
