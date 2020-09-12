function [f,x]=myga(num,bounds,Myfun,N,CP,P)
%[f,x]=ga(num,bounds,fun,N,CP,P)
%该遗传算法适用于：
%           目标函数为求最大值，且解非负整数解
%bounds     边界约束
%Myfun        为目标函数
%num        初始种群数
%N          最大迭代次数
%CP         交叉概率
%P          突变概率
%f          目标最优解
%x          最优解向量
%           作者：机自01-2班曾新海
%           zxh21st@163.com
m=nargin;
if m<6
disp('-_-  错误!')
disp('>> 输入变量太少')
disp('>>  按回车键查看帮助')
    pause
    help ga
    f='-_- ';
    x='没有规矩不成方圆';
    break;
end
pop=INTinti(num,bounds);
fmax=pop(:,end);
endpop=pop;
n=size(endpop,2);
k=0;x=[];f=zeros(1,num);
while(k<N)
    pop=mutation(endpop);
    [cpop ,len,v]=cross(pop,bounds,CP);
    [pops]=changes(cpop,bounds,len,P);break;
    for i=1:num
        sol=pops(i,:);
        [f(i)]=Myfun(sol);
        if fmax(i)<f(i)
            fmax(i)=f(i);
            endpop(i,1:end-1)=pops(i,:);
        end
end
endpop(:,end)=fmax(:);
k=k+1;
end
[f,ii]=max(fmax);
x=endpop(ii,1:end-1);
