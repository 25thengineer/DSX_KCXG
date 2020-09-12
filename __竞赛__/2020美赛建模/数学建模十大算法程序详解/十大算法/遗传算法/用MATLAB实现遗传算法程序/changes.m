function [pops]=changes(cpop,bounds,len,p)
%基因突变函数
%function [pops]=changes(pop,bounds,len,p)
%pop        种群数目
%bounds     边界约束
%len        每个变量的编码长度
%           如len为[4 3 3];表示有三个变量，第一个变量的二进制编码长度为4,依次类推
%p          突变概率
%pops       返回突变后的基因
%p1         基因突变数目
%           作者：机自01-2班曾新海
%           zxh21st@163.com
if isempty(p)
    p=0.01;
end
[n,m]=size(cpop);
pop=cpop;
p1=round(sum(len)*n*p);
k=0;q=[];v=[];
while(k<p1)
    k=k+1;
    q(k)=round(rand*(sum(len)*n-1))+1;
    for i=1:k-1
        if q(k)==q(i)
            q(k)=[];
            k=k-1;
        end
    end
end

for i=1:n
[B(i,:),len]=B2F(pop(i,:),bounds);
end

v=reshape(B,1,n*sum(len));

for i=1:p1
    if v(q(i))==0
        v(q(i))=1;
    else
        v(q(i))=0;
    end
end
v=reshape(v,n,sum(len));
for i=1:n
   pop(i,:)=F2B(v(i,:),bounds,len);
end
pops=pop
cpop
