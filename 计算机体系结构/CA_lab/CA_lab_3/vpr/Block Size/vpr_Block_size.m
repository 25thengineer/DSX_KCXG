y=[0.1772 	0.0917 	0.0489	0.0271 ];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'*2','*4','*8','*64'}, 'FontSize', 16)
%set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('Miss rate', 'FontSize', 16);
xlabel('Size of Cache block', 'FontSize', 16);
ylabel('Miss rate', 'FontSize', 16);
title('The relevance between L2 cache failure efficiency and the size of Cache block (based on vpr dataset)', 'FontSize', 16);