classdef Pumpkin  < handle & matlab.mixin.SetGet

    properties (SetObservable=true)
        % Basics
        X (1,1) double = 0
        Y (1,1) double = 0
        Z (1,1) double = 0;
        Radius (1,1) double  = 1
        Height (1,1) double = .8
        Resolution (1,1) double = 200
        NumBumps (1,1) double = 10
        BumpDepth (1,1) double = .1
        SecondaryBumpDepth (1,1) double = .02
        DimpleDepth (1,1) double = .2

        % Colors
        Colors (2,3) double = validatecolor({'#f06000' '#ff7518'},'multiple')
        SpeckleSize (1,1) double = 0
        SpeckleColorRatio (1,1) double = .5
        SpeckleTransitionRatio (1,1) double = .1

        % Stem
        StemRadius (1,2) double = [ .1 .06 ]
        StemDims (1,2) double = [ .4 .5 ]
        StemColor (1,3) double {validatecolor} = validatecolor('#008000')
    end

    properties (Access='private')
        SpeckleRand = [];
        Surface
        SSurface
    end
    
    methods
        function P = Pumpkin(namevalue)
        % Create a Pumpkin in gca.
        %   Pumpkin('Name', value, ...) - create a pumpkin specifying property values
            arguments
                namevalue.?Pumpkin
            end
            set(P, namevalue)

            props = properties(P);
            for idx=1:length(props)
                addlistener(P, props{idx}, 'PostSet', @(h,e)P.update());
            end

            % Draw it in an axes.
            P.draw3;
            
        end
    end

    methods (Access='protected')
        
        function [X, Y, Z, C] = compute(P)
        % Compute the surface of the pumpkin.
        % Start with a sphere, and reshape it to the desired width/height,
        % and add ridges around the perimiter.
        % Color is specified against the pumpkin bumps, and not based on a simple
        % Z or R coordinate.
        % Speckled pumpkins are controlled by lightly permuting the color array.

            % Sphere generates arrays 1 larger than asked for.
            [ Xs, Ys, Zs ] = sphere(P.Resolution-1);

            % This specifies the offsets of the pumpkin ridges.
            Rxy = (0-(1-mod(linspace(0,P.NumBumps*2,P.Resolution),2)).^2)*P.BumpDepth + ...
                  (0-(1-mod(linspace(0,P.NumBumps*4,P.Resolution),2)).^2)*P.SecondaryBumpDepth;

            % This adds a dimple in the top/bottom of the pumpkin.
            Rz  = (0-linspace(1,-1,P.Resolution)'.^4)*P.DimpleDepth;

            % Compute the mesh
            X = (P.Radius+Rxy).*Xs + P.X;
            Y = (P.Radius+Rxy).*Ys + P.Y;
            Z = (P.Height+Rz).*Zs.*(Rxy+1) + P.Z;
            Zc= (P.Radius).*Zs.*(Rxy+1);
            C = hypot(hypot(X,Y),Zc);

            if P.SpeckleSize ~= 0
                % Speckles should be relatively rare, so limit how many there are.
                % While this computation is very simple, how the colormap is configured
                % will control where dots appear.
                Cm = P.computespeckles;
                Cm(Cm<.97&Cm>-.97) = 0;
                C = max(min(C + Cm*P.SpeckleSize, max(C,[],'all')), min(C,[],'all'));
            end
        end

        function sr = computespeckles(P)
        % Compute the speckle matrix.
        % Cache this matrix internally so that during animations the dots stay
        % fixed in their location.            
            if ~all(size(P.SpeckleRand) == [ P.Resolution P.Resolution ])
                P.SpeckleRand = randn(P.Resolution);
            end
            sr = P.SpeckleRand;
        end
        
        function [X, Y, Z] = computestem(P)
        % Compute the points of the stem for the pumpkin.
        % Pumpkin stems are star shaped, and the flanges of the stars usually line up with
        % the dents in the side of the pumpkin.

            rf = [ 1.5 1 .7 .7 .7 .7 .7 .7 ]; % Wider @ bottom than top of stem.

            % This specifies the star shape.
            r = [ repmat(P.StemRadius',floor(P.NumBumps),1); P.StemRadius(1)];

            % Compute the mesh as 1/4 of a torus.
            [theta, phi] = meshgrid(linspace(0,pi/2,numel(rf)),linspace(0,2*pi,numel(r)));
            X = (P.StemDims(1)-cos(phi).*r.*rf).*cos(theta)-P.StemDims(1) + P.X;
            Z = (P.StemDims(2)-cos(phi).*r.*rf).*sin(theta) + P.Height-max(0,P.DimpleDepth*.9) + P.Z;
            Y = -sin(phi).*r.*rf + P.Y;
        end
        
        function cmap = makecmap(P, lowc, highc)
        % Create a colormap that interpolates between the lower color to the higher color.
        % If this is a speckled pumpkin, have a hard boundary between the upper/lower color
        % and adjust where the boundary is to control where the spots show up.
            
            lower_color = validatecolor(lowc);
            higher_color = validatecolor(highc);

            if P.SpeckleSize == 0
                % No speckles - simple interpolated colormap
                cmap = [ linspace(lower_color(1), higher_color(1), 256);
                         linspace(lower_color(2), higher_color(2), 256);
                         linspace(lower_color(3), higher_color(3), 256) ]';
            else
                % Speckles - compute the three bands of the colormap.
                nbright = floor(P.SpeckleColorRatio*256); % # colors @ top of colormap
                ntrans = floor(P.SpeckleTransitionRatio*256); % # colors in transition area
                ndim = 245-ntrans-nbright;    % # colors @ bottom of colormap
                cmap = [ repmat(lower_color(1),1,ndim) ...
                         linspace(lower_color(1), higher_color(1), ntrans) ...
                         repmat(higher_color(1),1,nbright) ;
                         repmat(lower_color(2),1,ndim) ...
                         linspace(lower_color(2), higher_color(2), ntrans) ...
                         repmat(higher_color(2),1,nbright) ;
                         repmat(lower_color(3),1,ndim) ...
                         linspace(lower_color(3), higher_color(3), ntrans) ...
                         repmat(higher_color(3),1,nbright) ]';
            end
        end
    end

    methods
        function draw3(P)
        % Draw the pumpkin after computing the meshes.
            [ Xp, Yp, Zp, C ] = P.compute;

            % Disallow adding multiple pumpkins
            % Prevents confusion around single colormap for all pumpkins,
            % accidentally adding multiple lights, & more.
            hold off
            
            % Add the pumpkin and stem
            P.Surface = surf(Xp,Yp,Zp,C,'Tag','pumpkin');
            P.Surface.FaceColor = 'interp';
            P.Surface.EdgeColor = 'none';
            setappdata(P.Surface, 'pumpkin', P);
            
            [ Xs, Ys, Zs ] = P.computestem;
            hold on
            P.SSurface = surf(Xs,Ys,Zs,[], 'Tag', 'pumpkinstem');
            P.SSurface.FaceColor = P.StemColor;
            P.SSurface.MeshStyle = 'none';
            hold off
            
            % Misc needed features
            lighting g
            camlight
            material([P.Surface, P.SSurface],[ .6, .9, .3, 2, .5 ])
            
            daspect([1 1 1])
            colormap(gca,P.makecmap(P.Colors(1,:), P.Colors(2,:)));
        end

        function update(P)
        % If properties change, recompute as needed and update existing
        % graphics objects.
            
            if isgraphics(P.Surface,'surface')
                [ Xp, Yp, Zp, C ] = P.compute;

                set(P.Surface, 'XData', Xp, ...
                               'YData', Yp, ...
                               'ZData', Zp, ...
                               'CData', C);

                [ Xs, Ys, Zs ] = P.computestem;
                set(P.SSurface, 'XData', Xs, ...
                                'YData', Ys, ...
                                'ZData', Zs, ...
                                'CData', [], ...
                                'FaceColor', P.StemColor);

                ax = ancestor(P.Surface,'axes');
                
                colormap(ax, P.makecmap(P.Colors(1,:), P.Colors(2,:)));
            else
                disp('Pumpkin Update called, but surface is invalid.');
                P.Surface
            end
        end
    end

end