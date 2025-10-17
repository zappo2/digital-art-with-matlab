% Pumspring
%
% Draw a pumpkin with a ribbon, and then stretch it like a spring.

% Setup figure so we can animate on screen
fig=figure('name','Pumspring','menubar','none','toolbar','none','userdata',false);
uimenu(fig, 'Label', 'Stop', 'accel', 's', 'callback', @(m,~)set(m.Parent,'userdata',true));
drawnow;

S=10; % Number of spirals
nb=8;% Number of bumps in the punkin
rb=14;% Resolution of one bump
n=rb*nb;% Resolution of one loop around the spiral
bd=.1;% Bump depth as ratio
nframes=64;
colors=validatecolor(["#b50" "#f72"],'multiple');

% Animate until user asks it to stop.
first=true;
f = 0;

while isgraphics(fig) && ~fig.UserData
    f = mod(f,nframes)+1; % Looping frame number
    spring=sinpi(f/(nframes/2))+2;

    w=.1/spring; % Thickness of the ribbon is related to stretch
    
    % Theta goes around S times, with n verts per round.
    T_=linspace(0,S*2,n*S); % Theta
    T=[T_;T_];% top and bottom of ribbon
    
    % Phi slowly goes from -.5 to .5 (top+bottom of sphere)
    P_=linspace(-.5+w,.5,n*S); % Phi
    P=[P_;P_-w]; % top and bottom of ribbon, thickness of w.

    if first
        % Make the surface coordinates on unit sphere
        X=cospi(P).*cospi(T);
        Y=cospi(P).*sinpi(T);

        Z=(.8+(0-(P*2).^4)*.2).*sinpi(P);
        Zx=max(Z,[],'all');
        
        % Radius of punkin has bumps.  R modulates # of bumps.
        R=1-(1-mod(T*nb,2)).^2*bd;

        % Draw
        Srf=surf(R.*X,R.*Y,Z,R,'FaceColor','interp','EdgeColor','n');
        surface(X/12,Y/12,Z/2+.9,[],'FaceColor','#080','EdgeColor','n');
        camlight
        lighting g
        material([.6 .9 .3 2 .5])
        daspect([1 1 1]);
        axis([-1 1 -1 1 -3 .5],'off');
        colormap(interp1([0 1],colors,linspace(0,1,256)));
        set(gca,'pos',[0 0 1 1],'clipping','off');
        set(gcf,'color','w');
        first=false;
    end

    % Stretch in Z
    Z2=(.8+(0-(P*2).^4)*.2).*sinpi(P)*spring;
    Z2x=max(Z2,[],'all');
    set(Srf,'ZData',Z2-diff([Zx Z2x]));

    pause(1/24);
end
