# Limpieza y variables derivadas. Ejecutar desde la raíz del proyecto.
paquetes <- c("readr", "dplyr", "tidyr")
faltan <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]
if (length(faltan)) stop("Instala dependencias: ", paste(faltan, collapse = ", "))

library(dplyr)
datos <- readr::read_csv("data/raw/academy_game_data.csv", show_col_types = FALSE)
requeridas <- c("DATE", "SQUAD", "FIXTURE", "VENUE", "OPPONENT", "POSITION",
                "GAME TIME (min)", "TOTAL DISTANCE (m)", "METERS/MIN",
                "HIGH-INTENSITY DISTANCE (m)", "SPRINT DISTANCE (m)", "TOP SPEED (m/s)")
faltan_cols <- setdiff(requeridas, names(datos))
if (length(faltan_cols)) stop("Faltan columnas: ", paste(faltan_cols, collapse = ", "))

datos_limpios <- datos |>
  rename(fecha = DATE, plantel = SQUAD, tipo_fixture = FIXTURE, localia = VENUE,
         rival = OPPONENT, posicion = POSITION, minutos = `GAME TIME (min)`,
         distancia_total_m = `TOTAL DISTANCE (m)`, metros_min = `METERS/MIN`,
         distancia_alta_intensidad_m = `HIGH-INTENSITY DISTANCE (m)`,
         distancia_sprint_m = `SPRINT DISTANCE (m)`, velocidad_max_ms = `TOP SPEED (m/s)`,
         tiempo_fc_mayor_85 = `TIME > 85% HR MAX`) |>
  filter(dplyr::if_any(dplyr::everything(), ~ !is.na(.x))) |>
  mutate(
    fecha = as.Date(fecha),
    across(c(posicion, plantel, tipo_fixture, localia, rival), ~ na_if(trimws(as.character(.x)), "")),
    grupo_posicion = case_when(
      posicion %in% c("CB", "FB") ~ "Defensas",
      posicion %in% c("CDM", "CAM") ~ "Centrocampistas",
      posicion %in% c("AW", "CF") ~ "Atacantes",
      TRUE ~ NA_character_
    ),
    distancia_total_90 = distancia_total_m / minutos * 90,
    distancia_alta_intensidad_90 = distancia_alta_intensidad_m / minutos * 90,
    distancia_sprint_90 = distancia_sprint_m / minutos * 90,
    velocidad_max_kmh = velocidad_max_ms * 3.6
  ) |>
  distinct()

if (any(datos_limpios$minutos <= 0, na.rm = TRUE)) stop("Hay minutos no positivos; revisar fuente.")
if (nrow(datos_limpios) == 0) stop("La tabla limpia no contiene filas.")
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
readr::write_csv(datos_limpios, "data/processed/academy_game_data_clean.csv", na = "")
message("Filas: ", nrow(datos), " en la hoja original; ", nrow(datos_limpios), " registros tras retirar filas vacías y duplicados exactos.")
message("Posición ausente: ", sum(is.na(datos_limpios$grupo_posicion)), " fila(s).")
