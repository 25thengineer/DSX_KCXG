function [child]=mutation(pop)
%复制函数，采取小盘轮转法
%[child]=mutation(pop)
%mutation    编码
%pop         初始种群
%child       返回复制后的种群
%pop(:,end)  适值度
%           作者：机自01-2班曾新海
%           zxh21st@163.com
[n,m]=size(pop);
f=pop(:,end);
value=sum(f);
for i=1:n
    p(i)=f(i)/value;
    q(i)=sum(p(1:i));
end
    t=rand(1,n);
for j=1:n
    for k=1:n
        if t(j)<q(k)
            v(j)=k;
            break
        end
    end
end
    i=1:n;
    child(i,:)=pop(v(i),:);


