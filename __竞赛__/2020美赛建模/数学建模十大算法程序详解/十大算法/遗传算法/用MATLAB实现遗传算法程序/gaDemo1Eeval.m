function [sol, eval] =gaDemo1Eeval(sol,options)
x=sol(1);
eval = x + 10*sin(5*x)+7*cos(4*x);

%参数说明
%eval：个体的适应度； 
%sol：当前个体，n+1个元素的行向量。

