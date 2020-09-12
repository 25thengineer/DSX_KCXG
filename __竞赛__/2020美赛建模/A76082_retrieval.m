input_f = 0;

a = 1.4114535 * power(10, -2);
b = -5.2122497 * power(10, -8);
c = 5.8547829 * power(10, -11);
d = -7.6717423 * power(10, -16);
e = 2.9856318 * power(10, -21);

r = 3.8586749;
s = 9.1253873 * power(10, -4);
t = 1.5309921 * power(10, -8);
u = -2.1179295 * power(10, -5);
v = 6.5727504 * power(10, -10);
w = -1.9647664 * power(10, -15);



%*************case 1**************%

f1 = input('input_f1 = ');

fprintf('f1 = %f1\n ', f1);

%{
¦År <--> x
~¦Å <--> y_1
¦Ò  <--> z
¦Ë  <--> lambda_1
%}

if( f1 <= 2253.5895 )
    x = 70;
else
    x = 1 / (a + b .* f1 + c .* f1 .* f1 + d .* f1 .* f1 .* f1 + e .* power(f1, 4) );
end

fprintf('¦År = %f1\n ', x);
%{
fprintf('ha = %f1\n', a + b * f1 + c * f1 * f1 + d * f1 * f1 * f1 + e * power(f1, 4) );
%}

if( f1 <= 1106.207 )
    z = 5.0;
else
    z = (r + s * f1 + t * f1 * f1) / (1 + u * f1 + v * f1 * f1 + w * f1 * f1 * f1 );
end

fprintf('¦Ò = %f1\n ', z);

lambda_1 = 0.7;		%lambda determines the lowest point

y_1 = complex(x, 60 * lambda_1 * z); % y_1 = x + i * 60 * lambda_1 * z

%{
fprintf('~¦Å = %s\n', y_1 );
%}
%disp(y_1);

%{
angle = input('¦È = ');
%}

angle = 0:0.001:1.6;
RH_1 = ( sin(angle) - sqrt(y_1 - power( cos(angle), 2) ) ) ./ ( sin(angle) + sqrt(y_1 - power( cos(angle), 2) ) );
RV_1 = ( y_1 * sin(angle) - sqrt(y_1 - power( cos(angle), 2) ) ) ./ ( y_1 * sin(angle) + sqrt(y_1 - power( cos(angle), 2) ) );

plot( angle, (RH_1.^2 + RV_1.^2) / 2, 'm--' );
hold on;
%legend('RH_1.^2 + RV_1.^2'),hold on;

%disp(RH_1);


%*************case 3**************%
f3 = input('input_f3 = ');

fprintf('f3 = %f3\n ', f3);

%{
¦År <--> x
~¦Å <--> y_1
¦Ò  <--> z
¦Ë  <--> lambda_1
%}

if( f3 <= 2253.5895 )
    x = 70;
else
    x = 1 / (a + b .* f3 + c .* f3 .* f3 + d .* f3 .* f3 .* f3 + e .* power(f3, 4) );
end

fprintf('¦År = %f3\n ', x);
%{
fprintf('ha = %f3\n', a + b * f3 + c * f3 * f3 + d * f3 * f3 * f3 + e * power(f3, 4) );
%}

if( f3 <= 1106.207 )
    z = 5.0;
else
    z = (r + s * f3 + t * f3 * f3) / (1 + u * f3 + v * f3 * f3 + w * f3 * f3 * f3 );
end

fprintf('¦Ò = %f3\n ', z);

lambda_3 = 1;

y_3 = complex(x, 60 * lambda_3 * z); % y_1 = x + i * 60 * lambda_1 * z

%{
fprintf('~ï¿½ï¿½ = %s\n', y_1 );
%}
%disp(y_3);

%{
angle = input('ï¿½ï¿½ = ');
%}

%angle = 0:0.001:1.6;
RH_3 = ( sin(angle) - sqrt(y_3 - power( cos(angle), 2) ) ) ./ ( sin(angle) + sqrt(y_3 - power( cos(angle), 2) ) );
RV_3 = ( y_3 .* sin(angle) - sqrt(y_3 - power( cos(angle), 2) ) ) ./ ( y_3 .* sin(angle) + sqrt(y_3 - power( cos(angle), 2) ) );

plot( angle, (RH_3.^2 + RV_3.^2) / 2, 'color','#000000' );
%plot(x,y,'r--')
hold on;

%*************case 2**************%



f2 = input('input_f2 = ');

fprintf('f2 = %f2\n ', f2);

%{
ï¿½ï¿½r <--> x
~ï¿½ï¿½ <--> y_1
ï¿½ï¿½  <--> z
ï¿½ï¿½  <--> lambda_1
%}

if( f2 <= 2253.5895 )
    x = 70;
else
    x = 1 / (a + b .* f2 + c .* f2 .* f2 + d .* f2 .* f2 .* f2 + e .* power(f2, 4) );
end

fprintf('ï¿½ï¿½r = %f2\n ', x);
%{
fprintf('ha = %f2\n', a + b * f2 + c * f2 * f2 + d * f2 * f2 * f2 + e * power(f2, 4) );
%}

if( f2 <= 1106.207 )
    z = 5.0;
else
    z = (r + s * f2 + t * f2 * f2) / (1 + u * f2 + v * f2 * f2 + w * f2 * f2 * f2 );
end

fprintf('ï¿½ï¿½ = %f2\n ', z);

lambda_2 = 0.9;

y_2 = complex(x, 60 * lambda_2 * z); % y_1 = x + i * 60 * lambda_1 * z

%{
fprintf('~ï¿½ï¿½ = %s\n', y_1 );
%}
%disp(y_1);

%{
angle = input('ï¿½ï¿½ = ');
%}

%angle = 0:0.001:1.6;
RH_2 = ( sin(angle) - sqrt(y_2 - power( cos(angle), 2) ) ) ./ ( sin(angle) + sqrt(y_2 - power( cos(angle), 2) ) );
RV_2 = ( y_2 * sin(angle) - sqrt(y_2 - power( cos(angle), 2) ) ) ./ ( y_2 * sin(angle) + sqrt(y_2 - power( cos(angle), 2) ) );

plot( angle, (RH_2.^2 + RV_2.^2) / 2, 'r--' );
hold on;
%legend('RH_2.^2 + RV_2.^2'),hold on;

%disp(RH_2);

legend('20 MHz', '5 MHz', '3 MHz'),hold on;
xlabel('Grazing incidence angle/rad');
ylabel('Power reflection coefficient');
title('Power reflection coefficient and the grazing incidence angle curve');