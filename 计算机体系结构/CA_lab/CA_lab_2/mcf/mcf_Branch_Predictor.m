y=[16943797	15400844	6221643	6186787	6186481	6186481];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'taken', 'Not-taken', 'bimod(512)','Bimod(1024)','2-level-1024','2-level-64'}, 'FontSize', 16)
%set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('Misses', 'FontSize', 16);
xlabel('Predictive method', 'FontSize', 16);
ylabel('Total misses', 'FontSize', 16);
title('The relevance between branch prediction failure efficiency and predictive method (based on mcf dataset)', 'FontSize', 16);