%% height_skew_factor
%   outputs the regression
%   to determine the skew factor from
%   the pixel height
%   Formulas obtained from many tests
function [ output_args ] = heightSkewFactor(height)
    
    if ((abs(height) < 10))
        output_args = specialCase(height);
    elseif(height < 0)
        output_args = negative(height);
    else
        output_args = positive(height);
    end
end

%% SpecialCase
% currently outputs 0 because it is so close to the middle of the image
function [ output_args ] = specialCase(height)
    sc = 3.0171*height - 23.116;
    
    if (height <= 0 )
        sc = sc * -1;
    end
    
    output_args = sc;
end

%% negative
% skew factor for negative pixel heights
function [ output_args ] = negative(height)

    if (height <= -600)
       n = .04;
    elseif (height <= -400)
       n = .04;
    elseif (height <= -250)
       n = .075;
    elseif (height <= -200)
       n = .12; 
    elseif (height <= -150)
       n = 0.0027*height + 0.6108;
    elseif (height <= -100)
       n = 0.0057*height + 0.8296;
    elseif (height <= -50)
       n = 0.0116*height + 1.3766;
    elseif (height <= -10)
       n = 0.0129*height + 1.3364;
    elseif (height <= 0)
       n = 3.0171*height - 23.116;
       n = n*-1;
    end

    %n = (4*10^(-7))*(height)^2 + (0.0005)*(height) + (0.228);
    %expo = (0.2552*exp(0.0026*height)) - 0.024024170;    
    output_args = n;
end

%% positive
% skew factor for positive pixel heights
function [ output_args ] = positive(height)

    if (height <= 10)
       p = 3.0171*height - 23.116;
    elseif (height <= 50)
       p = -.65;
    elseif (height <= 100)
       p = 0.0101*height - 1.1249;
    elseif (height <= 200)
       p = 0.0015*height - 0.4237;
    elseif (height <= 300)
       p = 0.0005*height - 0.2453;
    elseif (height <= 400)
       p = -.044;
    elseif (height <= 500)
       p = -.034;
    elseif (height <= 600)
       p = .0001*height - .0993;
    elseif (height <= 700)
       p = -.022;
    elseif (height > 700)
       p = (2*10^(-5))*height - 0.028;
    end
    
    %p = 0.1896*log(height) - 1.1847; 
    %expo = (0.2552*exp(0.0026*height)) - 0.024024170;    
    output_args = p;
end

% %% Linear
% function [ output_args ] = linear(height)
%     %linear = (-0.0000776794935298719)*height + (0.029517525619289);
%     linear = (0.0004*height) + (0.2933);
%     
%     %if (height > 0)
%     %    linear = linear*(-1);
%     %end
%     
%     output_args = linear;
% end

% %% Quadratic
% function [ output_args ] = quad(height)
%     quadratic = (-2.34622401152922*10^(-07))*height^2 + (-0.000157827379584066)*height + (0.0599836020854991);
%     output_args = quadratic;
% end