function [f,x]=myga(num,bounds,N,CP,P)
%[f,x]=ga(num,bounds,fun,N,CP,P) 
%[f,x]=myga([],bounds,[],[],[])
%该遗传算法适用于：
%           目标函数为求最大值，且解非负整数解
%bounds     边界约束
%Myfun      为目标函数
%num        初始种群数
%N          最大迭代次数
%CP         交叉概率
%P          突变概率
%f          目标最优解
%x          最优解向量
%           作者：机自01-2班曾新海
%           zxh21st@163.com
m=nargin;
if m<5
disp('-_-  错误!')
disp('>> 输入变量太少')
disp('>>  按回车键查看帮助')
    pause
    help ga
    f='-_- ';
    x='没有规矩不成方圆';
    break;
end
if isempty(CP)
    CP=0.25;
end
if isempty(P)
    P=0.01;
end
if isempty(N)
    N=1000;
end
if any(bounds(:,1))<0
    disp('-_-  错误!')
disp('>>  按回车键查看帮助')
    pause
    help ga
    f='-_- ';
    x='没有规矩不成方圆';
    break;
end
if isempty(num)
    num=100;
end
pop=INTinti(num,bounds);
fmax=pop(:,end);
endpop=pop;
n=size(endpop,2);
count=0;x=[];f=zeros(1,num);
while(count<N)
    pop=mutation(endpop);
    [cpop ,len,v]=cross(pop,bounds,CP);
    [pops]=changes(cpop,bounds,len,P);
    for i=1:num
        sol=pops(i,:);
    [f(i)]=Myfun(sol);
    %惩罚策略
for jj=1:length(sol)
    if sol(jj)<bounds(jj,1)
        f(i)=-inf;
    end
    if sol(jj)>bounds(jj,2)
        f(i)=-inf;
    end
end
            if fmax(i)<f(i)
            fmax(i)=f(i);
            endpop(i,1:end-1)=pops(i,:);
        end
end
endpop(:,end)=fmax(:);
count=count+1;

% [f,ii]=max(fmax);
% x=endpop(ii,1:end-1);
end
[f,ii]=max(fmax);
x=endpop(ii,1:end-1);
