ui <- bs4DashPage(
  # overall
  freshTheme = "modern",
  help = NULL,
  dark = F,
  title = "Well Being Index",
  
  # header
  header = bs4DashNavbar(
    sidebarIcon = icon("list"),
    title = "Well Being Index",
    status = "info"),
  
  # sidebar
  sidebar = bs4DashSidebar(
    id = "SidebarMenu",
    status = "info",
    skin = "dark",
    # menu pada sidebar
    bs4SidebarMenu(
      # tab home
      bs4SidebarMenuItem("Home",
                         tabName = "home",
                         icon = icon("home")),
      # tab metodologi
      bs4SidebarMenuItem("Metodologi",
                         tabName = "metodologi",
                         icon = icon("microscope")),
      # tab data
      bs4SidebarMenuItem(
        "Data",
        tabName = "data",
        icon = icon("database"),
        # dalam tab data
        # ada dataset indikator
        bs4SidebarMenuSubItem(
          "Data Indikator",
          tabName = "data_indikator",
          icon = icon("database")),
        # ada dataset indeks
        bs4SidebarMenuSubItem(
          "Indeks Well-Being",
          tabName = "data_idx",
          icon = icon("database")),
        # ada data indikator equal domain
        bs4SidebarMenuSubItem(
          "Data Equal Domain",
          tabName = "eq_domain",
          icon = icon("database"))),
      # tab visualisasi
      bs4SidebarMenuItem(
        "Visualisasi",
        icon = icon("chart-bar"),
        # dalam tab visualisasi ada visualisasi lagi
        
        # visualisasi garis
        bs4SidebarMenuSubItem(
          "Line Plot Indeks",
          tabName = "line",
          icon = icon("chart-line")),
        
        # visualisasi bar
        bs4SidebarMenuSubItem(
          "Bar Plot",
          tabName = "bar",
          icon = icon("chart-bar")),
        # visualisasi radar
        bs4SidebarMenuSubItem(
          "Radar Plot",
          tabName = "radar",
          icon = icon("chart-bar")),
        # visualisasi peta
        bs4SidebarMenuSubItem(
          "Map Plot",
          tabName = "map",
          icon = icon("chart-bar")))
    )
  ),
  
  # body
  body = bs4DashBody(
    # panel navigasi
    bs4TabItems(
      
      # tab home
      bs4TabItem(
        tabName = "home",
        box(
          width = 12,
          title = strong("Home"),
          icon = icon("info-circle"),
          status = "info",
          background = "white",
          solidHeader = T,
          br(),
          withMathJax(
            includeMarkdown(
              path = "teks/home.Rmd"
            )
          ),
          # di dalam box adalah box lagi yang menjelaskan home
          box(
            width = 12,
            title = "Pembangunan Berkelanjutan Sebagai Keniscayaan",
            icon = icon("sun"),
            status = "success",
            background = "white",
            solidHeader = T,
            br(),
            withMathJax(
              includeMarkdown(
                path = "teks/home1.Rmd"
              )
            )
          ),
          # di dalam box adalah box lagi yang menjelaskan home
          box(
            width = 12,
            title = "Well-Being Sebagai Ukuran Pembangunan Berkelanjutan",
            icon = icon("ruler"),
            status = "success",
            background = "white",
            solidHeader = T,
            collapsed = T,
            br(),
            withMathJax(
              includeMarkdown(
                path = "teks/home2.Rmd"
              )
            )
          ),
          # di dalam box adalah box lagi yang menjelaskan home
          box(
            width = 12,
            title = "Sustainable Well-Being Framework",
            icon = icon("atom"),
            status = "success",
            background = "white",
            solidHeader = T,
            collapsed = T,
            br(),
            withMathJax(
              includeMarkdown(
                path = "teks/home3.Rmd"
              )
            )
          ),
          box(
            width = 12,
            title = "Referensi",
            icon = icon("book"),
            status = "success",
            background = "white",
            solidHeader = T,
            collapsed = T,
            br(),
              tags$iframe(
                src = "home_referensi.html",
                width = '100%',
                height = 800,
                style = "border:none;"
              )
          )
        )
      ),
      
      # tab dataset Indikator
      bs4TabItem(
        tabName = "data_indikator",
        box(
          width = 12,
          title = strong("Dataset Indikator"),
          icon = icon("database"),
          status = "success",
          background = "white",
          solidHeader = T,
          # buat menjadi bagian kiri dan kanan
          sidebarLayout(
            sidebarPanel = sidebarPanel(
              width = 3.5,
              # buat sebuah box untuk melingkupi panel kiri
              box(
                width = 12,
                title = "Atur Tabel Indikator",
                status = "success",
                solidHeader = T,
                icon = icon("gears"),
                selectInput(
                  inputId = "data_indikator_dim",
                  label = "Pilih Dimensi",
                  choices = indikator_dimensi
                )
              )
            ),
            mainPanel = mainPanel(
              # dataset
              DTOutput(
                outputId = "data_indikator"
              )
            )
          )
        )
      ),
      
      # tab dataset equal domain
      bs4TabItem(
        tabName = "data_idx",
        box(
          width = 12,
          title = strong("Dataset Indeks"),
          icon = icon("database"),
          status = "success",
          background = "white",
          solidHeader = T,
          
          sidebarLayout(
            sidebarPanel = sidebarPanel(
              width = 3,
              box(
                width = 12,
                title = "Pilih Pembobot",
                solidHeader = T,
                status = "success",
                icon = icon("gears"),
                radioButtons(
                  inputId = "dataset_idx",
                  label = "Pembobot",
                  choices = c("Equal Domain",
                              "Equal Indikator"),
                  selected = "Equal Domain"
                )
              )
            ),
            mainPanel = mainPanel(
              # dataset
              DTOutput(
                outputId = "dataset_indeks"
              )
            )
          )
        )
      ),
      
      # tab dataset equal domain
      bs4TabItem(
        tabName = "eq_domain",
        box(
          width = 12,
          title = strong("Dataset Equal Domain"),
          icon = icon("database"),
          status = "success",
          background = "white",
          solidHeader = T,
          # dataset
          DTOutput(
            outputId = "dataset_eq_domain"
          )
        )
      ),
      
      # tab metodology
      bs4TabItem(
        tabName = "metodologi",
        box(
          width = 12,
          title = strong("Methodology"),
          icon = icon("book"),
          status = "primary",
          background = "white",
          solidHeader = T,
          br(),
          # informasi 1
          withMathJax(
            includeMarkdown(
              path = "teks/metodologi1.Rmd"
            )
          ),
          # alur pembuatan
          box(
            width = 12,
            title = "Alur Pembuatan Indeks",
            icon = icon("gears"),
            status = "info",
            solidHeader = T,
            collapsed = T,
            withMathJax(
              includeMarkdown(
                path = "teks/metodologi_penyusunan.Rmd"
              )
            )
          ),
          # lanjutan 2
          withMathJax(
            includeMarkdown(
              path = "teks/metodologi2.Rmd"
            )
          ),
          # buat tabset untuk setiap domain
          tabsetPanel(
            id = "metodologi_domain",
            # buat menjadi horizontal
            vertical = F,
            # tab panel untuk domain environment
            tabPanel(
              title = "1. Domain Environment",
              icon = icon("seedling"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain1.Rmd"
                )
              )
            ),
            # tab panel untuk domain income
            tabPanel(
              title = "2. Domain Income",
              icon = icon("money-bill-wave"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain2.Rmd"
                )
              )
            ),
            # tab panel untuk domain housing
            tabPanel(
              title = "3. Domain Housing",
              icon = icon("house-chimney"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain3.Rmd"
                )
              )
            ),
            # tab panel untuk domain work
            tabPanel(
              title = "4. Domain Work",
              icon = icon("briefcase"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain4.Rmd"
                )
              )
            ),
            # tab panel untuk domain health
            tabPanel(
              title = "5. Domain health",
              icon = icon("notes-medical"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain5.Rmd"
                )
              )
            ),
            # tab panel untuk domain Education
            tabPanel(
              title = "6. Domain Education",
              icon = icon("graduation-cap"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain6.Rmd"
                )
              )
            ),
            # tab panel untuk domain Social Security
            tabPanel(
              title = "7. Domain Social Security",
              icon = icon("handshake"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain7.Rmd"
                )
              )
            ),
            # tab panel untuk domain Subjective Well Being
            tabPanel(
              title = "8. Domain Subjective Well Being",
              icon = icon("face-laugh-beam"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain8.Rmd"
                )
              )
            ),
            # tab panel untuk domain Democratic Engagement
            tabPanel(
              title = "9. Domain Democratic Engagement",
              icon = icon("landmark"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain9.Rmd"
                )
              )
            ),
            # tab panel untuk domain Safety
            tabPanel(
              title = "10. Domain Safety",
              icon = icon("user-shield"),
              withMathJax(
                includeMarkdown(
                  path = "teks/metodologi_domain10.Rmd"
                )
              )
            )
          ),
          br(),
          br(),
          # box referensi
          box(
            width = 12,
            title = "Referensi",
            icon = icon("book"),
            status = "success",
            background = "white",
            solidHeader = T,
            collapsed = T,
            br(),
            tags$iframe(
              src = "metodologi_referensi.html",
              width = '100%',
              height = 400,
              style = "border:none;"
            )
          )
        )
      ),
      
      # tab plot line
      bs4TabItem(
        tabName = "line",
        # buat dalam bentuk kiri kanan
        sidebarLayout(
          sidebarPanel = sidebarPanel(
            width = 3,
            box(title = "Atur Plot",
                width = 12,
                icon = icon("tools"),
                status = "teal",
                solidHeader = T,
                # pilihan pembobot indeks
                checkboxGroupInput(
                  inputId = "line_indikator",
                  label = "Pilih Pembobot Indikator",
                  choices = c("IW equal domain",
                              "IW equal indikator"),
                  selected = c("IW equal domain",
                               "IW equal indikator")),
                # pilihan tahun indeks
                sliderInput(
                  inputId = "line_tahun",
                  label = "Pilih Tahun",
                  min = 2010,
                  round = T,
                  ticks = F,
                  step = 1,
                  max = 2021,
                  value = c(2010, 2021)),
                # pilihan wilayah indeks
                selectInput(
                  inputId = "line_provinsi",
                  label = "Pilih Wilayah",
                  choices = vector_prov,
                  multiple = T,
                  selected = "INDONESIA"
                )
              )
          ),
          mainPanel = mainPanel(
            br(),
            plotlyOutput(
              "plot_line"
            )
          )
        ),
        
        # space
        br(),
        br(),
        
        # box interpretasi
        box(
          title = "Insight From Data",
          icon = icon("magnifying-glass"),
          status = "info",
          solidHeader = T,
          width = 12,
          br(),
          # interpretasi
          withMathJax(
            includeMarkdown(
              path = "teks/insight_line.Rmd"
            )
          )
        )
      ),
      
      # tab plot bar
      bs4TabItem(
        tabName = "bar",
        # buat dalam bentuk kiri kanan
        sidebarLayout(
          sidebarPanel = sidebarPanel(
            width = 3,
            box(title = "Atur Plot",
                width = 12,
                icon = icon("tools"),
                status = "teal",
                solidHeader = T,
                # pilihan pembobot indeks
                checkboxGroupInput(
                  inputId = "bar_indikator",
                  label = "Pilih Pembobot Indikator",
                  choices = c("IW equal domain",
                              "IW equal indikator"),
                  selected = c("IW equal domain",
                               "IW equal indikator")),
                # tampilkan terbesar ke terkecil atau sebaliknya
                selectInput(
                  inputId = "bar_urut",
                  label = "Pilih Urutan Bar",
                  choices = c("Ascending", "Descending"),
                  selected = "Descending"),
                # pilihan tahun indeks
                selectInput(
                  inputId = "bar_tahun",
                  label = "Pilih Tahun",
                  choices = seq(2010, 2021, 1),
                  selected = 2021)
            )
          ),
          mainPanel = mainPanel(
            br(),
            plotlyOutput(
              "plot_bar"
            )
          )
        ),
        
        # space
        br(),
        br(),
        
        box(
          title = "Insight From Data",
          icon = icon("magnifying-glass"),
          status = "info",
          solidHeader = T,
          width = 12,
          br(),
          # interpretasi
          withMathJax(
            includeMarkdown(
              path = "teks/insight_bar.Rmd"
            )
          )
        )
      ),
      
      # tab plot radar
      bs4TabItem(
        tabName = "radar",
        # buat dalam bentuk kiri kanan
        sidebarLayout(
          sidebarPanel = sidebarPanel(
            width = 3,
            box(title = "Atur Plot",
                width = 12,
                icon = icon("tools"),
                status = "teal",
                solidHeader = T,
                # pilih tahun
                selectInput(
                  inputId = "radar_tahun",
                  label = "Pilih Tahun Radar Chart",
                  choices = seq(2010, 2021, 1),
                  selected = 2021,
                  multiple = T
                ),
                # pilih wilayah
                selectInput(
                  inputId = "radar_provinsi",
                  label = "Pilih Wilayah",
                  choices = vector_prov,
                  multiple = T,
                  selected = "INDONESIA"
                )
            )
          ),
          mainPanel = mainPanel(
            br(),
            plotlyOutput(
              "plot_radar"
            )
          )
        ),
        
        # space
        br(),
        br(),
        
        box(
          title = "Insight From Data",
          icon = icon("magnifying-glass"),
          status = "info",
          solidHeader = T,
          width = 12,
          br(),
          # interpretasi
          withMathJax(
            includeMarkdown(
              path = "teks/insight_radar.Rmd"
            )
          )
        )
      ),
      
      # tab plot map
      bs4TabItem(
        tabName = "map",
        # buat dalam bentuk kiri kanan
        sidebarLayout(
          sidebarPanel = sidebarPanel(
            width = 3,
            box(title = "Atur Plot",
                width = 12,
                icon = icon("tools"),
                status = "teal",
                solidHeader = T,
                # pilih pembobot untuk peta
                radioButtons(
                  inputId = "map_weight",
                  label = "Pilih Pembobot",
                  choices = c("Equal Domain",
                              "Equal Indikator"),
                  selected = "Equal Domain"
                ),
                # pilih tahun untuk peta
                selectInput(
                  inputId = "map_tahun",
                  label = "Pilih Tahun",
                  choices = seq(2010, 2021, 1),
                  selected = 2021)
            )
          ),
          mainPanel = mainPanel(
            br(),
            plotOutput(
              "plot_map"
            )
          )
        ),
        
        # space
        br(),
        br(),
        
        box(
          title = "Insight From Data",
          icon = icon("magnifying-glass"),
          status = "info",
          solidHeader = T,
          width = 12,
          br(),
          # interpretasi
          withMathJax(
            includeMarkdown(
              path = "teks/insight_map.Rmd"
            )
          )
        )
      )
    )
  )
)