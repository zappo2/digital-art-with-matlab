function lizardFollowsMouse
% A lizard that chases your mouse around a figure window.

    % Segments of our creature - default to a line along X
    S=(1:17)'; S(:,2)=0;

    %% Lizard Design (selected for artistic reasons)
    % Follow Radii - distances between spine segments
    FR = [ .7 1.2 1.2 1.2 1.2 1.2 1.2 .6 .6 .6 .6 .6 .6 .6 .6 .6 .6 .6]';
    % Body Radii - Sizes of body at that spine segment
    BR = [ .7 1 .5 1 1 1 1 .7 .5 .35 .3 .25 .23 .21 .2 .2 .2 .1]';

    % Segment where the eyes are
    ES = 2;
    % Segments where the Legs are
    LL = [ 2 1 ];
    LS = [ 4 7 ];

    %% Spine Following matrices & logic
    nseg = size(S,1); % Number of segments in the creature.
    FV = 0; % Following Vector (to compute later)

    function dofollow()
    % Follow the anchor point in S(1,:) - the nose of the lizard.
        FV = [0 0];
        for k = 1:(size(S,1)-1)
            dir=S(k+1,:)-S(k,:);
            FV(k+1,:)=dir./vecnorm(dir,2,2); % Normalized Direction
            S(k+1,:) = FV(k+1,:)*FR(k) + S(k,:);
        end
    end

    function verts = sidepts(seg, DC)
    % Compute pts on the left & right side of a body segment SEG
    % at a distance from center of DC, a ratio of body segment size.
    % Useful for eyes & legs
        FV(:,3) = 0;
        si = [seg-1 seg]; % segment indices so there is a direction
        c = cross(FV(si,:),repmat([0 0 1],2,1)); % Find the 2 pts
        c = c./vecnorm(c,2,2).*BR(si); % normalize & adjust by the body radii
        c = c*DC; % Scale to distance from center
        % Final vertices are on the left & right, and offset around the segment
        verts = [c(2,1:2);-c(2,1:2)] + S(seg,:);
    end

    %% Initialize the spine and legs
    dofollow();
    % Init Leg History which identifies when we need to take a step.
    LH = [ sidepts(LS(1), 2); sidepts(LS(2), 2) ];
        
    %% Create Graphics

    % Re-use old axes if re-run
    newplot
    % Leg Graphic
    legl = line('XData',[],'YData',[],'Color','#03ac13','LineStyle','-');
    % Gecko feet with big toes
    toes = line('XData',[],'YData',[],'Marker','*','LineStyle','none','Color','#03ac13');

    % Body Graphics as polyshape
    ps = polyshape;
    hold on
    pso = plot(ps,'EdgeColor','#028a0f','FaceColor','#3cb043','FaceAlpha',1);
    hold off

    % Racing Stripe
    race = line('XData',[],'YData',[],'LineStyle','-.','Color','#028a0f');
    % Eye Graphic
    eyel = line('XData',[],'YData',[],'LineStyle','none','Color','#7c4700','Marker','.');

    % Setup Axes
    set(gca,'Position',[0 0 1 1 ],'Clipping','off','Interactions',[]);
    axis([-20 20 -20 20],'off','square');
    axtoolbar(gca,{},'Visible','off');
    set(findobj(gca),'PickableParts','none'); % disable hittesting for performance

    function doplot()
    % Update graphcis objects with new state for our lizard.
        for i=1:nseg
            % Create a bunch of polyshape buffers based on convex hulls of adjacent points.
            ps(i) = polybuffer(S(i,:),'point',BR(i));
            if i>1
                pseg(i-1) = convhull(union(ps(i-1:i))); %#ok
            end
        end
        set(pso,'Shape',union(pseg));            % Body
        set(race,'XData',S(:,1),'YData',S(:,2)); % Racing Stripe

        % Eyes on side of head.
        EV = sidepts(ES, .8);
        set(eyel,'XData',EV(:,1),'YData',EV(:,2));

        % Origin for each body segment that are attached to legs
        o1 = S(LS(1),1:2);
        o2 = S(LS(2),1:2);
        O = [ o1; o1; o2; o2 ];

        % Compute where feet will move to if a step is needed
        T = [ sidepts(LS(1)-1, 4);
              sidepts(LS(2)-1, 2) ];
        % Compute distance from old foot placement
        d = vecnorm(LH-O,2,2);
        % If leg can easilly reach old foot posn, don't move the foot
        Hmask = d<2.5 & d>1;
        T(Hmask,:) = LH(Hmask,:);

        LH = T;  % Update leg history to new foot positions

        % Compute geometry to draw derpy legs using inverse kinematic trick
        A=S(repelem(LS,2),:);
        XD=T-A;
        % c2 is a length length on a unit circle
        c2=(vecnorm(XD,2,2).^2-LL(1)^2-LL(2)^2)/(2*(LL(2)*LL(1)));
        % Assume no corner cases will be encountered in the lizard (not a real system)
        q2=[-1;1;1;-1].*real(acos(c2));
        q1=atan2(XD(:,2),XD(:,1))-atan2(LL(2)*sin(q2),LL(1)+LL(2)*cos(q2));
        P1=LL(1)*[cos(q1),sin(q1)];
        % Compute joints relative to anchor pt A and generate as vertex array
        verts=reshape([ nan(1,2*size(A,1))
                        reshape(A,1,[])
                        reshape(P1+A,1,[])
                        reshape(P1+LL(2)*[cos(q2+q1),sin(q2+q1)]+A,1,[])],[],2);

        % Update graphics for legs and toes
        set(legl, 'XData', verts(:,1), 'YData', verts(:,2));
        set(toes, 'XData', verts(4:4:end,1), 'YData', verts(4:4:end,2));
    end

    function movelizard(fig,~)
    % When the mouse moves, the lizard will follow.
        done = false;
        while ~done && isgraphics(fig)
            ip = get(gca,'CurrentPoint');
            if any(~isfinite(ip))
                return
            end

            % Find Normalized vector and distance to mouse
            dir=S(1,:)-ip(1,1:2);
            dist=vecnorm(dir,2,2);
            N=dir./dist;

            % By changing S(1,:) we move where the nose is.
            if dist>.5
                S(1,:) = S(1,:)-N*.5;
            else
                S(1,:) = ip(1,1:2);
                done=true;
            end
            % Follow script moves body to chase the nose.
            dofollow();
            doplot();
            drawnow
        end
    end

    function resizelizard(fig,~)
    % Setup sizes of lines and markers as ratios of the figures size.
        h = min(fig.Position(3:4));
        set(legl,'LineWidth',h/128);
        set(toes,'LineWidth',h/256,'markerSize',h/52);
        set(pso,'LineWidth',h/170);
        set(race,'LineWidth',h/102);
        set(eyel,'MarkerSize',h/25);
    end

    resizelizard(gcf);
    doplot();

    % Buggy mouse pointer
    pd = [ nan nan nan nan 2   nan nan nan nan nan nan 2   nan nan nan nan
           nan nan nan nan 1   nan nan nan nan nan nan 1   nan nan nan nan
           nan 2   nan nan 1   nan nan nan nan nan nan 1   nan nan 2   nan
           nan 1   nan nan 1   nan nan nan nan nan nan 1   nan nan 1   nan
           nan 1   nan nan 1   nan 1   1   1   1   nan 1   nan nan 1   nan
           nan 1   1   nan nan 1   1   1   1   1   1   nan nan 1   1   nan
           nan nan 1   1   nan 1   2   1   1   2   1   nan 1   1   nan nan
           nan nan nan nan 1   1   2   1   1   2   1   1   nan nan nan nan
           nan nan nan nan nan 1   2   1   1   2   1   nan nan nan nan nan
           nan nan nan 1   1   1   2   1   1   2   1   1   1   nan nan nan
           nan 1   1   nan nan 1   2   1   1   2   1   nan nan 1   1   nan
           nan 1   nan nan 1   1   1   1   1   1   1   1   nan nan 1   nan
           nan 1   nan nan 1   nan 1   1   1   1   nan 1   nan nan 1   nan
           nan 2   nan nan 1   nan nan nan nan nan nan 1   nan nan 2   nan
           nan nan nan nan 1   nan nan nan nan nan nan 1   nan nan nan nan
           nan nan nan nan 2   nan nan nan nan nan nan 2   nan nan nan nan ];
    
    % Configure the figure to handle events smoothly
    set(gcf,'Interruptible','off','BusyAction','cancel',...
            'Pointer','custom','PointerShapeCData', pd, 'PointerShapeHotSpot',[ 8 8 ],...
            'ResizeFcn',@resizelizard, 'WindowButtonMotionFcn', @movelizard)
end
