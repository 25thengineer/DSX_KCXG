function b = de2bi(d, n, p)
%function b = de2bi(d, n, p)
%DE2BI  转换10进制数为二进制数。
%        B = DE2BI(D) 转换正整数向量D成二进制矩阵B。
%        二进制矩阵B的每一行表示十进制向量D中相应的数。
%       B = DE2BI(D, N) 转换正整数向量D成二进制矩阵B，
%        但指定B的列数为N。
%       B = DE2BI(D, N, P) 转换正整数向量D成p进制矩阵B。
%      p进制矩阵B的每一行表示十进制向量D中相应的数。
%           作者：机自01-2班曾新海
%           zxh21st@163.com
d = d(:);len_d = length(d);
if min(d) < 0, error('Cannot convert a negative number');
elseif ~isempty(find(d==inf)),
     error('Input must not be Inf.');
elseif find(d ~= floor(d)), 
    error('Input must be an integer.');  
end;
if nargin < 2,
   tmp = max(d); b1 = [];
   while tmp > 0
      b1 = [b1 rem(tmp, 2)];tmp = floor(tmp/2);
   end;
   n = length(b1);
end;
if nargin < 3,p = 2;end;
b = zeros(len_d, n);
for i = 1 : len_d
   j = 1;tmp = d(i);
   while (j <= n) & (tmp > 0)
      b(i, j) = rem(tmp, p);tmp = floor(tmp/p);
      j = j + 1;
end;end;

