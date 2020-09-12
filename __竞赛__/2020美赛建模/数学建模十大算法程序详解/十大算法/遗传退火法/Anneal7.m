function [X2,fX2] = Anneal(x,fx,FitnessFcn,B,stepSize,A,LB,UB,R,L,t)
GenomeLength = length(x);
Lbnd = B(1,:);
Ubnd = B(2,:);
span = max([sqrt(eps)*x;min([x-Lbnd;Ubnd-x])]);
scale = stepSize * span;

X2=[];fX2=[];
r=0; l=0; nb=0;
while r<R && l<L
    x2 = x  + scale .* randn(1,GenomeLength);
    y2 = (A*x2')';
    if all(LB'<y2 & y2<UB');
        l = l+1;
        fx2 = feval(FitnessFcn,x2);
        delta_f = fx2 - fx;
        if delta_f < 0
            nb = 0;
            r = r+1;
            x = x2;
            fx = fx2;
            span = min([x-Lbnd;Ubnd-x]);
            scale = stepSize * span;
            X2 = [X2;x2];
            fX2 = [fX2;fx2];
        elseif exp(-delta_f/t) > rand
            nb = 0;
            r = r+1;
            x = x2;
            fx = fx2;
            span = min([x-Lbnd;Ubnd-x]);
            scale = stepSize * span;
            X2 = [X2;x2];
            fX2 = [fX2;fx2];
        else
            nb = nb + 1;
            if nb == 10*GenomeLength
                stepSize = stepSize / 10;
                scale = stepSize * span;
            elseif nb == 30*GenomeLength
                stepSize = min(2,stepSize * 20);
                scale = stepSize * span;
            elseif nb == 50*GenomeLength
                stepSize = stepSize / 40;
                scale = stepSize * span;
                nb = 0;
            end
        end
    else
        nb = nb + 1;
    end
end