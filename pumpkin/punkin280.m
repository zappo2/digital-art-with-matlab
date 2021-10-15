% Draw a pumpkin in fewer that 280 characters of code.
% See short_punkin.m for better looking and more verbose version of this.

[X,Y,Z]=sphere(200);
R=1+(-(1-mod(0:.1:20,2)).^2)/20;
surf(R.*X,R.*Y,(.8+(0-(1:-.01:-1)'.^4)*.2).*Z.*R,'FaceC','#ff7518','EdgeC','n')
surface(X/12,Y/12,Z/2+.6,'FaceC', '#008000', 'EdgeC','n')
axis('equal','off')
lighting g
material([ .6, .9, .3, 2, .5 ])
camlight

