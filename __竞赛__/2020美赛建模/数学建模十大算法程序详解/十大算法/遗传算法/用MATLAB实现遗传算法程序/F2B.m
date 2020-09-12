function  [pops,len]=F2B(x,bounds,len)
%二进制编码转化为十进制
%[pops]=F2B(x,bounds,len)
%x       二进制串如x=[0 1 1  0 0 1 0  1 0 1 0 1]
%len     二进制串的分段len=[3  4  5]
%bounds  边界约束
%pops    十进制
%           作者：机自01-2班曾新海
%           zxh21st@163.com
n=length(x);
m=length(len);
q=[];
for i=1:m
q(i)=sum(len(1:i));
end
q=[0 q];
for j=1:m
    pops(j)=bounds(j,1);
    p=[];
    p=x(q(j)+1:q(j+1));
    L1=q(j+1)-q(j);
    for k=1:L1
        pops(j)=pops(j)+p(k)*2^(k-1);
    end
end

    


