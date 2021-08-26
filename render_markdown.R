library(argparse)

parser = ArgumentParser()

parser$add_argument(
  "--source_table_synapse_id",
  type = "character",
  required = TRUE
)

parser$add_argument(
  "--destination_folder_synapse_id",
  type = "character",
  default = NULL
)

args = parser$parse_args()

synapser::synLogin()


if(is.null(args$destination_folder_synapse_id)){
  output_file <- "/build/participation-dashboard.html"
} else {
  output_file <- "./participation-dashboard.html"
}

rmarkdown::render(
  input       = "./participation-dashboard.Rmd",
  output_file = output_file,
  params      = list("source_table_synapse_id" = args$source_table_synapse_id)
)

if(!is.null(args$destination_folder_synapse_id)){
  entity <- synapser::File(
    "./participation-dashboard.html",
    parent = args$destination_folder_synapse_id
  )

  synapser::synStore(entity)
}
