y=[0.0911 	0.0842 	0.0835 	0.0830 	0.0838];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'2-way','4-way','8-way','16-way', '64-way'}, 'FontSize', 16)
%set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('Miss rate', 'FontSize', 16);
xlabel('Number of way', 'FontSize', 16);
ylabel('Miss rate', 'FontSize', 16);
title('The relevance between L2 cache failure efficiency and Cache coherence (based on mcf dataset)', 'FontSize', 16);