% MIE1622 2018 Assigment 4
% University of Toronto
% Alina Sienkiewicz 

clc;
clear all;
format long

% Pricing a European option using Black-Scholes formula and Monte Carlo simulations
% Pricing a Barrier option using Monte Carlo simulations

S0 = 100;     % spot price of the underlying stock today
K = 105;      % strike at expiry
mu = 0.05;    % expected return
sigma = 0.2;  % volatility
r = 0.05;     % risk-free rate
T = 1.0;      % years to expiry
Sb = 110;     % barrier

% Define variable numSteps to be the number of steps for multi-step MC
% numPaths - number of sample paths used in simulations

numPaths=10000;

% Update price every day
numSteps=365;

% Implement your Black-Scholes pricing formula
[call_BS_European_Price, putBS_European_Price] = BS_european_price(S0, K, T, r, sigma);

% Implement your one-step Monte Carlo pricing procedure for European option

[callMC_European_Price_1_step, putMC_European_Price_1_step] = MC_european_price(S0, K, T, r, mu, sigma, 1, numPaths);

[callMC_European_Price_multi_step, putMC_European_Price_multi_step] = MC_european_price(S0, K, T, r, mu, sigma, numSteps, numPaths);

% Implement your one-step Monte Carlo pricing procedure for Barrier option

numSteps = 1;

[callMC_Barrier_Knockin_Price_1_step, putMC_Barrier_Knockin_Price_1_step] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sigma, numSteps, numPaths);

% Implement your multi-step Monte Carlo pricing procedure for Barrier option

numSteps = 365;

[callMC_Barrier_Knockin_Price_multi_step, putMC_Barrier_Knockin_Price_multi_step] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sigma, numSteps, numPaths);

sig=1.1*sigma;

[call_volatilityincrease, put_volatilityincrease] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sig, numSteps, numPaths);

sig=0.9*sigma;

[call_volatilitydecrease, put_volatilitydecrease] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sig, numSteps, numPaths);

disp(['Black-Scholes price of an European call option is ',num2str(call_BS_European_Price)])
disp(['Black-Scholes price of an European put option is ',num2str(putBS_European_Price)])
disp(['One-step MC price of an European call option is ',num2str(callMC_European_Price_1_step)])
disp(['One-step MC price of an European put option is ',num2str(putMC_European_Price_1_step)])
disp(['Multi-step MC price of an European call option is ',num2str(callMC_European_Price_multi_step)])
disp(['Multi-step MC price of an European put option is ',num2str(putMC_European_Price_multi_step)])
disp(['One-step MC price of an Barrier call option is ',num2str(callMC_Barrier_Knockin_Price_1_step)])
disp(['One-step MC price of an Barrier put option is ',num2str(putMC_Barrier_Knockin_Price_1_step)])
disp(['Multi-step MC price of an Barrier call option is ',num2str(callMC_Barrier_Knockin_Price_multi_step)])
disp(['Multi-step MC price of an Barrier put option is ',num2str(putMC_Barrier_Knockin_Price_multi_step)])
disp('')
disp(['Value of knock in options with +10% volatility change:'])
disp(['Multi-step MC price of an Barrier call option is ',num2str(call_volatilityincrease)])
disp(['Multi-step MC price of an Barrier put option is ',num2str(put_volatilityincrease)])
disp('')
disp(['Value of knock in options with -10% volatility change:'])
disp(['Multi-step MC price of an Barrier call option is ',num2str(call_volatilitydecrease)])
disp(['Multi-step MC price of an Barrier put option is ',num2str(put_volatilitydecrease)])

% Parameters to equalize Black Scholes and multi Step MC European price

while abs(callMC_European_Price_multi_step - call_BS_European_Price) >0.01
    while abs(callMC_European_Price_multi_step - putBS_European_Price)>0.01
        numPaths=numPaths+5000;
        [callMC_European_Price_multi_step, putMC_European_Price_multi_step] = MC_european_price(S0, K, T, r, mu, sigma, numSteps, numPaths);
    end
end
disp('')
disp(['Black-Scholes price of an European call option is ',num2str(call_BS_European_Price)])
disp(['Black-Scholes price of an European put option is ',num2str(putBS_European_Price)])
disp('')
disp(['Multi-step MC price of an European call option is ',num2str(callMC_European_Price_multi_step)])
disp(['Multi-step MC price of an European put option is ',num2str(putMC_European_Price_multi_step)])
disp(['Number of paths required is:',num2str(numPaths)])


        

