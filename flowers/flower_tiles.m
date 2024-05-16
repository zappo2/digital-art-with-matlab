function flower_tiles
% Display the interesting pumpkins in a tiled layout.

    fig = gcf;
    fig.Position(3:4) = [ 1000 300 ];
    fig.Color = 'w';
    
    tiledlayout('flow','TileSpacing','none','Padding','none');

    nexttile;
    redrose
    axis([-.8 .8 -.8 .8 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Rose')

    nexttile;
    dahlia
    axis([-.8 .8 -.8 .8 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Dahlia')

    nexttile
    daffodil
    axis off
    title('Daffodil');

    nexttile
    tulip
    axis off
    title('Tulip');
end
