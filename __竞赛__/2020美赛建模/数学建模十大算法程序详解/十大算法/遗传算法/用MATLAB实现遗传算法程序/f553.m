function [sol,eval]=f553(sol,options)
m(1)=sol(1);
m(2)=sol(2);
m(3)=sol(3);
%失效概率矩阵
q=[0.01 0.05 0.10 0.18;
0.08 0.02 0.15 0.12;
0.04 0.05 0.20 0.10];
%约束条件
g1=51-(m(1)+3).^2+m(2).^2+m(3).^2;
g2=20*sum(m+exp(-m))-120;
g3=20*sum(m.*exp(-m/4))-65;
%计算加惩罚项的适值
if ((g1>=0)&(g2>=0)&(g3>=0))
  multi=1;
  for i=1:3
     summ=0;
     for j=2:4
        summ=summ+q(i,j).^(m(i)+1);
     end      
     multi=multi*(1-(1-(1-q(i,1)).^(m(i)+1))-summ);
  end
  eval=multi;
else
%取M=500
  eval=-500;
end
