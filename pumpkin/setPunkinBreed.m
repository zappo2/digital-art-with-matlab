function breeds = setPunkinBreed(P, breed, lset)
% Set the Pumpkin P to be of type BREED.
%
% Optional argument lset is a function handle that will set the property.
% If it is not specified 'set' will be used.

    arguments
        P (1,:) Pumpkin = Pumpkin.empty()
        breed (1,:) char = 'pumpkin';
        lset (1,1) function_handle = @set;
    end

    if nargout == 1
        % Only the breeds that look pretty good.
        breeds = { 'Blue Doll' 'Cinderella' 'Howden' 'Kabocha' 'Lumina' 'Lil'' Pump-ke-mon'...
                   'Orangita' 'Rumbo' 'Scheherazade' 'Snack Jack' 'Sweet Lightning' ...
                   'Pumpkin' };
        % other breeds:  'Appalachian'
        return;
    end

    if nargin < 2
        error('You must specify a pumpkin and breed');
    end

    switch lower(breed)
      case 'appalachian'
        lset(P,'Radius', 1);
        lset(P,'Height', .8);
        lset(P,'NumBumps', 10);
        lset(P,'BumpDepth', .1);
        lset(P,'SecondaryBumpDepth', 0);
        lset(P,'DimpleDepth', -.2);
        lset(P,'Colors', [ validatecolor('#9a6525'); validatecolor('#e9af66') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .15 .09 ]);
        lset(P,'StemDims', [ .2 .5 ]);
        lset(P,'StemColor', validatecolor('#e9af66'));
      case { 'blue doll' 'bluedoll' }
        lset(P,'Radius', 1);
        lset(P,'Height', .7);
        lset(P,'NumBumps', 9);
        lset(P,'BumpDepth', .06);
        lset(P,'SecondaryBumpDepth', .03);
        lset(P,'DimpleDepth', .3);
        lset(P,'Colors', [ validatecolor('#808c74'); validatecolor('#d8ded2') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .15 .1 ]);
        lset(P,'StemDims', [ .3 .5 ]);
        lset(P,'StemColor', validatecolor('#918151'));
      case { 'cinderella' 'rouge vif d''etampes' }
        lset(P,'Radius', 1.4);
        lset(P,'Height', .9);
        lset(P,'NumBumps', 9);
        lset(P,'BumpDepth', .03);
        lset(P,'SecondaryBumpDepth', .03);
        lset(P,'DimpleDepth', .5);
        lset(P,'Colors', [ validatecolor('#cf4020'); validatecolor('#f5562a') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .15 .08 ]);
        lset(P,'StemDims', [ .2 .8 ]);
        lset(P,'StemColor', validatecolor('#006400'));
      case { 'howden' }
        lset(P,'Radius', 1);
        lset(P,'Height', 1.2);
        lset(P,'NumBumps', 20);
        lset(P,'BumpDepth', .03);
        lset(P,'SecondaryBumpDepth', .01);
        lset(P,'DimpleDepth', .2);
        lset(P,'Colors', [ validatecolor('#f06000'); validatecolor('#ff7518') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .15 .11 ]);
        lset(P,'StemDims', [ .1 .5 ]);
        lset(P,'StemColor', validatecolor('#003d00'));
      case 'kabocha'
        lset(P,'Radius', .9);
        lset(P,'Height', .7);
        lset(P,'NumBumps', 8);
        lset(P,'BumpDepth', .02);
        lset(P,'SecondaryBumpDepth', .01);
        lset(P,'DimpleDepth', .1);
        lset(P,'Colors', [ validatecolor('#8aa385'); validatecolor('#455856') ]);
        lset(P,'SpeckleSize', .005);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .1 .2 ]);
        lset(P,'StemColor', validatecolor('#cbc688'));
      case { 'lumina' 'luminawhite' 'lumina white' }
        lset(P,'Radius', 1);
        lset(P,'Height', 1);
        lset(P,'NumBumps', 18);
        lset(P,'BumpDepth', .03);
        lset(P,'SecondaryBumpDepth', 0);
        lset(P,'DimpleDepth', .2);
        lset(P,'Colors', [ validatecolor('#dddddd'); validatecolor('#eeeeee') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .2 .2 ]);
        lset(P,'StemColor', validatecolor('#003d00'));
      case { 'pumpkemon' 'lil'' pump-ke-mon' }
        lset(P,'Radius', 1);
        lset(P,'Height', .7);
        lset(P,'NumBumps', 11);
        lset(P,'BumpDepth', .03);
        lset(P,'SecondaryBumpDepth', .02);
        lset(P,'DimpleDepth', .3);
        lset(P,'Colors', [ validatecolor('#e8aa13'); validatecolor('#ffffbb') ]);
        lset(P,'SpeckleSize', .01);
        lset(P,'SpeckleColorRatio', .3);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .3 .4 ]);
        lset(P,'StemColor', validatecolor('#003d00'));
      case 'orangita'
        lset(P,'Radius', 1);
        lset(P,'Height', .8);
        lset(P,'NumBumps', 8);
        lset(P,'BumpDepth', .1);
        lset(P,'SecondaryBumpDepth', .05);
        lset(P,'DimpleDepth', .4);
        lset(P,'Colors', [ validatecolor('#d06b00'); validatecolor('#f48f19') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .15 .08 ]);
        lset(P,'StemDims', [ .2 .8 ]);
        lset(P,'StemColor', validatecolor('#006400'));
      case 'rumbo'
        lset(P,'Radius', 1.4);
        lset(P,'Height', .8);
        lset(P,'NumBumps', 8);
        lset(P,'BumpDepth', .1);
        lset(P,'SecondaryBumpDepth', .1);
        lset(P,'DimpleDepth', .4);
        lset(P,'Colors', [ validatecolor('#9a6525'); validatecolor('#e9af66') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .05 ]);
        lset(P,'StemDims', [ .3 .8 ]);
        lset(P,'StemColor', validatecolor('#664c28'));
      case 'scheherazade'
        lset(P,'Radius', .9);
        lset(P,'Height', 1.2);
        lset(P,'NumBumps', 8);
        lset(P,'BumpDepth', .05);
        lset(P,'SecondaryBumpDepth', 0);
        lset(P,'DimpleDepth', .1);
        lset(P,'Colors', [ validatecolor('#e8aa23'); validatecolor('#546338') ]);
        lset(P,'SpeckleSize', .02);
        lset(P,'SpeckleColorRatio', .2);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .1 .2 ]);
        lset(P,'StemColor', validatecolor('#6c541e'));
      case { 'snack' 'snack jack' 'snackjack' }
        lset(P,'Radius', 1);
        lset(P,'Height', 1);
        lset(P,'NumBumps', 10);
        lset(P,'BumpDepth', .03);
        lset(P,'SecondaryBumpDepth', .02);
        lset(P,'DimpleDepth', .2);
        lset(P,'Colors', [ validatecolor('#f06000'); validatecolor('#ff7518') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .1 .2 ]);
        lset(P,'StemColor', validatecolor('#a67b5b'));
      case { 'sweetlightning' 'sweet lightning' }
        lset(P,'Radius', 1);
        lset(P,'Height', .8);
        lset(P,'NumBumps', 10);
        lset(P,'BumpDepth', .1);
        lset(P,'SecondaryBumpDepth', .03);
        lset(P,'DimpleDepth', .4);
        lset(P,'Colors', [ validatecolor('#ff7518'); validatecolor('#ffffbb') ]);
        lset(P,'SpeckleSize', .08);
        lset(P,'SpeckleColorRatio', .4);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .2 .5 ]);
        lset(P,'StemColor', validatecolor('#6c541e'));
      otherwise % Do a stylize 'perfect' pumpkin.
        lset(P,'Radius', 1);
        lset(P,'Height', .8);
        lset(P,'NumBumps', 10);
        lset(P,'BumpDepth', .1);
        lset(P,'SecondaryBumpDepth', .02);
        lset(P,'DimpleDepth', .2);
        lset(P,'Colors', [ validatecolor('#f06000'); validatecolor('#ff7518') ]);
        lset(P,'SpeckleSize', 0);
        lset(P,'SpeckleColorRatio', .5);
        lset(P,'SpeckleTransitionRatio', .2);
        lset(P,'StemRadius', [ .1 .06 ]);
        lset(P,'StemDims', [ .4 .5 ]);
        lset(P,'StemColor', validatecolor('#008000'));
    end
end

