data_idx <- read_excel("data/data_wellbeing.xlsx",
                       sheet = "tidy1")
data_domain <- read_excel("data/data_wellbeing.xlsx",
                             sheet = "tidy2")
peta <- st_read("data/idn_admbnda_adm1_bps_20200401.shp") %>%
  mutate(
    kode = paste0(
      str_extract(ADM1_PCODE, "\\d{2}"),
      "00") %>%
      as.numeric()
  )

indikator_dimensi <- c(
  "Environment",
  "Income",
  "Housing",
  "Work",
  "Health",
  "Education",
  "Social Security",
  "Subjective Well Being",
  "Democratic Engagement",
  "Safety")

vector_prov <- unique(data_idx$provinsi)
col_domain <- names(data_domain)
