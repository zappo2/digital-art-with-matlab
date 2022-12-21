function cookietiles
% Create a bunch of demo cookies you can create with the cookie function.

    p = get(gcf,'position');
    set(gcf,'position', [p(1:2) 800 200], 'color', 'w');
    
    tiledlayout(1,4,'padding','compact','tilespacing','compact');

    nexttile
    cookie  % Start with default cookie

    nexttile % A pine tree
    cookie(['    x    '
            '    o    '
            '   xxx   '
            '   xxx   '
            '  xxxxx  '
            '  xxxxx  '
            ' xxxxxxx '
            ' xxxxxxx '
            'xxxxxxxxx'
            '    x    '
            '    x    '],...
           'icingcolor','#229922',...
           'sprinklecolors', [ 1 1 0 ]);

    nexttile  % Carol Bell
    cookie(['     x     '
            '     x     '
            '   xxxxx   '
            '   xxxxx   '
            '   xxxxx   '
            '   xxxxx   '
            '   xxxxx   '
            '  xxxxxxx  '
            ' xxxxxxxxx '
            '     x     '],...
           'poof',.1)

    nexttile  % Snowman
    cookie(['   xxx   '
            '  xxxxx  '
            '  xxxxx  '
            '   xxx   '
            '    x    '
            '  xxxxx  '
            ' xxxxxxx '
            ' xxxxxxx '
            ' xxxxxxx '
            '  xxxxx  '
            '   x x   '
            ' xxxxxxx '
            'xxxxxxxxx'
            'xxxxxxxxx'
            'xxxxxxxxx'
            'xxxxxxxxx'
            ' xxxxxxx '],...
           'icingcolor', '#ccccee');

end
