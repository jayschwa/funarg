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
    syms = map(symbol, syms)
    args = gensym()
    i = gensym()
    print(syms)
    quote
        $args = {}
        for i in 2:length($syms)
            push!($args,$(syms[$i]))
        end
        $(syms[1])($args...)
    end
end

# julia> @funmac(foo_11)
# ERROR: error compiling @funmac: syntax: prefix $ in non-quoted expression

# julia> @funmac(foo_x)
# ERROR: error compiling @funmac: syntax: prefix $ in non-quoted expression


macro funmac(e)
    name = string(e)
    syms = parse_name(name)
    syms = map(symbol, syms)
    print(syms)
    quote
        print($(syms[2]))
        $(syms[1])($(syms[2:end])...)
    end
end

# julia> @funmac(foo_x)
# [:foo,:11]ERROR: 11 not defined

# julia> @funmac(foo_x)
# [:foo,:x]5:x
