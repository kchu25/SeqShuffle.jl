using SeqShuffle
using Documenter

DocMeta.setdocmeta!(SeqShuffle, :DocTestSetup, :(using SeqShuffle); recursive=true)

makedocs(
    modules = [SeqShuffle],
    sitename = "SeqShuffle",
    repo="https://github.com/kchu25/SeqShuffle.jl/blob/{commit}{path}#{line}",
    authors="Shane Kuei Hsien Chu (skchu@wustl.edu)",
    sitename="SeqShuffle.jl",
    format = Documenter.HTML(prettyurls=get(ENV, "CI", "false") == "true",
                             canonical="https://kchu25.github.io/SeqShuffle.jl",
                             assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/kchu25/SeqShuffle.jl",
    devbranch="main"
)
