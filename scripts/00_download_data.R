# Descarga el XLSX original de Zenodo y extrae únicamente la hoja de partidos
# de academia. Ejecutar desde la raíz del proyecto.
if (!requireNamespace("readxl", quietly = TRUE) || !requireNamespace("readr", quietly = TRUE)) {
  stop("Instala primero readxl y readr con install.packages().")
}

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
xlsx <- "data/raw/physical_profiling.xlsx"
url <- "https://zenodo.org/api/records/13919745/files/Football%20Profiling%20Study%20Data%20v01.xlsx/content"

if (!file.exists(xlsx)) {
  download.file(url, xlsx, mode = "wb", method = "auto", quiet = FALSE)
}

datos <- readxl::read_excel(xlsx, sheet = "Academy Game Data")
readr::write_csv(datos, "data/raw/academy_game_data.csv", na = "")
message("Extracción guardada: data/raw/academy_game_data.csv (", nrow(datos), " filas).")
