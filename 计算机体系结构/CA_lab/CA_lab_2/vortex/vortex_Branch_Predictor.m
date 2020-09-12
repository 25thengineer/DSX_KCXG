y=[26610	49310	6723	6155	5710	5710];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'taken', 'Not-taken', 'bimod(512)','Bimod(1024)','2-level-1024','2-level-64'}, 'FontSize', 16)
%set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('Misses', 'FontSize', 16);
xlabel('Predictive method', 'FontSize', 16);
ylabel('Total misses', 'FontSize', 16);
title('The relevance between branch prediction failure efficiency and predictive method (based on vortex dataset)', 'FontSize', 16);