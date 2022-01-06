function getInput(filename)
    content = filename |> open |> readlines
    collect.(content) |> r -> map(c -> map(x -> parse(Int16,x),c) ,r)
end

function getNeighbors(x, y, rows, cols)
    neighbors = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]
    filter!(p -> p[1] > 0 && p[1] <= cols, neighbors)
    filter!(p -> p[2] > 0 && p[2] <= rows, neighbors)
    return neighbors
end

function getNeighborVals(coords, rows, cols, grid)
    map(c -> grid[c[2]][c[1]], getNeighbors(coords[2],coords[1],rows,cols))
end

function getBasin(members, frontier, grid, rows, cols)
    if isempty(frontier)
        return members
    else
        p = pop!(frontier)
        if grid[p[2]][p[1]] == 9
            getBasin(members, frontier, grid, rows, cols)
        else
            push!(members, p)
            neighbors = getNeighbors(p[1],p[2], rows, cols)
            for n in neighbors
                if !(n in members)
                    push!(frontier, n)
                end
            end
            getBasin(members, frontier, grid, rows, cols)
        end
    end
end

grid = getInput("input.txt")
rows = length(grid)
cols = length(grid[1])
lowest = filter( x -> grid[x[2]][x[1]] < minimum(getNeighborVals((x[2],x[1]),rows,cols,grid)),[(c,r) for r in 1:rows, c in 1:cols])
map(a -> 1 + grid[a[2]][a[1]], lowest) |> sum |> println

basins = map(b -> getBasin(Set(), push!(Set(), b), grid, rows, cols), lowest)
sort(basins, by=length, rev=true)[1:3] |> x -> map(y -> length(y), x) |> prod |> println