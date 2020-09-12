y=[14035938	16910752	5136299	4473381	4029194	4029194];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'taken', 'Not-taken', 'bimod(512)','Bimod(1024)','2-level-1024','2-level-64'}, 'FontSize', 16)
%set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('Misses', 'FontSize', 16);
xlabel('Predictive method', 'FontSize', 16);
ylabel('Total misses', 'FontSize', 16);
title('The relevance between branch prediction failure efficiency and predictive method (based on gcc dataset)', 'FontSize', 16);