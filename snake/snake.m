% Create a snake toy
numblock=24;
v = [ -1 -1 -1 ; 1 -1 -1 ; -1  1 -1 ; -1  1  1 ; -1 -1  1 ; 1 -1  1 ];
f = [ 1 2 3 nan; 5 6 4 nan; 1 2 6 5; 1 5 4 3; 3 4 6 2 ];
clr = hsv(numblock);
shapes = [ 1 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 % box
           0 0 .5 -.5 .5 0 1 0 -.5 .5 -.5 0 1 0 .5 -.5 .5 0 1 0 -.5 .5 -.5 0 % fluer
           0 0 1 1 0 .5 -.5 1 .5 .5 -.5 -.5 1 .5 .5 -.5 -.5 1 .5 .5 -.5 -.5 1 .5 % bowl
           0 .5 -.5 -.5 .5 -.5 .5 .5 -.5 .5 -.5 -.5 .5 -.5 .5 .5 -.5 .5 -.5 -.5 .5 -.5 .5 .5]; % ball

% Build the assembly
set(gcf,'color','black');
daspect(newplot,[1 1 1]);
xform=@(R)makehgtform('axisrotate',[0 1 0],R,'zrotate',pi/2,'yrotate',pi,'translate',[2 0 0]);
P=hgtransform('Parent',gca,'Matrix',makehgtform('xrotate',pi*.5,'zrotate',pi*-.8));
for i = 1:numblock
    P = hgtransform('Parent',P,'Matrix',xform(shapes(end,i)*pi));
    patch('Parent',P, 'Vertices', v, 'Faces', f, 'FaceColor',clr(i,:),'EdgeColor','none');
    patch('Parent',P, 'Vertices', v*.75, 'Faces', f(end,:), 'FaceColor','none',...
          'EdgeColor','w','LineWidth',2);
end
view([10 60]);
axis tight vis3d off
camlight

% Setup vectors for animation
h=findobj(gca,'type','hgtransform')';  h=h(2:end);
r=shapes(end,:)*pi;
steps=100;

% Animate between different shapes
for si = 1:size(shapes,1)
    sh = shapes(si,:)*pi;
    diff = (sh-r)/steps;

    % Animate to a new shape
    for s=1:steps
        arrayfun(@(tx)set(h(tx),'Matrix',xform(r(tx)+diff(tx)*s)),1:numblock);
        view([s*360/steps 20]); drawnow();
    end

    r=sh;
    for s=1:steps; view([s*360/steps 20]); drawnow(); end % finish rotate
end
