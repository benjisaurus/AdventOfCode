function getInput(filename)
    map(r -> parse.(Int, r), collect.(filename |> open |> readlines))
end

function getNeighborCoords(r, c, maxR, maxC)
    coords = [
        (r - 1, c - 1),
        (r - 1, c),
        (r - 1, c + 1),
        (r, c - 1),
        (r, c + 1),
        (r + 1, c - 1),
        (r + 1, c),
        (r + 1, c + 1)
    ]
    filter!(p -> p[1] > 0 && p[2] > 0 && p[1] <= maxR && p[2] <= maxC, coords)
    return coords
end

function flash(coord, grid, flashed, toFlash)
    (r,c) = coord
    neighbors = getNeighborCoords(r,c,length(grid),length(grid[1]))
    push!(flashed, coord)
    pop!(toFlash, coord)
    map(p -> grid[p[1]][p[2]] += 1,neighbors)
    for  n in neighbors
        if grid[n[1]][n[2]] > 9 && !(n in flashed)
            push!(toFlash, n)
        end
    end
    return grid
end

function stepGrid(grid)
    grid = map(r -> .+(1, r), grid)
    flashed = Set()
    toFlash = Set()
    for r in 1:length(grid), c in 1:length(grid[1])
        if grid[r][c] > 9
            push!(toFlash, (r,c))
        end
    end
    while !(isempty(toFlash))
        for f in toFlash
            grid = flash!(f, grid, flashed, toFlash)
        end
    end
    for fsh in flashed
        grid[fsh[1]][fsh[2]] = 0
    end
    return (grid, length(flashed))
end

function applySteps(grid, times)
    totalFlashes = 0
    newGrid = grid
    for i in 1:times
        flashes = 0
        (newGrid, flashes) = stepGrid(newGrid)
        totalFlashes += flashes
    end
    return totalFlashes
end

function syncFlash(grid)
    newGrid = grid
    for i in 1:2000
        flashes = 0
        (newGrid, flashes) = stepGrid(newGrid)
        if flashes == length(grid) * length(grid[1])
            return i
        end
    end
end

applySteps(getInput("input.txt"),100) |> println

syncFlash(getInput("input.txt")) |> println