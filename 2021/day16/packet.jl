function hexToBin(input)
    return join(
        map(
            c -> string(parse(Int, c, base = 16),base = 2,pad = 4), 
            collect(input)
        )
    )
end