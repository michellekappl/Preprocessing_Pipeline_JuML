using Preprocessing_Pipeline_JuML
using Documenter

DocMeta.setdocmeta!(Preprocessing_Pipeline_JuML, :DocTestSetup, :(using Preprocessing_Pipeline_JuML); recursive=true)

makedocs(;
    modules=[Preprocessing_Pipeline_JuML],
    authors="Michelle Kappl <michelle.kappl@gmail.com>, Leon Schreiber <leonschreiber96@gmail.com>, Marike Voßbeck <Marike_vossbeck@posteo.de>, Franziska Donhauser <franzidonhauser@googlemail.com>",
    sitename="Preprocessing_Pipeline_JuML.jl",
    warnonly = [:missing_docs],
    format=Documenter.HTML(;
        canonical="https://michellekappl.github.io/Preprocessing_Pipeline_JuML",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Getting Started" => "getting_started.md",
        "Functions" => "functions.md",
        "Elaborate example" => "example.md"
        ]
)

deploydocs(;
    repo="github.com/michellekappl/Preprocessing_Pipeline_JuML",
    devbranch="main",
)
