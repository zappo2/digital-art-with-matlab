function th_out = emojiplot(X,Y,C,opts)
% EMOJIPLOT(X,Y) - Create a scatter plot with cats (catterplot)
% EMOJIPLOT(X,Y,C) - Include color.
%           NOTE: Color doesn't apply to colored emoji after R2025a
% EMOJIPLOT(_, N, V) - Set property N to value N
%
% Properties:
%   Emoji - The character to use to draw a cat (default) OR some
%         predefined characters, or an arbitrary single character
%         you choose.
%         Valid named emoji:
%            cat, dog, spider, violin, pizza, lizard, duck
%   Size - The size (in points) for the emoji character.  Defaults to 24.
%
    arguments
        X (:,1) double = 1:8
        Y (:,1) double = (1:8)+(rand(1,8)*2-1)
        C (:,3) double = []
        opts.Emoji (1,1) string = 'cat'
        opts.Size (1,1) double = 24
    end

    % Use scatter to validate everything and fix limits.
    if ~isempty(C)
        sc = scatter(X,Y,10,C,'Marker','.');
    else
        sc = scatter(X,Y,10,'Marker','.');
    end
    C = sc.CData;

    % More than just cats.  Some other fun emoji.
    switch opts.Emoji
      case 'cat'
        T = '🐈';
        name = "Catterplot";
      case 'dog'
        T = '🐕';
        name = "Doggoplot";
      case 'spider'
        T = '🕷️';
        name = "Spiderplot";
      case 'violin'
        T = '🎻';
        name = "Violinplot";
      case 'pizza'
        T = '🍕';
        name = "Pizza Pie Chart";
      case 'lizard'
        T = '🦎';
        name = "Lizardplot";
      case 'duck'
        T = '🦆';
        name = "Duckplot";
      case 'tree'
        T = '🌳';
        name = "Treemap";
      case 'donut'
        T = '🍩';
        name = "Donutchart";
      case 'candle'
        T = '🕯️';
        name = "Candlestickplot";
      case 'tornado'
        T = '🌪️';
        name = "Tornadochart";
      otherwise
        if strlength(opts.Emoji)==1 % Simple character
            T = char(opts.Emoji);
            name = "Character Plot";
        elseif strlength(opts.Emoji)==2 && all(char(opts.Emoji) > 1000) % unicode
            T = char(opts.Emoji);
            name = "Unicode Plot";
        else
            error('Unknown Emoji name');
        end
    end

    th=gobjects();
    for idx=1:numel(X)
        if size(C,1) == 1
            c = C;
        else
            c = C(idx,:);
        end

        th(idx) = text(X(idx),Y(idx),T,'Color',c,...
                       'FontSize',opts.Size,...
                       'PickableParts','none',...
                       'HorizontalAlignment','center',...
                       'VerticalAlignment','middle');
    end

    L = opts.Emoji;
    if strlength(L) > 2
        L = regexprep(lower(L),"^.","${upper($0)}");
    elseif strlength(L) == 2
        L = "Emoji";
    else
        L = "Character";
    end
    
    title(name);
    xlabel(L + "s");
    ylabel("Also " + L + "s");
    box on
    axis padded
    grid on

    if nargout == 1
        th_out = th;
    end
end
