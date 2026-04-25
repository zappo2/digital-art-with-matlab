function flower_tiles(export)
% Display the interesting pumpkins in a tiled layout.
    arguments
        export=false;
    end

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
    axis([-1 1 -1 1 -2.7 .6],'off');
    configaxis

    nexttile
    tulip
    axis off
    title('Tulip');
    configaxis

    nexttile
    waterlily
    title('Water Lily');
    axis([-.7 .7 -.7 .7 0 .8],'off')
    configaxis

    if export
        F = getframe(gcf);
        imwrite(F.cdata,'flower_tiles.jpg');
    end
    
end

function configaxis()
    io = get(gca,'InteractionOptions');
    io.PanSupported = false;
    io.ZoomSupported = false;
    io.DatatipsSupported = false;
    io.BrushSupported = false;
    set(gca,'InteractionOptions',io,'Clipping','off');
    axtoolbar(gca,{ 'restoreview' },'visible','off');
end
            
