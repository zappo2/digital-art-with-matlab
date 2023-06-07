function rv=snakeshapes(name)
% Return a vector that can be used by the snake script for your own animation.
    
    rv = zeros(24,1);
    n=pi/2;

    switch name
      case 'ball'
        rv = [ 0 .5 -.5 -.5 .5 -.5 .5 .5 -.5 .5 -.5 -.5 ...
               .5 -.5 .5 .5 -.5 .5 -.5 -.5 .5 -.5 .5 .5];
      case 'wave'
        rv = [ 0 0 1 0 1 0 1 0 1 0 1 0 ...
               1 0 1 0 1 0 1 0 1 0 1 0];
      case 'dna'
        rv = [ .5 .5 .5 .5 .5 .5 .5 .5 .5 .5 .5 .5 ...
               .5 .5 .5 .5 .5 .5 .5 .5 .5 .5 .5 .5];
      case 'spiral'
        rv = [ 0 .5 0 .5 0 .5 0 .5 0 .5 0 .5 ...
               0 .5 0 .5 0 .5 0 .5 0 .5 0 .5];
      case 'coil'
        rv = [ 0 .5 1 .5 1 .5 1 .5 1 .5 1 .5 ...
               1 .5 1 .5 1 .5 1 .5 1 .5 1 .5];
      case 'box'
        rv = [ 0 0 0 0 0 0 1 0 0 0 0 ...
               1 0 0 0 0 0 0 1 0 0 0 0 1];
      case 'filledbox'
        rv = [ 0 1 0 0 0 1 1 0 0 0 0 1 ...
               0 0 1 0 0 0 0 1 1 0 0 0];
      case 'cross'
        rv = [ 0 0 0 1 1 0 0 0 1 0 1 1 ...
               0 1 0 1 1 0 1 0 1 1 0 1];
      case 'heart'
        rv = [ 0 0 1 0 0 .5 0 .5 0 0 0 0 ...
               1 0 0 0 0 -.5 0 -.5 0 0 1 0];
      case 'dog'
        rv = [ 0 1 0 0 0 1 1 0 1 0 0 ...
               1 0 1 1 0 0 0 1 0 1 1 0 1 ];
      case 'chicken'
        rv = [ 0 1 0 0 0 0 0 1 1 0 ...
               .5 0 1 1 0 1 1 0 -.5 ...
               0 1 1 0 0];
      case 'swan'
        rv = [ 0 1 1 0 0 0 0 0 1 -.5 -.5 -.5 ...
               .5 -.5 .5 n -.5 .5 -.5 -.5 -.5 1 0 1];
      case 'fatboa'
        rv = [ 0 0 1 0 1 0 0 -n -n -n ...
               n -n n n -n n -n -n -n 0 0 1 0 1];
      case 'duck'
        rv = [ 0 1 1 0 0 0 n 0 n 0 0 -n ...
               1 n 0 0 n 1 -n 0 0 n 0 n];
      case 'robot'
        rv = [ 0 0 n 0 -n n n n -n -n -n -n ...
               1 n n n n -n -n -n n 0 -n 0];
      case 'symbol'
        rv = [ 0 1 0 1 n n -n n -n -n 1 0 ...
               1 1 0 1 n n -n n -n -n 1 0];        
      case 'fluer'
        rv = [ 0 0 n -n n 0 1 0 -n n -n 0 ...
               1 0 n -n n 0 1 0 -n n -n 0];
      case 'bowl'
        rv = [ 0 0 1 1 0 n -n 1 n n -n -n ...
               1 n n -n -n 1 n n -n -n 1 n];
      case 'spring'
        rv = [ 0 -n n 0 n -n n 0 n -n n 0 ...
               n -n n 0 n -n n 0 n -n n 0];
      case 'cobra'
        rv = [ 0 1 -n 0 0 0 1 n n 0 1 0 0 ...
               0 n 0 1 1 0 1 1 0 n 0];
      case 'mikesnake'
        rv = [ 0 0 1 0 0 0 1 0 0 1 0 0 ...
               0 1 0 0 1 0 0 0 1 0 0 0];
      case 'line'
        rv = [ 0 0 0 0 0 0 0 0 0 0 0 0 ...
               0 0 0 0 0 0 0 0 0 0 0 0];
      case 'reset'
        rv = [ 0 0 0 0 0 0 0 0 0 0 0 0 ...
               0 0 0 0 0 0 0 0 0 0 0 0];
    end

    rv=rv*pi;
end
