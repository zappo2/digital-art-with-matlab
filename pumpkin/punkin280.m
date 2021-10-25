% Draw a pumpkin in fewer that 280 characters of code.
% Used a variant of this for the mini-hack competition.
% See short_punkin.m for better looking and more verbose version of this.

% A wee little pumpkin script.

% Start with a sphere.  While I'm passing in 200, it returns
% matrices that are 201x201.
[X,Y,Z]=sphere(200);

% This computes a vector that is a repeating bump.  We'll multiply
% this against X,Y,Z to create the dents along the sides of the
% pumpkin.
% Normally I'd use linspace to make it easier to change the number
% of bumps, but using colonop instead saves around 10 chars.
R=1-(1-mod(0:.1:20,2)).^2/15;

% Multiply X,Y against R for bumps.  Add a dimple to the top/bottom
% of the pumpkin in addition to making it more squat for Z.
% By doing all this inline I saved ~12 chars.
surf(R.*X,R.*Y,(.8+(0-(1:-.01:-1)'.^4)*.2).*Z.*R,FaceC='#ff7518',EdgeC='n')

% Use surface for the stem so we don't need a "hold on" command.  This
% save about 4 chars.  For the stem we re-use the sphere matrices,
% and just translate and scale it into the right spot.
% Real pumpkin stems are star shaped, where each point of the star
% lines up with a dent in the pumpkin.  Sadly that's around 155 chars.
surface(X/12,Y/12,Z/2+.6,FaceC='#080',EdgeC='n')

% This keeps our aspect ratio looking good and hides the axes.
% You can fixup the aspect ratio with "daspect([1 1 1])", but
% "equal" does that and a few other handy things with the plot box.
axis equal off

% I trimmed out some features like the minor-bump set to make room
% for better control over the material.  This brighten things up
% with a little more ambient light, and keeps the reflectance high
% while minimizing the white splotch produced by specular
% highlighting.  I like this look which is a bit more waxy like a
% real pumpkin.
material([.6 .9 .3 2 .5])
lighting g
camlight

% I'm glad that comments don't count toward the character count!
title('Happy Halloween!')
