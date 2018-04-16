%Function to plot graph
n = 1000;
Mark = [];
Gn = [];
Overall = 500;

w = 1;
Y =[];
while(w <= Overall)
  w
  mk = 0;
  gn = 0;
  number = 100;
  for i = 1:number
    mk = mk + main_large(w,n);
    gn = gn +general_large(w,n);
  end

  mk = mk /number;
  gn = gn/number;
  Mark = [Mark mk];
  Gn = [Gn gn];
  Y = [Y w];
  w = w + 4;
end



plot(Y,Mark)
hold on
plot(Y,Gn)
legend('Using Markov Channel','Without using Markov Channel','location','best')
xlabel('Window Size')
ylabel('Percentage error difference')
title('Plotted Graph')
