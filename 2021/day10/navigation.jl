validPairs = Dict(
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<'
)

opening = values(validPairs)

closing = keys(validPairs)

points = Dict(
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
)

input = "input.txt" |> open |> readlines

function getPoints(line)
    stack = []
    for ch in line
        if ch in opening
            push!(stack, ch)
        else
            top = pop!(stack)
            if !(validPairs[ch] == top)
                return points[ch]
            end
        end
    end
    return 0
end

map(x -> getPoints(x), input) |> sum |> println

validPairs2 = Dict(
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
)

completePoints = Dict(
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
)

function scoreIncomplete(line)
    stack = []
    for ch in line
        if ch in opening
            push!(stack, ch)
        else
            top = pop!(stack)
            if !(validPairs[ch] == top)
                return 0
            end
        end
    end
    total = 0
    for e in reverse(stack)
        total = total * 5
        total += completePoints[validPairs2[e]]
    end
    return total
end

scores = map(x -> scoreIncomplete(x), input) |> y -> filter(x -> x != 0, y) |> sort
println(scores[trunc(Int,length(scores) / 2 |> ceil)])