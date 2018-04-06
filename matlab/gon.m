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
