function [f]=myfun(sol,bnd)
%           作者：机自01-2班曾新海
%           zxh21st@163.com
x=sol;
n=length(x);
f=0;
for i=1:n
    f=f+x(i)*i;
end