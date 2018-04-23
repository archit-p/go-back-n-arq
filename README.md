# Accurate Throughput Efficiency for the Go Back-N ARQ Protocol
The throughput efficiency for Go-Back-N is measured by the formula  
>                 n' = p/[p+m(1-p)]  

Where:
```
n = throughput efficiency under interference of random transmission errors,
m = round trip delay 
p = probability of successful block transmission
```
However this formula does not take into account the fact that burst errors are the most common means of transmission errors. This project aims to simulate the working of the Go Back N protocol in real world conditions and aim to generate a more accurate formula for throughput efficiency. Our work is inspired by the work of Leung et. al.<sup>[[1]](http://ieeexplore.ieee.org/document/2758/)</sup>

We've simulated a simple markov channel in Matlab. The probability that the next packet transmitted has an error depends on how many of the previous packets had an error.

## Getting Started
### File Structure
```
.
+-- matlab
|   +-- src 
|   +-- img
+-- ns2
+-- README.md
+-- DESIGN.md
+-- INTRODUCTION.md
```

### Tests
![Testing script outputs](matlab/img/markov.png)
The probability that the next packet has an error is 28% when no previous packet had an error. With each packet with an error, the next packet's probability of having an error goes up by 5%.

### Results
![Final Graph](matlab/img/Graph3.jpg)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
This project was carried out as part of the [Wireless Information and Networking Group, NITK](http://wing.nitk.ac.in/) under the supervision of [Prof. B. R. Chandravarkar](http://brc.nitk.ac.in).
