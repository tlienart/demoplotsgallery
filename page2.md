# Page 2

\exfiga{name="foo", code="""
using PyPlot
x = collect(0:0.1:5)
y = @. cos(x) * exp(-sin(x).^2)
figure(figsize=(8, 6))
plot(x, y, lw=2)
"""}
