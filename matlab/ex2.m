% Exercicio 2

clear all
clc

B = @(n,t) exp(-n/t);

number_of_variables = 20;
number_of_iteration = 30000;
number_of_temperature_iteration = 10;
epsilon = 0.05;
T0 = 1;
T = T0;
x0 = 1.5*ones(1, number_of_variables);
x = x0;
counter = 1;
counter_temperatures = 1;
Jmin = J(x(counter,:));
xmin = x(counter,:);
while counter_temperatures <= number_of_temperature_iteration
    for i = 1:number_of_iteration
        r = randn(1,number_of_variables);
        xk = x(counter,:) + epsilon * r;
        Jxk = J(xk);
        dJ = Jxk - J(x(counter,:));
        counter = counter + 1;
        if dJ < 0
            x = [x ; xk];
        else
            a = rand;
            if B(dJ,T) > a
                x = [x ; xk];
            else
                x = [x ; x(counter - 1,:)];
            end
        end
        if Jxk < Jmin
            Jmin = Jxk;
            xmin = xk;
        end
    end
    counter_temperatures = counter_temperatures + 1;
    T = T0 / log2(counter_temperatures + 1);
    number_of_iteration = number_of_iteration / log2(counter_temperatures + 1);
end
