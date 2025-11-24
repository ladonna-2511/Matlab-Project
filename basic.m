% Opens a new figure window (graphics window). If there is already a figure, this creates another one so subsequent plots do not overwrite previous figures.
figure  

% Clears the Command Window (removes previous text output).
clc 

% t will automatically be recognized as a symbolic variable.
syms y(t) t; 

% Prints the string 'enter value: ' to the Command Window.
disp('enter value: '); 

% Enter natural frequency
omega0 = input('enter omega (rad/s): omega0 = ');

% Enter damping coefficient
b = input('enter damping coefficient: b = ');

% Enter external force
F = input('enter force: F(N) = ');

% Enter the end time for plotting
t0 = input('enter time to start: t(s)= ');

% Creates a symbolic equation representing the initial condition 𝑦(0)=5. Note == makes an equation (not assignment).
cond1 = y(0) == 5;      

% Create a variable for the first derivative (Dy/Dt)
Dy = diff (y,t); 

% Creates the symbolic equation 𝑦′(0)=0. Dy(0) evaluates the symbolic derivative at t = 0.
cond2 = Dy(0) == 0;

% Grouping both conditions into a single variable
conds = [cond1, cond2]; 

% D2y is the second derivatie (D2y/Dt2) 
D2y = diff(y, t, 2); 

if b == 0 && F == 0

% Prints a message indicating the case detected.
    disp ('Harmonic oscillation');

% Differential equation
    eqn = D2y + (omega0^2)*y == 0;
elseif b ~= 0 && F == 0
    disp('Damped oscillation');

% Differential equation with damping
    eqn = D2y + b*Dy + (omega0^2)*y == 0;
elseif b ~= 0 && F ~= 0 
    omega = input('Enter angular frequency of the stimulus force: omega (rad/s) = ');
    disp('Stimulated oscillation');

% Stimulated oscillation (as defined in assignment)
    eqn = D2y + b*Dy + (omega0^2)*y == F*cos(omega*t);
else 
    disp('Invalid or underfined input case.');

% Exits the script or function immediately. No further lines are executed.
    return;  

% Ends the if...elseif...else control block.
end 

% dsolve:symbolically solves ordinary differential equations 
% Calls MATLAB Symbolic Toolbox function dsolve to obtain an analytic (symbolic) solution y(t) for the ODE eqn that satisfies initial conditions conds.
ySolve = dsolve(eqn, conds); 

% Prints header text.
disp('The resulting displacement function is:');  

% Displays the symbolic solution returned by dsolve.
disp(ySolve);  

% Prints a message announcing the plot.
disp('Plotting displacement functions is:');  

% Plots the symbolic function ySolve over the interval from t = 0 to t = t0. fplot is an adaptive plotting function that evaluates the symbolic expression at sampled points and draws a smooth curve.
fplot(ySolve, [0, t0]); 

% Turns the axes grid on in the current figure (makes the plot easier to read).
grid on;  

% Labels the x-axis with the string 'Time t(s)'.
xlabel('Time t(s)');  

% Labels the y-axis with the string 'Displacement y(m)'.
ylabel('Displacement y(m)'); 

% Adds a title to the plot.
title('Graph of displacement y vs. time t');  