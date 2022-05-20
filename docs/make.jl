using Documenter
using SeqShuffle

makedocs(
    sitename = "SeqShuffle",
    format = Documenter.HTML(),
    modules = [SeqShuffle]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/kchu25/SeqShuffle.jl.git"
)
