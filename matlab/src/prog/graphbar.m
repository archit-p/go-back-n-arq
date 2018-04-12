%Function to visualize the protocol
function graphbar(sent,wind,unsent,label)

%Bar graph plotting
bar([sent wind unsent;sent 0 0],0.1,'stacked')
legend({'Sent and acknowledged packets','Unacknowledged packets','Unsent packets'},'location','north')
set(gca,'xticklabel', {'Sender side','Receiver side'})
title(label)

%Continue to next stage
n=input('Press Enter to continue');
