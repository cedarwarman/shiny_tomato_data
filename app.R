library(shiny)
library(readxl)
library(bslib)
library(DT)
library(shinythemes)
library(ggplot2)
library(plotly)

# Loading the accession metadata
accessions <- read_excel(file.path(getwd(), "data", "accessions.xlsx"))

# Loading the flower measurements for the flower plot
flower_measurements <- read.table(file.path(getwd(), "data", "flower_measurements.tsv"),
                                  header = TRUE)


# Functions ---------------------------------------------------------------
make_flower_plot <- function(plot_type, flower_df, row_selection) {
  # Current bug 2022-09-20: if you click on a row that has no anther/pistil 
  # lengths, then everything turns pink (e.g. CW1006).
  if (plot_type == "ratio") {   
    if (length(row_selection)) {
      # Making new column for if it's selected or not
      selected_accessions <- accessions$name_CW[row_selection]
      flower_df$row_selected <- NA
      flower_df$row_selected[flower_df$accession_id %in% selected_accessions] <- "selected"
      flower_df$row_selected[is.na(flower_df$row_selected)] <- "not_selected"
      
      # Making the plot 
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$anther_over_pistil, median),
                             y = ~anther_over_pistil,
                             color = ~row_selected,
                             colors = c("white", "magenta"),
                             type = "box",
                             line = list(width = 1),
                             marker = list(size = 3))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Anther and pistil lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Ratio of AL / PL",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(0.6, 1.4),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30),
                                            showlegend = F)
      
    } else {
      # Making the plot
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$anther_over_pistil, median),
                             y = ~anther_over_pistil,
                             type = "box",
                             fillcolor = "#838383",
                             line = list(width = 1,
                                         color = "#ffffff"),
                             marker = list(size = 3,
                                           color = "#ffffff"))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Anther and pistil lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Ratio of AL / PL",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(0.6, 1.4),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30))
    }
  } else if (plot_type == "anther") {
    if (length(row_selection)) {
      # Making new column for if it's selected or not
      selected_accessions <- accessions$name_CW[row_selection]
      flower_df$row_selected <- NA
      flower_df$row_selected[flower_df$accession_id %in% selected_accessions] <- "selected"
      flower_df$row_selected[is.na(flower_df$row_selected)] <- "not_selected"
      
      # Making the plot 
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$anther_length, median),
                             y = ~anther_length,
                             color = ~row_selected,
                             colors = c("white", "magenta"),
                             type = "box",
                             line = list(width = 1),
                             marker = list(size = 3))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Anther lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Anther length (mm)",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(5, 13),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30),
                                            showlegend = F)
    } else {
      # Making the plot
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$anther_length, median),
                             y = ~anther_length,
                             type = "box",
                             fillcolor = "#838383",
                             line = list(width = 1,
                                         color = "#ffffff"),
                             marker = list(size = 3,
                                           color = "#ffffff"))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Anther lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Anther length (mm)",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(5, 13),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30))
    }
  } else {
    if (length(row_selection)) {
      # Making new column for if it's selected or not
      selected_accessions <- accessions$name_CW[row_selection]
      flower_df$row_selected <- NA
      flower_df$row_selected[flower_df$accession_id %in% selected_accessions] <- "selected"
      flower_df$row_selected[is.na(flower_df$row_selected)] <- "not_selected"
      
      # Making the plot 
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$pistil_length, median),
                             y = ~pistil_length,
                             color = ~row_selected,
                             colors = c("white", "magenta"),
                             type = "box",
                             line = list(width = 1),
                             marker = list(size = 3))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Pistil lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Pistil length (mm)",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(5, 13),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30),
                                            showlegend = F)
      
    } else {
      # Making the plot
      output_plot <- plot_ly(data = flower_df,
                             x = reorder(flower_df$accession_id, flower_df$pistil_length, median),
                             y = ~pistil_length,
                             type = "box",
                             fillcolor = "#838383",
                             line = list(width = 1,
                                         color = "#ffffff"),
                             marker = list(size = 3,
                                           color = "#ffffff"))
      
      # Adding aesthetics
      output_plot <- output_plot %>% layout(title = list(text = "Pistil lengths by accession",
                                                         font = list(size = 22)),
                                            xaxis = list(title = F,
                                                         showline = T,
                                                         showticklabels = F,
                                                         linewidth = 1,
                                                         linecolor = "white"),
                                            yaxis = list(title = list(text = "Pistil length (mm)",
                                                                      font = list(size = 16),
                                                                      standoff = 0),
                                                         range = list(5, 13),
                                                         showline = T,
                                                         showgrid = F,
                                                         linewidth = 1,
                                                         linecolor = "white",
                                                         tickfont = list(size = 10)),
                                            font = list(family = "Arial Black",
                                                        color = "white"),
                                            paper_bgcolor = "#060606",
                                            plot_bgcolor = "#060606",
                                            margin = list(t = 50, r = 30)) 
    }
  }
  
  # Removing toolbar
  output_plot <- output_plot %>% config(displayModeBar = F)
  
  return(output_plot)
}

ui <- bootstrapPage(
  theme  = bs_theme(version = 5,
                    bootswatch = 'cyborg',
                    primary = '#f542e3'),
  tags$style(type='text/css',
             ".table.dataTable tbody tr.active td { background-color: #f542e3 ; }
             table.dataTable { border-collapse: collapse !important; }
             .recalculating {opacity: 1.0; }"),
  tags$head(tags$link(rel = "shortcut icon", href = "favicon.ico")),
  
  div(class = "container-fluid",
    # div(class = "row justify-content-center",
    #   align = "center",
    #   div(class = "col-xl-1",
    #     checkboxInput("show_columns", "Show all columns", value = FALSE)
    #   )
    # ),
    div(class = "row justify-content-center",
      align = "center",
      div(class = "col-xl",
        h1(strong("Pollen metadata"))
      )
    ),
    div(class = "row justify-content-center",
      align = "center",
      div(class = "col-xl-6",
        # DTOutput("accessions_table", width = "100%")
        DTOutput("accessions_table")
      ),
      div(class = "col-xl-6",
        plotlyOutput("ratio_plot", height = "30vh"),
        plotlyOutput("anther_plot", height = "30vh"),
        plotlyOutput("pistil_plot", height = "30vh")
      )
    )
  )  
)

# ui <- fluidPage(
#   dataTableOutput("accessions_table")
# )

server <- function(input, output, session) {
  output$accessions_table <- renderDT(
    accessions, 
    style = "bootstrap",
    options = list(
      scrollX = TRUE,
      scrollY = "80vh",
      pageLength = 500,
      fixedHeader = TRUE, 
      dom = "ft",
      columnDefs = list(
        list(
          visible = FALSE, targets = c(3:4, 6:13, 15:18, 20:26, 32:46)
        )
      )
      # autoWidth = TRUE,
      # info = FALSE
   ))
   
  output$ratio_plot <- renderPlotly({
    # make_flower_plot("ratio", flower_measurements, input$accessions_table_rows_selected)
    # make_plotly_flower_plot(flower_measurements)
    make_flower_plot("ratio", flower_measurements, input$accessions_table_rows_selected)
  })
 
  output$anther_plot <- renderPlotly({
    make_flower_plot("anther", flower_measurements, input$accessions_table_rows_selected)
  })

  output$pistil_plot <- renderPlotly({
    make_flower_plot("pistil", flower_measurements, input$accessions_table_rows_selected)
  })
  
}

shinyApp(ui, server)