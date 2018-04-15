function result = markov(prev)
  lower = 0;
  numreq = 100;
  upper = numreq * 10;
  threshold = 0.28 * upper;
  %prev = "False";
  while(numreq > 1)
    guess = randi([lower, upper], 1)
    if(guess > threshold)
      lower = lower + 10;
    else
      lower = lower - 20;
    end
    if(lower < 0)
      lower = 0;
    end
    numreq = numreq - 1;
  end
endfunction