function Graph4Quad(x11, x12, x21, x22 )
    subplot(2,2,1);
    imshow( x11 );
    hold on;
    subplot(2,2,2);
    imshow( x12 );
    subplot(2,2,3);
    imshow( x21 );
    subplot(2,2,4);
    imshow( x22 );
    hold off;
end