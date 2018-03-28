# sliding window mechanism with some features
# such as labeling, annotation, nam-graph, and window size monitoring

set ns [new Simulator]

set n0 [$ns node]
set n1 [$ns node]

$ns at 0.0 "$n0 label Sender"
$ns at 0.0 "$n1 label Receiver"
$n0 color red
$n1 color blue



set nf [open A3-sliding-window.nam w]
$ns namtrace-all $nf
#set f [open A3-sliding-window.tr w]
#$ns trace-all $f

$ns duplex-link $n0 $n1 0.2Mb 200ms DropTail
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n0 $n1 color green
$ns queue-limit $n0 $n1 10

Agent/TCP set nam_tracevar_ true

set tcp [new Agent/TCP]
$tcp set windowInit_ 4
$tcp set maxcwnd_ 4

$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

$ns connect $tcp $sink






set ftp [new Application/FTP]
$ftp attach-agent $tcp



$ns add-agent-trace $tcp tcp
$ns monitor-agent-trace $tcp
$tcp tracevar cwnd_

$ns at 0.1 "$ftp start"
$ns at 0.68 "$ftp stop"
$ns at 1.07 "$ftp start"
$ns at 1.51 "$ftp stop"
$ns at 1.638 "$ftp start"
$ns at 2.078 "$ftp stop"
$ns at 2.206 "$ftp start"
$ns at 2.646 "$ftp stop"
$ns at 2.774 "$ftp start"
$ns at 3.214 "$ftp stop"
$ns at 3.342 "$ftp start"
$ns at 3.654 "$ftp stop"
$ns at 3.8 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n1 $sink"
$ns at 4.0 "finish"

$ns at 0.0 "$ns trace-annotate \"Sliding Window with window size 4 (normal operation)\""

$ns at 0.05 "$ns trace-annotate \"FTP starts at 0.1\""
$ns at 0.05 "$ns trace-annotate \"\""
$ns at 0.05 "$ns trace-annotate \"\""
$ns at 0.5 "$ns trace-annotate \"Send Packet_0,1,2,3\""
$ns at 0.5 "$ns trace-annotate \"\""
$ns at 0.5 "$ns trace-annotate \"\""
$ns at 0.95 "$ns trace-annotate \"Receive Ack_0,1,2,3\""
$ns at 0.95 "$ns trace-annotate \"\""
$ns at 0.95 "$ns trace-annotate \"\""
$ns at 1.07 "$ns trace-annotate \"Send Packet_4,5,6,7\""
$ns at 1.07 "$ns trace-annotate \"\""
$ns at 1.07 "$ns trace-annotate \"\""
$ns at 1.52 "$ns trace-annotate \"Receive Ack_4,5,6,7\""
$ns at 1.52 "$ns trace-annotate \"\""
$ns at 1.52 "$ns trace-annotate \"\""
$ns at 1.638 "$ns trace-annotate \"Send Packet_8,9,10,11\""
$ns at 1.638 "$ns trace-annotate \"\""
$ns at 1.638 "$ns trace-annotate \"\""
$ns at 2.088 "$ns trace-annotate \"Receive Ack_8,9,10,11 \""
$ns at 2.088 "$ns trace-annotate \"\""
$ns at 2.088 "$ns trace-annotate \"\""
$ns at 2.206 "$ns trace-annotate \"Send Packet_12,13,14,15\""
$ns at 2.206 "$ns trace-annotate \"\""
$ns at 2.206 "$ns trace-annotate \"\""
$ns at 2.656 "$ns trace-annotate \"Receive Ack_12,13,14,15\""
$ns at 2.656 "$ns trace-annotate \"\""
$ns at 2.656 "$ns trace-annotate \"\""
$ns at 2.774 "$ns trace-annotate \"Send Packet_16,17,18,19\""
$ns at 2.774 "$ns trace-annotate \"\""
$ns at 2.774 "$ns trace-annotate \"\""
$ns at 3.224 "$ns trace-annotate \"Receive Ack_16,17,18,19\""
$ns at 3.224 "$ns trace-annotate \"\""
$ns at 3.224 "$ns trace-annotate \"\""
$ns at 3.342 "$ns trace-annotate \"Send Packet_20,21,22,23\""
$ns at 3.342 "$ns trace-annotate \"\""
$ns at 3.342 "$ns trace-annotate \"\""
$ns at 3.792 "$ns trace-annotate \"Receive Ack_20,21,22,23\""
$ns at 3.792 "$ns trace-annotate \"\""
$ns at 3.792 "$ns trace-annotate \"\""

$ns at 3.94 "$ns trace-annotate \"FTP stops\""
$ns at 3.94 "$ns trace-annotate \"\""
$ns at 3.94 "$ns trace-annotate \"\""
proc finish {} {
        global ns
        $ns flush-trace

#       puts "filtering..."
#       exec tclsh ../bin/namfilter.tcl A3-sliding-window.nam
       puts "running nam..."
       exec nam A3-sliding-window.nam &

        exit 0
}

$ns run
