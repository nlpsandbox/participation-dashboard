synapser::synLogin()

if(interactive()){
  build_dir <- "./build"
} else {
  build_dir <- "/build"
}

if(!dir.exists(build_dir)){
  dir.create(build_dir)
  config_file <- "./config.json"
} else{
  if(file.exists(stringr::str_c(build_dir, "/config.json"))){
    config_file <-  stringr::str_c(build_dir, "/config.json")
  } else {
    config_file <- "./config.json"
  }
}

config <- rjson::fromJSON(file = config_file)

for(job in config$jobs){

  output_file <- stringr::str_c(build_dir, "/", job$output_file)

  rmarkdown::render(
    input       = job$markdown_file,
    output_file = output_file,
    params      = c(
      list("title" = job$title),
      job$notebook_parameters
    )
  )

  if(job$upload_to_synapse){
    entity <- synapser::File(
      output_file,
      parent = job$destination_folder_synapse_id
    )

    synapser::synStore(entity)
  }
}


