function [pop]=INTinti(num,bounds)
%[pop]=INTinti(num,bounds)
%inti     编码函数
%num      种群数
%bounds   边界约束
%           作者：机自01-2班曾新海
%           zxh21st@163.com
n=size(bounds,1);
L=bounds(:,2)-bounds(:,1);
p=rand(num,n);
for i=1:num
    p(i,:)=round(p(i,:).*L');
    pop(i,:)= p(i,:)+bounds(:,1)';
    f(i)=myfun(pop(i,:));
end
pop=[pop f'];