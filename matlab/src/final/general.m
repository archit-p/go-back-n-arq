%Clear the Screens
clc;
clear all;

%Input the required details
n=input('Number Of Frames: ');
w=input('Window Size: ');


%To ensure no errors
while w>=n
  w=input('Invalid window size - cannot be bigger than or equal to number of frames.\nRe-enter window size: ')
end

%Setting various variables
sentframes=0;
windowframes=0;
unsentframes=n;
pt=1;
flag=0;
flag2=0;

%Setting queue
a=1:n;

threshold = 28;
dropcount = 0;
fprintf('According to conventional formula\nThroughput efficiency is\n');

%Probability of packet being transmitted
p = 1 - threshold/100;
%RTT in terms of block delay
j = 2 * w;

oldef = efficiency(p,j);
pause(1.0);



%Starting protocol
while flag==0
  if flag2==0


    %Transmitting The Frames In A Window
    for i=1:w

      fprintf('Frame %d Transmitted\n',a(pt));
      unsentframes = unsentframes-1;
      windowframes = windowframes+1;
      pt=pt+1;
    end
    pause(2.0);

    %Signalling the end of the window
    flag2=1;
  end


  %Setting the noise in the station
  noise = randi(100,1,1);

  %Event of frame acknowledged
  pause(2.0);
  if noise>threshold
    fprintf('Ackowledgement of Frame %d Received\n',a(pt-w));
    sentframes = sentframes+1;

    %Checking corner case
    if pt==n+1
      fprintf('Frame %d Transmitted\n',a(pt-1));
    else
      fprintf('Frame %d Transmitted\n',a(pt));
    end

    windowframes = windowframes+1;
    unsentframes = unsentframes-1;

    if pt==n + 1 || a(pt) == n
      flag=1;
    end
    pt=pt+1;

  %No acknowledgement
  else
    dropcount = dropcount + 1;
    err = randi(10,1,1);

    %If corrupted frame received
    if err > 5
      fprintf('Corrupted Frame %d Received\n',a(pt-w));
    else
      pause(1.0);
      fprintf('No Acknowledgement of Frame %d Received\n',a(pt-w));
    end


    %Discarding waiting frames
    for j=w-1:-1:1
      fprintf('Frame %d Discarded\n',a(pt-w+j));
      windowframes=windowframes-1;
      unsentframes=unsentframes+1;

    end
    windowframes=windowframes-1;
    unsentframes=unsentframes+1;
    pt=pt-w;
    flag2=0;
  end
end


%Last 'W' Frames are dealt seperately
i=n-w+1;


while (i<=n)

  %Setting the noise in the station
  noise = randi(100,1,1);

  pause(2.0);
  %Acknowledgement of frames
  if noise>threshold
    fprintf('Acknowledgement of Frame %d Received\n',a(i));
    sentframes = sentframes+1;

    i=i+1;

  %Non Acknowledgement of frames
  else
    dropcount = dropcount + 1;
    err = randi(10,1,1);

    %If corrupted frame received
    if err > 5
      fprintf('Corrupted Frame %d Received\n',a(i));
    else
      pause(1.0);
      fprintf('No Acknowledgement of Frame %d Received\n',a(i));
    end


    for j=n:-1:i+1
      fprintf('Frame %d Discarded\n',a(j));
      windowframes=windowframes-1;
      unsentframes=unsentframes+1;

    end
    windowframes=windowframes-1;
    unsentframes=unsentframes+1;

    %Retransmitting frames
      pause(2.0);
    for k=i:n
      fprintf('Frame %d Transmitted\n',a(k));
      windowframes = windowframes+1;
      unsentframes = unsentframes-1;

    end

  end
end

fprintf('Calculated efficiency')
p = 1- (dropcount/(n+dropcount));

j = 2 * w;
newef = efficiency(p,j);

fprintf('Percentage difference is\n');

abs((newef-oldef)* 100/oldef)
