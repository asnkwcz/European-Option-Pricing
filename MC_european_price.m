function [CallPrice PutPrice] = MC_european_price(S0, K, T, r, mu, sigma, numSteps, numPaths)
paths = zeros(numSteps+1, numPaths);
dT = T/numSteps;

% Vector of paths will store realizations of the asset price
% First asset price is the initial price
paths(1,:) = S0;

% Generate paths
for iPath = 1:numPaths
    for iStep = 1:numSteps
        paths(iStep+1, iPath) = paths(iStep, iPath) * exp( (mu - 0.5*sigma^2)*dT + sigma*sqrt(dT)*normrnd(0,1) );
    end
end 

% Final Price in each path 
FinalPrice=paths(end,:);

PutPayOffs=zeros(numPaths,1);
CallPayOffs=zeros(numPaths,1);

KList=K*ones(numPaths,1);

PutPayOffs=max(KList-FinalPrice',0);
CallPayOffs=max(FinalPrice'-KList,0);

% Calculate the payoff for each path for a Put
%PutPayoff = max(K-S,0);
PutPayoff=mean(PutPayOffs);

% Calculate the payoff for each path for a Call
%CallPayoff = max(S-K,0);
CallPayoff=mean(CallPayOffs);

% Discount payoff back to find price
PutPrice = mean(PutPayoff)*exp(-r*T);
CallPrice = mean(CallPayoff)*exp(-r*T);

CallTemp=zeros(numPaths,1);
PutTemp=zeros(numPaths,1);
CallAvgs=[]; PutAvgs=[];

if numSteps>1
    % Plot paths
%     for j=1:numPaths
%         CallTemp(j)=CallPayOffs(j);
%         PutTemp(j)=PutPayOffs(j);
%         CallAvgs(j)=mean(CallTemp);
%         PutAvgs(j)=mean(PutTemp); 
%     end
%         
    figure(1);
    set(gcf, 'color', 'white');
    plot(0:numSteps, paths', 'Linewidth', 2);
    hold on
    plot([0,numSteps],[K,K],'r-','LineWidth',4);
    legend('Strike Price');
    title('Asset Prices', 'FontWeight', 'bold');
    
%     figure (2);
%     set(gcf, 'color', 'white');
%     plot(0:size(CallAvgs),CallAvgs, 'Linewidth', 2);
%     hold on
%     plot(0:size(PutAvgs),PutAvgs, 'Linewidth', 2);
%     legend('Call Price','Put Price');
%     title('Call and Put Prices', 'FontWeight', 'bold');
    end


end 

