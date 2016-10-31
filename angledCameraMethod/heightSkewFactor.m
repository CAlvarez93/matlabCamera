%% height_skew_factor
%   outputs the regression
%   to determine the skew factor from
%   the pixel height
%   Formulas obtained from many tests
function [ output_args ] = heightSkewFactor(arg, height)
    

    if ((abs(height) < 10))
        output_args = specialCase(height);
    elseif ((abs(height) < 100))
        output_args = lt100(height);
    elseif(height < 0)
        output_args = negative(height);
    else
        output_args = positive(height);
    %elseif ((abs(height) < 300))
        %output_args = lt300(height);
    %elseif ((abs(height) < 400))
        %output_args = lt400(height);
    %elseif ((abs(height) < 500))
        %output_args = lt500(height);
    %elseif ((abs(height) < 600))
        %output_args = lt600(height);    
    %elseif ((abs(height) < 700))
        %output_args = lt700(height);   
    %elseif (strcmp(arg,'linear'))
    %    output_args = linear(height);
    %elseif (strcmp(arg,'quadratic'))  
    %    output_args = quad(height);
    end

    
end

%% SpecialCase
% currently outputs 0 because it is so close to the middle of the image
function [ output_args ] = specialCase(height)
    sc = 5.1;
    
    if (height > 0 )
        sc = sc * -1;
    end
    
    output_args = sc;
end

%% lt100
% less than 100 pixel height skews much harder than any other pixel height
function [ output_args ] = lt100(height)
    lt = (1.8826*exp(0.023*height));
    
    if (height > 0)
       lt = 0.1914*log(height) - 1.193; 
    end
    
    %if (height > 0)
    %    lt = lt*(-1);
    %end
    
    output_args = lt;
end

%% negative
% skew factor for negative pixel heights
function [ output_args ] = negative(height)

    n = (4*10^(-7))*(height)^2 + (0.0005)*(height) + (0.228);
    %expo = (0.2552*exp(0.0026*height)) - 0.024024170;    
    output_args = n;
end

%% positive
% skew factor for positive pixel heights
function [ output_args ] = positive(height)
    p = 0.1896*log(height) - 1.1847; 
    %expo = (0.2552*exp(0.0026*height)) - 0.024024170;    
    output_args = p;
end

%% Linear
function [ output_args ] = linear(height)
    %linear = (-0.0000776794935298719)*height + (0.029517525619289);
    linear = (0.0004*height) + (0.2933);
    
    %if (height > 0)
    %    linear = linear*(-1);
    %end
    
    output_args = linear;
end

%% Quadratic
function [ output_args ] = quad(height)
    quadratic = (-2.34622401152922*10^(-07))*height^2 + (-0.000157827379584066)*height + (0.0599836020854991);
    output_args = quadratic;
end