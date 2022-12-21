function cookie(pattern, opts)
% Create a cookie from PATTERN
%
% cookie(PAT) - Draw a cookie based on a text pattern.
% cookie(PAT, 'param', val) - Specify a cookie parameter
%
%  Options:
%     doughcolor - The RGB color for the dough
%     icingcolor - Color for icing on the cookie, or 'none'
%     sprinklesize - Size of cookie sprinkes.
%     poof - iso-value used in isosurface command.
%            small numbers (.1) make poofier cookies
%            than big numbers (.9)
%
% To draw a cookie, create a character array like this:
%
% cookie([ '  xx  '; '  xx  ']);
%
% To specify sprinkles, use lowercase o in place of x when drawing your cookie.

    arguments
        pattern char = ['    xxx    '
                        '   xxxxx   '
                        '   xxxxx   '
                        '    xxx    '
                        'xx       xx'
                        ' xx xxx xx '
                        '  xxxxxxx  '
                        '   xxxxx   '
                        '   xxxxx   '
                        '   xxxxx   '
                        '   xxxxx   '
                        '  xx   xx  '
                        'xxx     xxx'
                        ' x       x '];
        opts.doughcolor = '#a56c3c'
        opts.icingcolor = 'none'
        opts.sprinklecolors = prism(6);
        opts.sprinklesize = 60
        opts.poof = .3
    end

    % Step 1: Convert PATTERN into array of blob centers
    [y,x]=find(~isspace(pattern));
    C=[x*5,y*5]+5;

    % Step 2: Compute a volume using Blinn's blobs function
    nx=size(pattern,2)*5+15;   % Compute Size of volume needed for the cookie
    ny=size(pattern,1)*5+15;
    nz=30;
    
    C(:,3)=nz/2; % Offset centers into the middle of 3D cookie space
    
    vol = bblob(C, nx, ny, nz);

    % Step 3: Compute isosurface from the blobs
    S=isosurface(vol,opts.poof);
    S.vertices(:,3) = max(S.vertices(:,3), nz*.45); % Flatten the bottom of the cookie

    % Step 4: Check to see if PATTERN includes any sprinkles
    [yo,xo]=find(pattern=='o');
    
    % Step 4: Create a new plot, and draw.
    newplot

    % Step 4.1: Sprinkles
    if ~isempty(xo)
        z=max(S.vertices(:,3),[],'all');
        oc=opts.sprinklecolors;
        scatter3(xo*5+5,yo*5+5,xo*0+z,...
                 opts.sprinklesize,oc(randi(size(oc,1),numel(xo),1),:),...
                 'filled');
    end

    % Step 4.2: Draw the cookie
    switch opts.icingcolor
      case 'none'
        patch(S,'FaceColor',opts.doughcolor,'EdgeColor','n'); % cookie
      otherwise
        % If we have icing, use interpolated colors, and set cdata to
        % Z, so we smear the icing across the top.
        patch(S,'FaceColor','interp','EdgeColor','none',...
              'FaceVertexCData',S.vertices(:,3));
        colormap(gca, validatecolor({ opts.doughcolor
                                      opts.icingcolor }, 'multiple'));
        clim([10 nz]);

    end

    % Step 4.3: Make it look yummier
    view(2)
    axis equal ij off
    lighting gouraud
    material([.6 .9 .3 ])
    camlight

end
