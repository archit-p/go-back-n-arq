lower = 0;
numreq = 100;
upper = numreq * 10;
threshold = 0.28 * upper;
prev = "False";
while(numreq > 1)
  guess = randi([lower, upper], 1)
  if(guess > threshold)
    lower += 1;
  else
    lower -= 2;
  end
  numreq -= 1;
end