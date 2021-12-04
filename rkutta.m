syms x;
syms y;
format short


eq = input('Ingrese la ecuacion: ', 's');
x_0 = input('Ingrese x_0: ');
y_0 = input('Ingrese y_0: ');
x_n = input('Ingrese x_n: ');
h = input('Ingrese h: ');
res = input('La EDO tiene funcion solucion y/n ?: ', 's');
if res == 'y'
    eqsol = input('Ingrese la funcion solución: ', 's');
end
n = x_n / h;

fnpar = '@(x,y)';
full_eq = strcat(fnpar,eq);
fdydx = str2func(full_eq);


%REEMPLAZAR ESTOS VALORES POR SI REQUIERE HACER PRUEBAS
% x_0 = 0;
% y_0 = 0;
% x_n = 2;
% h = 0.25;
% n = 8;




if res == y
    fnsol = '@(x,y)';
    full_eqsol = strcat(fnsol,eqsol);
    fx = str2func(full_eqsol);
end
%fx = @(x,y) sin(2*x)/2;


x_i = zeros(n,1);
y_i = zeros(n,1);
f_x = zeros(n,1);
e_r = zeros(n,1);
k_1 = zeros(n,1);
k_2 = zeros(n,1);
k_3 = zeros(n,1);
k_4 = zeros(n,1);

j = 1;

for i=x_0:h:x_n
    
    x_i(j) = i;

    if j == 1
        k_1(j) = 0;
        k_2(j) = 0;
        k_3(j) = 0;
        k_4(j) = 0;
        y_i(j) = y_0;
        e_r(j) = 0;
    else
        k_1(j) = fdydx(x_i(j-1), y_i(j-1));
        k_2(j) = fdydx(x_i(j-1)+0.5*h,y_i(j-1)+0.5*h*k_1(j));
        k_3(j) = fdydx(x_i(j-1)+0.5*h,y_i(j-1)+0.5*h*k_2(j));
        k_4(j) = fdydx(x_i(j-1)+h,y_i(j-1)+k_3(j)*h);
        y_i(j) = y_i(j-1)+(h/6)*(k_1(j)+2*k_2(j)+2*k_3(j)+k_4(j));
    end 
    
    if res == y
        f_x(j) = fx(i,y);
    end
    
    if j > 1
        if res == 'y'
            e_r(j) = abs((f_x(j) - y_i(j))/f_x(j))*100;
        else
            e_r(j) = 0;
        end
    end
    j=j+1;
end


if res == y
    t = table(x_i,k_1,k_2,k_3,k_4,y_i,f_x,e_r);
    disp(t);
else
    t = table(x_i,k_1,k_2,k_3,k_4,y_i,e_r);
    disp(t);
end


