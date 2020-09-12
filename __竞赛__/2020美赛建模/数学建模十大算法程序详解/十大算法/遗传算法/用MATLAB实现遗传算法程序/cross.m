function  [cpop ,len,v]=cross(child,bounds,CP)
%交叉函数，采取点交叉
%[newpop ,len]=cross(child,bounds,CP)
%child      复制后的种群
%bounds     边界约束
%CP         交叉概率
%newpop     交叉后的新种群
%len        每个变量的编码长度
%           如len返回为[4 3 3];表示有三个变量，第一个变量的二进制编码长度为4,依次类推
%           作者：机自01-2班曾新海
%           zxh21st@163.com
if isempty(CP)
    CP=0.25;
end
[n ,m]=size(child);
B=[];len=[];t=[];
mychild=child(:,1:end-1);
v=[];
p=rand(1,n);
k=1;
    for i=1:n
        if p(i)<CP
            v(k)=i;
            k=k+1;
        end
    end
    if (rem(k,2)==0)
        temp=v(k-1);
        while (temp==v(k-1))
        temp=round(rand*(n-1))+1;
    end
    v(k)=temp;
    k=k+1;
   end 
if isempty(v)
    [B(i,:),len]=B2F(mychild(1,:),bounds);
    B=[];
else
    for i=1:k-1
[B(i,:),len]=B2F(mychild(v(i),:),bounds);
end
for i=1:2:k-2
    p2=round(rand*sum(len)-1)+1;
    t=zeros(1,p2);
    t(i,:)=B(i,1:p2);
    B(i,1:p2)=B(i+1,1:p2);
    B(i+1,1:p2)=t(i,:);
end
for i=1:k-1
   mychild(v(i),:)=F2B(B(i,:),bounds,len);
end
end
cpop=mychild;




