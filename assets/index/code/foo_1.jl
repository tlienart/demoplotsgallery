# This file was generated, do not modify it. # hide
using PyPlot
x = collect(0:0.1:5)
y = @. cos(x) * exp(-sin(x))
figure(figsize=(8, 6))
plot(x, y, lw=2)

savefig(joinpath(@OUTPUT, "foo_1.svg")) #hide