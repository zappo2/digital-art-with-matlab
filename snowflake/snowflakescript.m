% Draw a snowflake from a vector of step lengths

%steps=randi(10,1,randi(8)+2); % Random Flake
steps=[5 2 5 5 5 5];
%steps=[10 2 8 7 6 5]; % Big Center
%steps=[1 5 5 8 8 8 8]; % Double Star
%steps=[5 2 1 1 5 1 1 5 8]; % Thick Spurs

% Snowflake Angles & Coordinates
ang=(90:60:390)';
dist=cumsum(steps);
ringx=cosd(ang)*dist;  ringy=sind(ang)*dist; % Main spur rings
seg=[ zeros(6,2) ringx(:,end) ringy(:,end) ]; % Segment init

spurs=@(o,a,l)[o [cosd(a-60) sind(a-60)]*l+o; % Spur Fcn
               o [cosd(a+60) sind(a+60)]*l+o];

% Traverse steps vector in each direction to compute segments
for dpth=2:length(steps)
    for dir=1:6
        seg=[seg
             spurs([ringx(dir,dpth) ringy(dir,dpth)],ang(dir),...
                   min(sum(steps((dpth+1):end))/2,dist(dpth)))];
    end
end

% Convert segments into a polyshape and draw
plot(union([polyshape([ ringx(:,1) ringy(:,1) ]); % Nucleus
            polybuffer(reshape([seg nan(size(seg,1),2)]',2,[])','line',1)]));
axis equal
