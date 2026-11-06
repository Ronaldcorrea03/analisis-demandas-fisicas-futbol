# Demandas físicas según la posición en fútbol

Proyecto de análisis exploratorio en R y Quarto. Compara métricas GPS de partido entre defensas, centrocampistas y atacantes de un equipo de academia/reservas.

## Fuente de datos

Se utiliza la hoja **Academy Game Data** del conjunto *Physical Profiling*, de Ole J. Kemi (2024), publicado en [Zenodo](https://zenodo.org/records/13919745) con licencia CC BY 4.0. La extracción publicada aquí conserva 62 filas de origen, incluidas cuatro filas vacías; el script de preparación las retira y deja 58 observaciones.

La hoja incluye minutos, distancia total, distancia de alta intensidad, distancia de sprint, velocidad máxima y posición. No contiene identificador persistente del jugador, marcador, recuento de sprints ni aceleraciones. Por ello el caso se acota a las variables disponibles y las conclusiones son descriptivas. StatsBomb Open Data aporta eventos y alineaciones, no las métricas GPS analizadas. No se emplean datos de Catapult ni scraping de servicios de pago.

## Abrir y reproducir en Positron

1. Abre `proyecto_futbol.Rproj` en Positron.
2. Instala las dependencias una vez: `source("scripts/00_install_dependencies.R")`.
3. Renderiza `reports/informe.qmd` con el botón **Render**. El informe utiliza el CSV incluido y ejecuta su preparación al renderizar.
4. Para volver a extraer los datos desde el XLSX oficial, ejecuta `source("scripts/00_download_data.R")`; después ejecuta `source("scripts/01_prepare_data.R")`.

## Estructura

```text
proyecto_futbol/
├── data/raw/academy_game_data.csv   # extracción atribuida de Zenodo
├── docs/descripcion_caso.md         # planteamiento y alcance
├── descripcion_caso_entrega.docx   # documento para entregar
├── reports/informe.qmd             # informe reproducible
├── scripts/                         # descarga, preparación e instalación
├── _quarto.yml
├── proyecto_futbol.Rproj
└── README.md
```

El XLSX original (154 MB), la tabla procesada, las figuras, el HTML y las bibliotecas locales se excluyen de Git. Se pueden reconstruir siguiendo los pasos anteriores.
