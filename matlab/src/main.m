%Clear the Screens
clc;
clear all;

%Input the required details
n=input('Number Of Frames: ');
w=input('Window Size: ');


%To ensure no errors
while w>n
  w=input('Invalid window size - cannot be bigger than number of frames.\nRe-enter window size: ')
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




%Starting protocol
while flag==0
  if flag2==0


    %Transmitting The Frames In A Window
    for i=1:w
    %transmitting all frames in the window
      fprintf('Frame %d Transmitted\n',a(pt));
      label =strcat('Frame ',num2str(a(pt)) ,' Transmitted');
      unsentframes = unsentframes-1;
      windowframes = windowframes+1;
      graphbar(sentframes,windowframes-sentframes,unsentframes,label)
      pt=pt+1;
    end


    %Signalling the end of the window
    flag2=1;
  end


  %Setting the noise in the station
  noise = randi(10,1,1);

  %Event of frame acknowledged
  if noise>2
    fprintf('Ackowledgement of Frame %d Received\n',a(pt-w));
    label =strcat('Acknowledgement of Frame ',num2str(a(pt-w)) ,' Received');
    sentframes = sentframes+1;
    graphbar(sentframes,windowframes-sentframes,unsentframes,label)

    %Checking corner case
    if pt==n+1
      fprintf('Frame %d Transmitted\n',a(pt-1));
      label =strcat('Frame ',num2str(a(pt-1)) ,' Transmitted');
    else
      fprintf('Frame %d Transmitted\n',a(pt));
      label =strcat('Frame ',num2str(a(pt)) ,' Transmitted');
    end

    windowframes = windowframes+1;
    unsentframes = unsentframes-1;
    graphbar(sentframes,windowframes-sentframes,unsentframes,label)
    if pt==n + 1 || a(pt) == n
      flag=1;
    end
    pt=pt+1;

  %No acknowledgement
  else
    fprintf('No Acknowledgement of Frame %d Received\n',a(pt-w));
    label =strcat('No Acknowledgement of Frame ',num2str(a(pt-w)) ,' Received');
    graphbar(sentframes,windowframes-sentframes,unsentframes,label)

    %Discarding waiting frames
    for j=w-1:-1:1
      fprintf('Frame %d Discarded\n',a(pt-w+j));
      label =strcat('Frame ',num2str(a(pt-w+j)) ,' Discarded');
      windowframes=windowframes-1;
      unsentframes=unsentframes+1;
      graphbar(sentframes,windowframes-sentframes,unsentframes,label)
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
  noise = randi(10,1,1);

  %Acknowledgement of frames
  if noise>3
    fprintf('Acknowledgement of Frame %d Received\n',a(i));
    label =strcat('Acknowledgement of Frame ',num2str(a(i)) ,' Received');
    sentframes = sentframes+1;
    graphbar(sentframes,windowframes-sentframes,unsentframes,label)
    i=i+1;

  %Non Acknowledgement of frames
  else
    fprintf('No Acknowledgement of Frame %d Received\n',a(i));
    label =strcat('No Acknowledgement of Frame ',num2str(a(i)) ,' Received');
    graphbar(sentframes,windowframes-sentframes,unsentframes,label)
    for j=n:-1:i+1
      fprintf('Frame %d Discarded\n',a(j));
      label =strcat('Frame ',num2str(a(j)) ,' Discarded');
      windowframes=windowframes-1;
      unsentframes=unsentframes+1;
      graphbar(sentframes,windowframes-sentframes,unsentframes,label)
    end
    windowframes=windowframes-1;
    unsentframes=unsentframes+1;

    %Retransmitting frames
    for k=i:n
      fprintf('Frame %d Transmitted\n',a(k));
      label =strcat('Frame ',num2str(a(k)) ,' Transmitted');
      windowframes = windowframes+1;
      unsentframes = unsentframes-1;
      graphbar(sentframes,windowframes-sentframes,unsentframes,label)
    end

  end
end
