server <- function(input, output){
  
  # dataset
  output$dataset_eq_domain <- renderDT(
    server = F,
    {
      data_domain %>%
        select(-kode) %>%
        datatable(
          .,
          extensions = "Buttons",
          options = list(
            scrollX = T,
            dom = "lBfrtip",
            buttons =
              list(
                list(
                  extend = "csv",
                  buttons = c("csv"),
                  exportOptions = list(
                    modifiers = list(page = "all")
                  )
                )
              )
          )
        ) %>%
        formatRound(
          columns = setdiff(
            col_domain,
            c(
              "kode", "provinsi", "tahun"
            )
          ),
          digits = 3
        )
    })
  
  output$dataset_indeks <- renderDT(
    server = F,
    {
      data_idx %>%
        select(-kode) %>%
        filter(
          indikator %in% ifelse(
            input$dataset_idx == "Equal Domain",
            "IW equal domain",
            "IW equal indikator")) %>%
        datatable(
          .,
          extensions = "Buttons",
          options = list(
            scrollX = T,
            dom = "lBfrtip",
            buttons =
              list(
                list(
                  extend = "csv",
                  buttons = c("csv"),
                  exportOptions = list(
                    modifiers = list(page = "all")
                  )
                )
              )
          )
        ) %>%
        formatRound(
          columns = "indeks",
          digits = 3
        )
    })
  
  # line plot
  output$plot_line <- renderPlotly({
    
    # pilihan datanya
    data_interest <- data_idx %>%
      # apakah Indikator equal domain
      # atau equal indikator
      filter(
        indikator %in% input$line_indikator) %>%
      # pilih rentang tahun
      filter(
        between(tahun,
                # antara minimal
                input$line_tahun[1],
                # hingga maksimal
                input$line_tahun[2])) %>%
      # pilih provinsi ditampilkan
      filter(
        provinsi %in% input$line_provinsi) %>%
      # kelompokkan berdasarkan provinsi
      group_by(provinsi)
      
    
    # hasil plot berdasarkan data
    fig <- plot_ly(
      data = data_interest,
      type = "scatter",
      mode = "lines",
      x = ~tahun,
      y = ~indeks,
      text = ~provinsi,
      hovertemplate = paste(
        "%{text}",
        "<br>tahun %{x}",
        "<br>Indeks %{y}"),
      # group = ~provinsi,
      color = ~indikator,
      colors = "Set1") %>%
      # sesuaikan tema di plotly
      layout(
        .,
        title = list(
          text = "Perkembangan Indeks Well Being di Indonesia"),
        xaxis = list(
          title = list(
            text = "Tahun")),
        yaxis = list(
          title = list(
            text = "Indeks")),
        showlegend = F)
    return(fig)
  })
  
  # bar plot
  output$plot_bar <- renderPlotly({
    
    # pilihan datanya
    data_interest <- data_idx %>%
      # apakah Indikator equal domain
      # atau equal indikator
      filter(
        indikator %in% input$bar_indikator) %>%
      # pilih rentang tahun
      filter(
        tahun == input$bar_tahun)
    
    
    # hasil plot berdasarkan data
    fig <- plot_ly(
      data = data_interest,
      type = "bar",
      y = ~provinsi,
      x = ~indeks,
      text = ~provinsi,
      hovertemplate = paste(
        "%{text}",
        "<br>Indeks %{x}"),
      # group = ~provinsi,
      color = ~indikator,
      colors = "Set1") %>%
      layout(
        .,
        # beri judul
        title = list(
          text = paste(
            "Bar Plot Indeks Well Being di Indonesia Tahun",
            input$bar_tahun
          )
        ),
        
        # urutkan dari terbesar ke terkecil
        yaxis = list(
          # judul y axis
          title = list(
            text = "Provinsi"),
          # pilihan menyesuaikan
          categoryorder = ifelse(
            input$bar_urut == "Ascending",
            "total descending",
            "total ascending")),
        # untuk x axis
        xaxis = list(
          # judul
          title = list(
            text = "Indeks")),
        showlegend = F)
    return(fig)
  })
  
  # radar plot
  output$plot_radar <- renderPlotly({
    
    # pilihan datanya
    data_interest <- data_indikator %>%
      # pilih tahun untuk radar plot
      filter(
        tahun %in% input$radar_tahun) %>%
      # pilih provinsi untuk radar plot
      filter(
        provinsi %in% input$radar_provinsi) %>%
      # buat pivot longer
      pivot_longer(
        cols = Environment:Safety,
        names_to = "domain",
        values_to = "nilai_domain") %>%
      # group by berdasarkan tahun dan provinsi
      group_by(tahun, provinsi)
    
    fig <- plot_ly(
      data = data_interest,
      type = "scatterpolar",
      r = ~nilai_domain,
      theta = ~domain,
      text = ~tahun,
      color = ~provinsi,
      colors = "Set1",
      # arahkan cursor
      hovertemplate = paste(
        "Domain : %{theta}",
        "<br>Nilai Domain : %{r}",
        "<br> Tahun : %{text}"),
      fill = "toself") %>%
      
      # tema pada plot
      layout(
        title = list(
          text = "Radar Plot Nilai Tiap Domain dengan Pembobot Equal Domain"
        )
      )
    
    return(fig)
  })
  
  # plot peta
  output$plot_map <- renderPlot({
    
    # data interest
    data_interest <- data_idx %>%
      # pilih tahun
      filter(
        tahun == input$map_tahun) %>%
      # pilih pembobot
      filter(
        indikator %in% ifelse(
          input$map_weight == "Equal Domain",
          "IW equal domain",
          "IW equal indikator"))
    
    # peta interest
    peta_interest <- peta %>%
      left_join(data_interest)
    
    # peta di R
    fig <- ggplot(
      peta_interest) +
      geom_sf(
        aes(
          geometry = geometry,
          fill = indeks)) +
      scale_fill_gradient(
        low = "yellow",
        high = "green",
        na.value = "grey95") +
      annotation_scale() +
      annotation_north_arrow(location = "tr") +
      coord_sf(crs = 4326) + 
      labs(
        title = paste0(
          "Sebaran Nilai Indeks Well Being dengan Pembobot ",
          input$map_weight,
          " Tahun ",
          input$map_tahun
        ),
        x = "Longitude",
        y = "Latitude") +
      theme_minimal()
    
    return(fig)
  })
}