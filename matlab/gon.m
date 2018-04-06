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
