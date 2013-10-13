# convert a string to a function name and its arguments. Underscores are escaped by using an underscore
function parse_name(s)
    in_under = false
    symbols = String[""]
    for c in s
        if in_under
            if c == '_'
                symbols[end] *= "_"
            else
                push!(symbols,string(c))
            end
            in_under = false
        else
            if c == '_'
                in_under = true
            else
                symbols[end] *= string(c)
                in_under = false
            end
        end
    end
    symbols
end

macro funmac(e)
    name = string(e)
    syms = parse_name(name)
    args = [parse(x) for x in syms[2:end]]
    sym = symbol(syms[1])
    quote
        $(sym)($(args...))
    end
end
