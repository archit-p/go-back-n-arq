threshold = 28;
numreq = 10;
prob = 0;
i = 0;
while(i < numreq)
  numone = randi([threshold, 100], 1)
  numtwo = randi([threshold, 100], 1)
  num = markov(numone, numtwo);
  if(num > threshold)
    prob++;
  end
  i++;
end
prob/numreq