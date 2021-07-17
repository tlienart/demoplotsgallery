# This file was generated, do not modify it. # hide
using PyPlot # hide
x = collect(0:0.1:5)
y = @. x * exp(-sin(x))
figure(figsize=(8, 6))
plot(x, y)
savefig(joinpath(@OUTPUT, "fig1.svg")) # hide