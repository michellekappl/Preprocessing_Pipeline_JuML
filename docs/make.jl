using Preprocessing_Pipeline_JuML
using Documenter

DocMeta.setdocmeta!(Preprocessing_Pipeline_JuML, :DocTestSetup, :(using Preprocessing_Pipeline_JuML); recursive=true)

makedocs(;
    modules=[Preprocessing_Pipeline_JuML],
    authors="Michelle Kappl <michelle.kappl@gmail.com>, Leon Schreiber <leonschreiber96@gmail.com>, Marike Voßbeck <Marike_vossbeck@posteo.de>",
    sitename="Preprocessing_Pipeline_JuML.jl",
    format=Documenter.HTML(;
        canonical="https://michellekappl.github.io/Preprocessing_Pipeline_JuML.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Getting Started" => "getting_started.md" 
    ],
)

deploydocs(;
    repo="github.com/michellekappl/Preprocessing_Pipeline_JuML.jl",
    devbranch="main",
)
