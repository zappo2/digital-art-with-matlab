% Ring in MATLAB
[t,p]=meshgrid(pi/2:pi/100:pi*2.5);
D=1-min(cos(p),0)/5;
surf(-D.*cos(t),D.*sin(t),-sin(p)/3,'FaceC','#da4','EdgeC','n')
axis off equal
material([.6 .9 .9 5 .3])
light('Po',[-5 -7 14])
