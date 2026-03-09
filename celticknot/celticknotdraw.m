function celticknotdraw()
% Use the arrow keys to draw a celtic knot pattern
% If you pick the wrong segment hold SHIFT to replace the last segment.
% Use Backspace to remove the last segment.
% Use ? to display the pattern to the command line for re-use later.

    % The pattern is a sequence of curves and straights
    PAT='-';

    figure;
    recompute_knot();

    set(gcf,'keypressfcn',@press);

    function press(h, evt)
        if ismember('shift', evt.Modifier)
            idx = 0;
        else
            idx = 1;
        end
        
        switch evt.Key
          case 'uparrow'
            PAT(end+idx) = '|';
          case 'downarrow'
            PAT(end+idx) = '-';
          case 'leftarrow'
            PAT(end+idx) = '(';
          case 'rightarrow'
            PAT(end+idx) = ')';
          case { 'backspace' 'delete' }
            PAT(end)='';
          case 'slash'
            disp("PAT='" + PAT + "';")
          case { 'shift' 'control' 'alt' }
          otherwise
            disp(evt.Key)
        end
        recompute_knot();
    end

    function recompute_knot()
    %% Starting condition (bottom left corner)
        A = 45; % Angle in degrees (up and to the right)
        P = [ .5 .5 0 ]; % Position (bottom left corner)
        VA = P; % Accumulation Vertex Array

        % Constants for generating geometry.
        R = 20; % Resolution
        z = zeros(R,1);
        theta = linspace(0,90,R)';
        lin = linspace(0,1,R)';
        delta = 0.1;
        dip = cospi(linspace(-1,1,R)')*delta + delta;

        %% Generate the geometry
        for ch=PAT
            % For each character in our pattern, where do travel?
            switch ch
              case { ')' '-' } 
                s = -1; % Reverse
              otherwise
                s = 1;
            end
            switch ch
              case { '(' ')' }  % Turn right (  ) left
                SEG = [ cosd(s*90-s*theta+A) sind(s*90-s*theta+A) z ]*.5;
                SEG = SEG + P - SEG(1,:); % our curve is offset from 0
                A = A-s*90; % realign our angle after a turn
              case { '-' '|' }  % Straight under -  | over
                SEG = [ cosd(A)*lin sind(A)*lin s*dip ] + P;
            end
            VA = [VA(1:end-1,:);SEG]; % Skip first pt to avoid dups
            P = SEG(end,:); % Move the head of the line
        end

        % Draw the ribbon for our celtic knotwork
        newplot;
        srf=streamribbon({ VA },{ [pi/2 zeros(1,size(VA,1)-1)] },.35);
        set(srf,'FaceColor','interp','CData',srf.ZData,'MeshStyle','col');
        axis off tight equal 
        colormap summer
        set(gca,'interactions',[]);
    end


end
