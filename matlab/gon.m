clc;
clear all;
n=input('Number Of Frames: ');
w=input('Window Size: ');
pt=1;
flag=0;
flag2=0;
a=1:n;
while flag==0
  if flag2==0
    %Transmitting The Frames In A Window
    for i=1:w
      fprintf('Frame %d Transmitted\n',a(pt));
      pt=pt+1;
    end
    flag2=1;
  end
  s = randi(10,1,1);
  if s>3
    fprintf('PAK of Frame %d Received\n',a(pt-w));
    fprintf('Frame %d Transmitted\n',a(pt));
    if a(pt)==n
      flag=1;
    end
    pt=pt+1;
  else
    fprintf('NAK Of Frame %d Received\n',a(pt-w));
    for j=0:w-1
      fprintf('Frame %d Discarded\n',a(pt-w+j));
    end
    pt=pt-w;
    flag2=0;
  end
end
%Last 'W' Frames are dealt seperately
i=n-w+1;
while (i<=n)
  s = randi(10,1,1);
  if s>4
    fprintf('PAK of Frame %d Received\n',a(i));
    i=i+1;
  else
    fprintf('NAK of Frame %d Received \n',a(i));
    for j=i:n
      fprintf('Frame %d Discarded\n',a(j));
    end
    for k=i:n
      fprintf('Frame %d Transmitted\n',a(k));
    end
  end
end
