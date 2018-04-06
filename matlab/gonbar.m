% program for GO BACK N protocol analysis

clc; clear all; close all;

n=input('Enter the lengthof data (no. of bits): ');
m=input('Enter the number of packets: ');
x=randi([0,1],m,n);

% Cyclic Redundancy Check Coding
figure
div=[1 0 0 1];        % predetermined divisor
for i=1:m
    [q,r]=deconv(x(i,:),div);
   y(i,:)=[x(i,:),zeros(1,3)];
   for k=1:n
           r(k)=mod(r(k),2);
   end
   fcs=[zeros(1,3),r];        % frame check sequence
   pac(i,:)=bitxor(y(i,:),fcs);

   subplot(m,1,i);
   bar(pac(i,:),0.5,'stacked'),colormap(cool);
   clear r;clear rem;
end
xlabel('Data coded with CRC');

% Cyclic coding of Data
figure
gen=cyclpoly(15,n+3,'min');
pac2=encode(pac,15,n+3,'cyclic',gen);
for i=1:m
subplot(m,1,i);
   bar(pac2(i,:),0.5,'stacked'),colormap(cool);
end
xlabel('Cyclic Coded data transmitted');


% Transmission of packets through a Binary Symmetric Channel
pe=input('Enter the value of pe: ');
z=1;flag=0;nt=0;
while(flag==0)
figure
for k=z:m

    rcvdata(k,:)=bsc(pac2(k,:),pe);   % data - Received packets after bsc Tx
    subplot(m,1,k); bar(rcvdata(k,:),0.5,'stacked'),colormap(cool);
    nt=nt+1;
end
xlabel('Recieved Data packets');

figure
%Error correction through Cyclic decoding
rcvdata2=decode(rcvdata,15,n+3,'cyclic',gen);
for k=z:m
subplot(m,1,k); bar(rcvdata2(k,:),0.5,'stacked'),colormap(cool);
end
xlabel('Data after decoding');

err = 1;
for i=1:m
    [q2,r2]=deconv(rcvdata2(i,:),div);
           r2(1,:)=mod(r2(1,:),2);
    if r2==0
        err(1,i)=0;
    else
        err(1,i)=1;
    end
end
display(err);   %this shows the packet in error

    for z=1:m+1
       if(z==m+1)
           break;
       elseif err(1,z)==1
                 break;
       end

    end

if z==m+1
    display(' TRANSMISSION SUCCESSFUL');
    fprintf('Total no. of packets sent: %d\n',nt);
    flag=1;
    break;
else
    display('Retransmission Required');
end
end
