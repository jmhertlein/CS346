function [costs, moves] = dpPath(DSI, occCost, max_DSI)

[rows, cols] = size(DSI);

costs = inf(rows, cols);
moves = zeros(rows, cols);

costs(1,:) = (0:cols-1) * occCost;
costs(:,1) = (0:rows-1)' * occCost;

for row = 2:cols
  for col = row:min(cols, row+max_DSI)
    diag = costs(row-1, col-1) + DSI(row, col);
    vert = costs(row-1, col) + occCost;
    horiz = costs(row, col-1) + occCost;
    [costs(row,col) moves(row,col)] = min([diag, vert, horiz]);
  end
end


