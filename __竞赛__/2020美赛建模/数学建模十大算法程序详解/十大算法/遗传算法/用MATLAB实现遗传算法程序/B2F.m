function  [B,len,v]=B2F(sol,bounds)
%[B,len]=B2F(x,bounds)    二进制编码函数
%x                        编码向量如x=[6 8 9];
%bounds                   边界约束ru如bounds=[4 8 ;3  11;6  12;];
%B                        二进制编码串
%编码长度L由bounds(2)-bounds(1)决定
%以上为例:
%     编码长度向量L=[4 8 6]编成二进制L=[11 1000 110],则len=[2 4 3]
%     计算B=x-bound(1)=[2 5 3]编成二进制 B=[10 0101 011]
%           作者：机自01-2班曾新海
%           zxh21st@163.com
n=length(sol);
len=[];B=[];v=[];
L=bounds(:,2)-bounds(:,1);
L=de2bi(L);
for i=1:n
len(i)=length(L(i,:));
end
v=sol-bounds(:,1)';
for i=1:n
    B=[B de2bi(v(i),len(i))];
end
