# Demo Plots Gallery

## Basic stuff

This doesn't require anything specific, just note the use of the macro `@OUTPUT`
which creates a path for the image which you don't have to manage and that makes
inputting the image easier.

```!
using PyPlot # hide
x = randn(10)
y = randn(10)
figure(figsize=(8, 6))
plot(x, y, ls="none", marker="x", markersize=10)
savefig(joinpath(@OUTPUT, "f1.svg")) # hide
```

Inputting the fig is just as simple as `\fig{f1.svg}` no path needed:

\fig{f1.svg}

Some notes:

* locally, when you have multiple such code blocks, these only get executed once unless you modify something in the code or you modify some code in a cell _before_ it (as it can't assume that the current cell does not depend on anything from a previous cell).
* when you deploy, everything gets re-evaluated, if you have hundreds of plots this can take quite a while.

If you don't care that the deployment is slow (runs every cell every time), then this is probably all you need.

## Avoiding re-evaluation

This will get better in Franklin but, for now, the kind of stuff you could do to avoid re-evaluating everything when you deploy is:

* save figures to `_assets`
* check if there's already an image corresponding to the code block and if so don't evaluate it
* otherwise evaluate it

this quickly becomes a bit tricky as you have to keep track of whether an image needs to be updated or whether an image is orphaned (has been generated but you don't need it anymore). This is doable though. The recommendation would be to have each code block generate a figure with exactly the name of the code block.

```julia:fig1
using PyPlot # hide
x = collect(0:0.1:5)
y = @. x * exp(-sin(x))
figure(figsize=(8, 6))
plot(x, y)
savefig(joinpath(@OUTPUT, "fig1.svg")) # hide
```

\fig{fig1.svg}

The function `lx_exfiga` does some of this.

\exfiga{name="foo_1", code="""
using PyPlot
x = collect(0:0.1:5)
y = @. cos(x) * exp(-sin(x))
figure(figsize=(8, 6))
plot(x, y, lw=2)
"""}

That function could be extended in the following way:

* the saved file could be copied to a specific location in `_assets` making the image uploaded at deployment (so adding something like `cp(joinpath(@OUTPUT, "$fname"), some_path_in_assets)`)
* the function could check a priori whether `some_path_in_assets` exists, if it does, skip evaluation (by not writing the code cell, just writing the `\\fig`) part.

I'm not doing this here as I'm not 100% sure you want to go down this road, you might be fine with evaluation at every deployment.

## Generating a list of all plots

As far as I understand, you'd like to be able to have a list of plots and generate a gallery of thumbnails on which users can click and then they'd see a specific page or code or whatever.

I think potentially the easiest path here would be to leverage the name of things and call figures with something that looks like the path.
So if you do `joinpath(@OUTPUT, "fig.svg")` on `index.md`, that figure will be saved at

```
_site/assets/index/code/output/fig.svg
```

it then becomes relatively easy to just scrape all this by just exploiting the generated file names.

One thing though is that you want the evaluation of such a function to happen _last_, i.e. after all pages have been (re)processed. For this you just need to put a `@delay` in the definition of the hfun:


{{list_plots}}


you might want to add some further filtering to this etc but I'm hoping this shows some of the stuff you could do.
