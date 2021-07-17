using FranklinUtils

# \exfig1{name="foo", code="""
# ...
# """}
function lx_exfiga(lxc, _)
    _, kwargs = lxargs(lxc)
    kw = Dict(kwargs)

    io = IOBuffer()
    write(io, "```julia:$(kw[:name])\n")
    # you could even write the using pyplot, figsize stuff here
    write(io, "$(kw[:code])\n")
    fname = "$(kw[:name]).svg"
    write(io, """savefig(joinpath(@OUTPUT, "$fname")) #hide\n""")
    write(io, "```\n\\fig{$fname}\n\n")
    return String(take!(io))
end


@delay function hfun_list_plots()
    io = IOBuffer()
    write(io, "<ul>\n")
    for (root, _, files) in walkdir(joinpath("__site", "assets"))
        for file in files
            p = joinpath(root, file)
            splitext(p)[2] == ".svg" || continue
            sp = replace(p, r"^__site" => "")
            write(io, """
                <li><a href=\"$sp\">$sp</a></li>
                """)
        end
    end
    write(io, "</ul>")
    return String(take!(io))
end
