function  [newpop ,len]=xcross(child,bounds,CP)
 mychild=child(:,1:end-1);
[B(1,:),len]=B2F(mychild(1,:),bounds);
newpop=B(1,:);