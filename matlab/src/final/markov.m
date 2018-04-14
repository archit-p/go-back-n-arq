function result = markov(threshold, noiseHist)
  % functin to return markov probability function
  % noiseHist if the history of noiseHist
  % threshold is the border value

  % first set the lower bound to 0 and upper bound to 100
  % set threshold to 0.28 * upper
  lower = 0;
  upper = 100;
  count = 0;
  prevNoise = length(noiseHist);
  % loop to count the number of previous noise bellow the threshold
  while(prevNoise > 0 && noiseHist(prevNoise) <= threshold)
    count = count + 1;
    prevNoise = prevNoise - 1;
  end

  % predict a value
  pred = randi([lower, upper], 1);

  % decrement the value by 5 * count to increase noise probability
  while(count > 0)
    count = count - 1;
    pred = pred - 5;
  end

  % neaten the values by removing exceptional cases
  if(pred < 0)
    pred = 0;
  end
  if(pred > upper)
    pred = upper;
  end

  %return the prediction
  result = pred;
