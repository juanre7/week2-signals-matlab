%% Continuous-time basic signals (plot + labels)
% Author: You
clear; close all; clc;

% Common time axis (dense grid to emulate continuous time)
dt = 1e-3;                 % time resolution (s)
t  = -5:dt:5;              % time vector (s)

%% Helper: unit step u(t) with u(0)=0.5 (engineering convention)
u = (t>0) + 0.5*(t==0);    % logical ops give 1/0; set half-value at t=0

%% 1) Unit Impulse δ(t)
% Note: δ(t) is not a conventional function to plot. We:
%  (a) show an idealized "arrow" at t=0 via stem, and
%  (b) overlay a narrow Gaussian with area≈1 as a visual approximation.
sigma = 0.05;                                   % narrowness of Gaussian
delta_approx = (1/(sigma*sqrt(2*pi))) * exp(-t.^2/(2*sigma^2)); % area ~ 1

figure;
plot(t, delta_approx, '--', 'LineWidth', 1.5); hold on; grid on; % approx δ(t)
stem(0, 1, 'filled', 'LineWidth', 1.5);                           % ideal marker
xlabel('t (s)'); ylabel('Amplitud');
title('Unit Impulse \delta(t) (ideal marker + Gaussian approx)');
legend('\delta_\sigma(t) (aprox.)','\delta(t) (ideal)', 'Location','best');
ylim([0, max(delta_approx)*1.1]); xlim([-0.4 0.4]);               % zoom around 0

%% 2) Unit Step u(t)
figure;
plot(t, u, 'LineWidth', 1.5); grid on;
xlabel('t (s)'); ylabel('Amplitud');
title('Unit Step u(t) con u(0)=0.5');
ylim([-0.2, 1.2]);

%% 3) Unit Ramp r(t) = t*u(t)
r = t .* u;                                     % r(t)=t para t>=0; 0 si t<0
figure;
plot(t, r, 'LineWidth', 1.5); grid on;
xlabel('t (s)'); ylabel('Amplitud');
title('Unit Ramp r(t)=t\,u(t)');
ylim([min(r)-0.5, max(r)+0.5]);

%% 4) Exponential Signal x(t)=e^{a t} u(t) (decaying example: a<0)
a = -1;                                         % tasa (negativa => decreciente)
x_exp = exp(a*t) .* u;                           % activa para t>=0
figure;
plot(t, x_exp, 'LineWidth', 1.5); grid on;
xlabel('t (s)'); ylabel('Amplitud');
title(['Exponential Signal x(t)=e^{a t} u(t), a=', num2str(a)]);
ylim([-0.1, 1.2]);

%% 5) Signum Signal sgn(t)
% sgn(t) = -1 (t<0), 0 (t=0), 1 (t>0)
sgn = sign(t);                                   % MATLAB: sign(0)=0
figure;
plot(t, sgn, 'LineWidth', 1.5); grid on;
xlabel('t (s)'); ylabel('Amplitud');
title('Signum Signal sgn(t)');
ylim([-1.2, 1.2]);

%% 6) Sinc Signal (definición normalizada)
% Definición normalizada: sinc(t) = sin(pi*t)/(pi*t), con sinc(0)=1
% Implementamos la fórmula explícitamente para evitar depender de 'sinc'.
eps0 = 1e-12;                          % tolerancia para t≈0
y_sinc = ones(size(t));                % valor en t=0 -> 1
idx = abs(t) > eps0;                   % evita 0/0
y_sinc(idx) = sin(pi*t(idx))./(pi*t(idx));

figure;
plot(t, y_sinc, 'LineWidth', 1.5); grid on;
xlabel('t (s)'); ylabel('Amplitud');
title('Sinc normalizada \mathrm{sinc}(t)=\sin(\pi t)/(\pi t)');
ylim([min(y_sinc)-0.1, 1.2]);

