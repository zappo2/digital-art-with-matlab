function snowtiles
% Draw a few snowflake variants in a vertal image

    f=gcf;
    f.Position(3:4) = [ 500 400];
    f.Color='w';

    tiledlayout(3,4,'Padding','none','TileSpacing','none')

    nexttile([3 3])
    snowflake()
    axis off tight
    xticks([])
    yticks([])

    nexttile
    snowflake([10 2 8 7 6 5])
    axis off tight
    
    nexttile
    snowflake([1 5 5 8 8 8 8])
    axis off tight

    nexttile
    snowflake([5 2 1 1 5 1 1 5 8])
    axis off tight
end
