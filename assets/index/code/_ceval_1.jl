# This file was generated, do not modify it. # hide
using PyPlot # hide
x = randn(10)
y = randn(10)
figure(figsize=(8, 6))
plot(x, y, ls="none", marker="x", markersize=10)
savefig(joinpath(@OUTPUT, "f1.svg")) # hide
