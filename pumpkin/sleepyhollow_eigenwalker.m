% Sleepyhollow Eigenwalker
%
% Walking code from Cleve's Eigenwalker blog post:
% Cleve's Corner, http://blogs.mathworks.com/cleve/2016/04/11
%
% See the initial version here:
% https://www.mathworks.com/matlabcentral/communitycontests/contests/6/entries/15884

% Setup figure so we can run forever.
fig = figure('Name','Sleepyhollow Eigenwalker');
fig.Position(3:4) = [640 480];

% Setup Axes
axes('Position',[0 0 1 1],'Clipping','off','DataAspectRatio',[1 1 1],'Box','on',...
     'XTick',[],'ZTick',[],'YTickLabels',[])
axis([-750 750 -750 750 0 1550])
grid on
view(160,10)
camlight right

% Create a pumpkin head
px=hgtransform;
[X,Y,Z]=sphere(200);
R=1+(-(1-mod(0:.1:20,2)).^2)/20;
surface(px,R.*X,R.*Y,(.8+(0-(1:-.01:-1)'.^4)*.2).*Z.*R,'FaceColor','#ff7518','EdgeColor','none')
surface(px,X/12,Y/12,Z/2+.6,'FaceColor','#008000','EdgeColor','none')
material([ .6, .9, .3, 2, .5 ])

% Walking Parameters
omega = 2*pi/151.5751;
fps = 48;
dt = 2*pi/omega/fps;

% coefficients
V = [ 5 -43 -182 0 1
      2064 14 -131 11 39
      2092 -215 -192 28 15
      1660 -72 -173 -1 3
      -7 -78 -173 2 1
      -1664 -79 -178 4 -3
      -2097 -246 -200 -28 -20
      -2016 -36 -168 -19 -49
      536 53 127 0 15
      794 11 83 -3 47
      931 -73 -145 1 -2
      20 -63 -113 1 0
      -883 -74 -146 1 -1
      -831 17 74 2 -47
      -567 61 125 0 -20
      205 -11 -4 -37 27
      500 -1010 -256 37 9
      -686 -606 -174 -11 17
      -59 -153 -52 -57 32
      -114 -7 -4 -62 35
      -177 139 44 -61 34
      -717 691 170 -12 16
      414 1174 254 36 0
      -544 2214 -576 327 -259
      859 1247 170 51 264
      -42 -10 -29 -115 80
      78 -10 0 -115 67
      -58 -10 33 -116 79
      832 -1240 -175 56 266
      -557 -2227 586 349 -271
      13837 1 0 70 86
      7695 -189 -11 124 6
      9721 61 44 82 59
      12251 -20 22 76 85
      12058 1 0 74 85
      12320 21 -23 78 82
      9774 -65 -39 83 49
      7766 224 17 119 -23
      984 -120 548 -105 266
      4122 250 49 123 30
      7897 -12 -31 70 84
      8766 1 1 70 87
      7889 13 32 70 86
      4157 -249 -52 124 35
      985 127 -548 -116 269];

% The legs for Walking
L = {[1 5],[5 12],[2 3 4 5 6 7 8],[9 10 11 12 13 14 15]};
C = {'#ff7518' "#000" "#000" "#6E260E"};
M = {'none' 'none' 'h' '^'};
W = [4 10 4 6];
p = gobjects(1,4);
for k = 1:4
    p(k) = line(0,0,0,...
                'Color',C{k},'MarkerFaceColor',C{k},...
                'MarkerEdgeColor','none',...
                'Marker',M{k},'MarkerSize',12, ...
                'LineStyle','-','LineWidth',W(k));
end

% Animate until figure is closed
f = 1;
while isgraphics(fig)
    % 48 frame looping animation
    f = mod(f,47)+1;
    
    % Next step in eigenwalker
    t = (f-1)*dt;
    c = [1 sin(omega*t) cos(omega*t) sin(2*omega*t) cos(2*omega*t)]'/10;
    X = reshape(V*c,15,3);
    for k = 1:4
        p(k).XData = X(L{k},1);
        p(k).YData = X(L{k},2);
        p(k).ZData = X(L{k},3);
        p(k).MarkerIndices = [1 numel(L{k})];
    end

    % Move the pumpkin head over the neck
    px.Matrix = makehgtform('translate',X(1,:),'scale',180);
    
    % Make a treadmill like thing for him to walk on
    span=750*2;
    offset=f/48*span;
    yticks(linspace(-750-span-offset,750+span-offset,10));

    % Draw this frame
    drawnow
end
