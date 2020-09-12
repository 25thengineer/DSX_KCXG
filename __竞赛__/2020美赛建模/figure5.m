v = 0:0.001:20;
h = 0.0051 * v .^2;

%{
¦Ñ <----> x
¦È <----> v

%}
lambda = 20;
g = h .* sin(0.125) / lambda;
%I0 = 0.05;
z = 0:0.01:5;
I = zeros(5,501);
for nu = 0:4
    I(nu+1,:) = besseli(nu,z);
end


z = 0:0.001:20;
%I0(nu + 1,:) = besseli(nu, z);
x = exp(-1 / 2 .* (2 .* pi .* g ) .^2 ) .* I(0, 0) .* ( 1 / 2 .* (2 .* pi .* g ) .^2 );
plot(v, x, 'b');
hold on;