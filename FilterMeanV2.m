function Im2 = FilterMeanV2( Im, CK )
%FilterMeanV2 Given image matrix Im & 3x3 Convolution Kernal CK, filter
%   I'm just learning this
    Im2 = conv2(Im,CK,'valid');
end

