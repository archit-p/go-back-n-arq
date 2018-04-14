function result = testmarkov(len, numreq)
  # function to test the working of markov channel
  # numreq is the number of requests to test the working
  # len is the length of previous noise
  threshold = 28;
  prob = 0;
  i = 0;
  noise = ones(1, len);
  i = 0;
  while(i < numreq)
    num = markov(threshold, noise);
    if(num < threshold)
      prob++;
    end
    i++;
  end
  result = prob/numreq;