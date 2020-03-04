function [CallPrice PutPrice] = BS_european_price(S0, K, T, r, sigma)

d1=1/(sigma*sqrt(T))*(log(S0/K)+(r+(sigma^2)/2)*T);
d2=d1-sigma*sqrt(T);

CallPrice=S0*normcdf(d1)-K*exp(-r*T)*normcdf(d2);
PutPrice=K*exp(-r*T)*normcdf(-1*d2)-S0*normcdf(-1*d1);

end