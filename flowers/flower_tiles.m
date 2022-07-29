function flower_tiles
% Display the interesting pumpkins in a tiled layout.

    fig = gcf;
    fig.Position(3:4) = [ 800 350 ];
    fig.Color = 'w';
    
    tiledlayout(1,2,'TileSpacing','none','Padding','none');

    nexttile;
    redrose
    axis([-.7 .7 -.7 .7 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Rose')

    nexttile;
    dahlia
    axis([-.7 .7 -.7 .7 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Dahlia')

end