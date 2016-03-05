function Im2 = FilterMeanV2( Im, CK )
%FilterMeanV2 Image matrix XxYxZ Im & 3x3 Convolution Kernal CK, filter
%   I'm just learning this
    %[X, Y, Z] = size(Im);
    %Im2 = zeros (X, Y, Z);
    %Im2 = conv2( rgb2gray( double( Im ) ), double(CK) );
    %for i = 1:Z
     %   Im2(:,:,i) = conv2( double( Im(:,:,i) ), double(CK) );
    %end
    %Assume XxYx1 double matrix
    Im2 = conv2( Im, CK );
end

