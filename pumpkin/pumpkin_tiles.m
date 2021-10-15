function pumpkin_tiles
% Display the interesting pumpkins in a tiled layout.

    fig = gcf;
    fig.Position(3:4) = [ 900 350 ];
    fig.Color = 'w';
    
    tiledlayout('flow','TileSpacing','compact','Padding','tight');

    breeds = setPunkinBreed;

    for idx = 1:numel(breeds)
        nexttile;
        setPunkinBreed(Pumpkin, breeds{idx});
        title(breeds{idx});
        xticks([])
        yticks([])
        zticks([])
        xlim([-1 1])
        ylim([-1 1])
        zlim([-1 1])
        set(gca,'XDir','reverse'); % hide the seam
        set(gca,'Clipping','off');
        axis off
    end

end