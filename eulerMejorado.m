syms x;
syms y;
format short
%f1 = -2*x^3 + 12*x^2-20*x+8.5;
%f1 = cos(2*x)


eq = input('Ingrese la ecuacion: ', 's');
x_0 = input('Ingrese x_0: ');
y_0 = input('Ingrese y_0: ');
x_n = input('Ingrese x_n: ');
h = input('Ingrese h: ');
n = x_n / h;

fnpar = '@(x,y)';
full_eq = strcat(fnpar,eq);
fn = str2func(full_eq);

%REEMPLAZAR ESTOS VALORES POR SI REQUIERE HACER PRUEBAS
% x_0 = 0;
% y_0 = 0;
% x_n = 2;
% h = 0.5;
% n = x_n / h


%fn = @(x,y) cos(2*x);

fx = @(x,y) sin(2*x);
h = (x_n - x_0)/n;

x_i = zeros(n,1);
y_i = zeros(n,1);
f_x = zeros(n,1);
e_r = zeros(n,1);

eum = @(x,y,h) y + h * ((fn(x,y) + fn(x + h, y + h * fn(x,y)))/2);

j = 1;

for i=x_0:h:x_n
    x_i(j) = i;

    if j == 1
        y_i(j) = y_0;
        e_r(j) = 0;
    else
        y = y_i(j-1);
        x = x_i(j-1);
        %y_i(j) = fn(x,y);
        y_i(j) = eum(x,y,h);
        
    end 
    f_x(j) = fx(i,y)/2;
    
    if j > 1
        e_r(j) = abs((f_x(j) - y_i(j))/f_x(j))*100;
    end
    j=j+1;
end


t = table(x_i,y_i,f_x,e_r);
disp(t);
