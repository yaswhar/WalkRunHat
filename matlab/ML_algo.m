clear; close all; clc

data = table2array(readtable('results-z.csv','VariableNamingRule','preserve'));
X = data(:,[1,2]);
y = data(:,3);

figure;
hold on;

pos = find(y == 1);
neg = find(y == 0);

plot(X(pos, 1),X(pos, 2), 'k+','LineWidth', 2,'MarkerSize', 7);
plot(X(neg, 1),X(neg, 2), 'ko','MarkerFaceColor','y','MarkerSize', 7);

% Put some labels 
hold on;
% Labels and Legend
xlabel('Dominant frequency in Hz');
ylabel('Peak Max');
title('Before Regression')
% Specified in plot order
legend('Walking', 'Running');
hold off;

[m, n] = size(X);

X = [ones(m,1) X];

initial_theta = zeros(n+1,1);

[cost, grad] = costFunction(initial_theta,X,y);
fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
save theta.mat
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);

plotDecisionBoundary(theta, X, y);
% Put some labels 
hold on;
% Labels and Legend
xlabel('Dominant frequency in Hz');
ylabel('Peak Max');
title('After Regression')
% Specified in plot order
legend('Walking', 'Running');
axis auto
hold off;

