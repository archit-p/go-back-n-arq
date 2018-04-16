function n= efficiency(p,m)
%throughput efficiency of channel
Efficiency =p/(p+m*(1-p))
n = Efficiency;
