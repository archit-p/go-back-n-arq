function gonbar(sent,wind,unsent,label)
bar([sent wind unsent;sent 0 0],0.1,'stacked')
legend({'Sent and acknowledged packets','Unacknowledged packets','Unsent packets'},'location','north')
set(gca,'xticklabel', {'Sender side','Receiver side'})
title(label)
n=input('Press Enter to continue');
