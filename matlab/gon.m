clc;
clear all;
n=input('Number Of Frames: ');
w=input('Window Size: ');
while w>n
  w=input('Invalid window size - cannot be bigger than number of frames.\nRe-enter window size: ')
end
sentpackets=0;
windowpackets=0;
unsentpackets=n;
pt=1;
flag=0;
flag2=0;
a=1:n;
while flag==0
  if flag2==0
    %Transmitting The Frames In A Window
    for i=1:w
      fprintf('Frame %d Transmitted\n',a(pt));
      label =strcat('Frame ',num2str(a(pt)) ,' Transmitted');
      windowpackets = windowpackets+1;
      unsentpackets = unsentpackets-1;
      gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
      pt=pt+1;
    end
    flag2=1;
  end
  s = randi(10,1,1);
  if s>2
    fprintf('PAK of Frame %d Received\n',a(pt-w));
    label =strcat('PAK of Frame ',num2str(a(pt-w)) ,' Received');
    sentpackets = sentpackets+1;
    gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    fprintf('Frame %d Transmitted\n',a(pt));
    label =strcat('Frame ',num2str(a(pt)) ,' Transmitted');
    windowpackets = windowpackets+1;
    unsentpackets = unsentpackets-1;
    gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    if a(pt)==n
      flag=1;
    end
    pt=pt+1;
  else
    fprintf('NAK Of Frame %d Received\n',a(pt-w));
    for j=w-1:-1:0
      fprintf('Frame %d Discarded\n',a(pt-w+j));
      label =strcat('Frame ',num2str(a(pt-w+j)) ,' Discarded');
      windowpackets=windowpackets-1;
      unsentpackets=unsentpackets+1;
      gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    end
    pt=pt-w;
    flag2=0;
  end
end
%Last 'W' Frames are dealt seperately
i=n-w+1;
while (i<=n)
  s = randi(10,1,1);
  if s>3
    fprintf('PAK of Frame %d Received\n',a(i));
    label =strcat('PAK of Frame ',num2str(a(i)) ,' Received');
    sentpackets = sentpackets+1;
    gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    i=i+1;
  else
    fprintf('NAK of Frame %d Received \n',a(i));
    for j=n:i
      fprintf('Frame %d Discarded\n',a(j));
      label =strcat('Frame ',num2str(a(j)) ,' Discarded');
      windowpackets=windowpackets-1;
      unsentpackets=unsentpackets+1;
      gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    end
    for k=i:-1:n
      fprintf('Frame %d Transmitted\n',a(k));
      label =strcat('Frame ',num2str(a(k)) ,' Transmitted');
      windowpackets = windowpackets+1;
      unsentpackets = unsentpackets-1;
      gonbar(sentpackets,windowpackets-sentpackets,unsentpackets,label)
    end
  end
end
