function result = markov(noiseHist)
  # functin to return markov probability function
  # prevone is the last value
  # prevtwo is the second last value
 
  # first set the lower bound to 0 and upper bound to 100
  # set threshold to 0.28 * upper
  lower = 0;          
  upper = 100;
  threshold = 0.28 * upper;
  count = 0;
  prevNoise = length(noiseHist);
  while(prevNoise > 0 && noiseHist(prevNoise) <= threshold)
    count += 1;
    prevNoise = prevNoise - 1;
  end
  count
  val = 1;
  while(count > 0)
    count -= 1;
    val = val * 1.02;
  end
  val
endfunction