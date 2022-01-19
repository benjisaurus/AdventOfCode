function remove(col, item)
    return filter(x -> x != item ,col)[1]
end

function getInput(filename)
    lines = filename |> open |> readlines
    connections = Dict(
        "start" => Set()
    )
    for line in lines
        nodes = split(line, "-")
        if "start" in nodes
            other = remove(nodes, "start")
            push!(connections["start"], other)
        elseif "end" in nodes
            other = remove(nodes, "end")
            if !(other in keys(connections))
                connections[other] = Set()
            end
            push!(connections[other], "end")
        else
            for n in nodes
                other = remove(nodes, n)
                if !(n in keys(connections))
                    connections[n] = Set()
                end
                push!(connections[n], other)
            end
        end
    end
    return connections
end

function isAllUpper(s)
    return reduce(&, map(c -> isuppercase(c), collect.(s)))
end

function nextSteps(conns, path)
    lastNode = last(path)
    steps = filter( s -> isAllUpper(s) || !(s in path), conns[lastNode])
    newPaths = []
    for s in steps
        push!(newPaths, push!(path, s))
        pop!(path)
    end
    return newPaths
end

function enumeratePaths(conns, paths, finishedPaths)
    if isempty(paths)
        return finishedPaths
    else
        newPaths = Set()
        newFinished = union(finishedPaths, filter(x -> "end" in x, newPaths))
        enumeratePaths(conns, newPaths, newFinished)
    end
end

conns = getInput("sample.txt")