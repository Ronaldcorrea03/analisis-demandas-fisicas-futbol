# Instala los paquetes del proyecto en .Rlib, sin modificar la biblioteca global.
dir.create(".Rlib", showWarnings = FALSE)
.libPaths(c(normalizePath(".Rlib"), .libPaths()))
options(repos = c(CRAN = "https://cloud.r-project.org"))
paquetes <- c("readxl", "readr", "dplyr", "tidyr", "ggplot2", "knitr", "rmarkdown")
faltan <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]
if (length(faltan)) install.packages(faltan, lib = normalizePath(".Rlib"), Ncpus = 2)
message("Dependencias instaladas en .Rlib")
