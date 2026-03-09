%% Celtic Knot Pattern
% The pattern is encoded as a sequence of curves and straights
%  (  )  -> Turn right or left
%  -  |  -> Stright with a downward dip or upward bump
PAT='-|-|-))|(-))|(-)|-)|-)|-))|((-|(-|(-|(-)|((-)|((';

% Starting state
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
    % For each character in our pattern, where to travel?
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

