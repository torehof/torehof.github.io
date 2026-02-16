#!/usr/bin/env Rscript

source_candidates <- c(
  file.path("data", "package_parameters_from_pre2dup.rds"),
  "package_parameters_from_pre2dup.rds"
)

source_file <- source_candidates[file.exists(source_candidates)][1]
if (is.na(source_file)) {
  stop(
    "Could not find package_parameters_from_pre2dup.rds in expected locations: ",
    paste(source_candidates, collapse = ", ")
  )
}

message("Reading: ", source_file)
meds <- readRDS(source_file)

if (!is.data.frame(meds)) {
  stop("RDS object must be a data.frame-compatible object.")
}

required_cols <- c("ATC", "ATC_name")
missing_cols <- setdiff(required_cols, names(meds))
if (length(missing_cols) > 0) {
  stop("Missing required column(s): ", paste(missing_cols, collapse = ", "))
}

out_dir <- file.path("docs", "data")
if (!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = TRUE)
}

json_path <- file.path(out_dir, "meds.json")
csv_path <- file.path(out_dir, "meds.csv")

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required to write JSON.")
}

jsonlite::write_json(
  meds,
  path = json_path,
  pretty = FALSE,
  auto_unbox = TRUE,
  na = "null"
)

if (requireNamespace("data.table", quietly = TRUE)) {
  data.table::fwrite(meds, csv_path, na = "")
} else {
  utils::write.csv(meds, csv_path, row.names = FALSE, na = "")
}

message("Wrote: ", json_path)
message("Wrote: ", csv_path)
