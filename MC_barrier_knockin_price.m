function [CallPrice PutPrice] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sigma, numSteps, numPaths)
paths = zeros(numSteps+1, numPaths);
dT = T/numSteps;

% Vector of paths will store realizations of the asset price
% First asset price is the initial price
paths(1,:) = S0;

% Flag to check if barrier kicks in
% X is 0 until the barrier is reached at which point the payoff for the
% option is achieved and X becomes equal to 1
X=zeros(numPaths,1);

% Generate paths
for iPath = 1:numPaths
    for iStep = 1:numSteps
        paths(iStep+1, iPath) = paths(iStep, iPath) * exp( (mu - 0.5*sigma^2)*dT + sigma*sqrt(dT)*normrnd(0,1) );
        if paths(iStep+1, iPath)>=Sb
            X(iPath)=1;
        end
    end
end 

% Final Price in each path 
FinalPrice=paths(end,:);

PutPayOffs=zeros(numPaths,1);
CallPayOffs=zeros(numPaths,1);

KList=K*ones(numPaths,1);

PutPayOffs=max(X.*(KList-FinalPrice'),0);
CallPayOffs=max(X.*(FinalPrice'-KList),0);

%S=mean(FinalPrice);

% Calculate the payoff for each path for a Put
%PutPayoff = max(K-S,0);
PutPayoff=mean(PutPayOffs);

% Calculate the payoff for each path for a Call
%CallPayoff = max(S-K,0);
CallPayoff=mean(CallPayOffs);

% Discount payoff back to find price
PutPrice = mean(PutPayoff)*exp(-r*T);
CallPrice = mean(CallPayoff)*exp(-r*T);

end
