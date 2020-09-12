x = 0 : 0.001 : 1.7;
e = 70 + 4500j;
d = 5;
Rh = (sin(x) - sqrt(e - power(cos(x), 2)))./(sin(x) + sqrt(e - power(cos(x), 2)));
Rv = (e*sin(x) - sqrt(e - power(cos(x), 2)))./(e*sin(x) + sqrt(e - power(cos(x), 2)));
plot(x, (Rh.^2 + Rv.^2)/2);