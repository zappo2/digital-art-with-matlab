function dfltimg_parallax()
% Get the default image cdata and display 4 images in a rotating cube.

    I = get(groot,'defaultimageCData');
    defimage = pow2(I,47);

    % Compute the images from the default CData
    I1 = bitslice(defimage,42,46);
    I2 = bitslice(defimage,37,41);
    I3 = bitslice(defimage,47,51);
    I4 = bitslice(defimage,5,8);

    set(gca,'PositionConstraint','innerposition')

    % Display a transition for each image in sequence.
    parallaxPlot(I1,I2);

    pause(1)
    paratwist
    
    parallaxPlot(I2,I3);
    
    pause(1)
    paratwist
    
    parallaxPlot(I3,I4);
    
    pause(1)
    paratwist
    
    parallaxPlot(I4,I1);
    
    pause(1)
    paratwist

end
function paratwist()
% Rotate the axes to show off the paralax thing...

    for idx=linspace(0,90,50)
        view([ idx (cosd(idx*4)-1)*5 ]);
        drawnow
    end
    
end
function b = bitslice(a,lowbit,highbit)
    % BITSLICE(A,LOWBIT,HIGHBIT)
    %
    %   Scales return values so that the maximum is 1.0.

    b = a / 2^(lowbit);
    b = fix(b);
    b = b / 2^(highbit - lowbit + 1);
    b = b - fix(b);

    b = b / max(b(:));

    % To work with parallaxPlot, pull up only the brightest pixels.
    b = floor(b*1.8);

    b([end 1]) = 1;
end