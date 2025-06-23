function flower_tiles
% Display the interesting pumpkins in a tiled layout.

    fig = gcf;
    fig.Position(3:4) = [ 1500 300 ];
    fig.Color = 'w';
    
    tiledlayout('horizontal','TileSpacing','none','Padding','none');

    nexttile;
    redrose
    axis([-.8 .8 -.8 .8 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Rose')
    configaxis

    nexttile;
    dahlia
    axis([-.8 .8 -.8 .8 -.2 .7])
    set(gca,'clipping','off')
    axis off
    title('Dahlia')
    configaxis

    nexttile
    daffodil
    axis off
    title('Daffodil');
    configaxis

    nexttile
    tulip
    axis off
    title('Tulip');
    configaxis

    nexttile
    waterlily
    title('Water Lily');
    set(gca,'clipping','off')
    axis([-.7 .7 -.7 .7 0 .8],'off')
    configaxis

end

function configaxis()
    io = get(gca,'InteractionOptions');
    io.PanSupported = false;
    io.ZoomSupported = false;
    io.DatatipsSupported = false;
    io.BrushSupported = false;
    set(gca,'InteractionOptions',io);
    axtoolbar(gca,{ 'restoreview' });
end
            
