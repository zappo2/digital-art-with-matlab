%% Catterplot.
N=8;  % number of cats
newplot
text(1:N,(1:N)+rand(1,N)*1.5-.75,char([55357 56328]),...
     'Color',"#fb6",'FontSize',24,...
     'HorizontalAlignment','center',...
     'VerticalAlignment','middle');
title('Catterplot');
xlabel('Pawsition');
ylabel('Meowmentum');
axis([0 N+1 0 N+1]);
box on
grid on

