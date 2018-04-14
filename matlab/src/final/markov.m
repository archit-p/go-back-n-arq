function result = markov(prevone, prevtwo)
  # functin to return markov probability function
  # prevone is the last value
  # prevtwo is the second last value
 
  # first set the lower bound to 0 and upper bound to 100
  # set threshold to 0.28 * upper
  lower = 0;          
  upper = 100;
  threshold = 0.28 * upper;
 
  # check if both thr previous guesses have been above threshold
  if(prevone > threshold && prevtwo > threshold)
    lower += 10;
  elseif(prevone > threshold)
    lower += 5;
  elseif(prevone < threshold && prevtwo < threshold)
    lower -= 10;
  elseif(prevone < threshold)
    lower -= 5;
  end
  if(lower < 0)
    lower = 0;
  end
  result = randi([lower, upper], 1);
endfunction