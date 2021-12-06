#' Geoserver REST API DataStore
#'
#' @docType class
#' @importFrom R6 R6Class
#' @export
#' @keywords geoserver monitoring
#' @return Object of \code{\link{R6Class}} for setting a GS Shiny monitoring app
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(manager, sleep)}}{
#'    This method is used to instantiate a R shiny monitoring app for a Geoserver 
#'  }
#' }
#' 
#' @note Internal class used for \code{GSManager$monitor} method
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
GSShinyMonitor <- R6Class("GSShinyMonitor",
  private = list(
    manager = NULL,
    gs_url = NULL,
    monitor_file = NULL,
    sleep = 1,
    status_metrics = NULL,
    #shiny monitor ui
    monitor_ui = function(id){
      
      shiny::fluidPage(
        shinyWidgets::useShinydashboard(),
        h3(tags$a(tags$img(src = sprintf("%s/web/wicket/resource/org.geoserver.web.GeoServerBasePage/img/logo.png", private$gs_url), alt="logo"), href = private$gs_url, target = "_blank"),
           "GeoServer system status", tags$small(" powered by 'geosapi' R package")),
        hr(),
        shiny::fluidRow(
          shinydashboard::box(
            width = 6,
            title = "GeoServer identification",
            tags$ul(
              tags$li("URL: ", tags$b(tags$a(private$gs_url, href = private$gs_url, target = "_blank")))
            )                    
          ),
          shinydashboard::box(
            width = 6,
            title = "System identification",
            uiOutput("system_metrics")
          )
        ),
        shiny::fluidRow(
          shinydashboard::box(
            width = 12, title = "Monitoring",
            shinyWidgets::verticalTabsetPanel(
              id = "monitoring",
              shinyWidgets::verticalTabPanel(
                title = "CPU Usage", icon = icon("line-chart"),
                tags$div(
                  class = "row",
                  style = "padding:5px",
                  tags$div(class = "col-md-4", uiOutput("monitor_cpu_info")),
                  tags$div(class = "col-md-6", plotly::plotlyOutput("monitor_cpu_load"))
                )
              ),
              shinyWidgets::verticalTabPanel(
                title = "Data", icon = icon("table"),
                tags$div(DT::dataTableOutput("monitor_data"), style = "font-size:75%;overflow-x:scroll;")
              )
            )
          )
        )
      )
    },
    
    #shiny monitor server
    monitor_server = function(input, output, session) {

      monitoring <- reactivePoll(private$sleep*1000, session,
       checkFunc = function() {
         
         status <- private$manager$getSystemStatus()
         readr::write_csv(status$values, path = private$monitor_file, append = TRUE)
         
         output$system_metrics <- renderUI({
           system_metrics_df <- status$raw[status$raw$category == "SYSTEM",]
           tags$ul(
             shiny::tagList(
               lapply(1:nrow(system_metrics_df), function(i){
                 tags$li(paste0(system_metrics_df[i,]$description,": "), tags$b(system_metrics_df[i,]$value))
              })
             )
           )
         })
         
         if (file.exists(private$monitor_file)){
           file.info(private$monitor_file)$mtime[1]
         }else{
           ""
         }
       },
       valueFunc = function() {
         readr::read_csv(private$monitor_file)
       }
      )
      
      #monitor data
      require(DT)
      output$monitor_data <- renderDataTable(
        monitoring(),
        server = FALSE,
        escape = FALSE,
        rownames = FALSE,
        extensions = c("Buttons"),
        filter = list(position = 'top', clear = FALSE),
        
        options = list(
          autoWidth = FALSE,
          dom = 'Bfrtip',
          deferRender = TRUE,
          scroll = FALSE,
          buttons = list(
            list(extend = 'copy'),
            list(extend = 'csv', filename =  "geoserver_monitoring", title = NULL, header = TRUE),
            list(extend = 'excel', filename =  "geoserver_monitoring", title = NULL, header = TRUE),
            list(extend = "pdf", title = "Geoserver monitoring", header = TRUE, orientation = "landscape")
          ),
          exportOptions = list(
            modifiers = list(page = "all", selected = TRUE)
          ),
          
          pageLength = 10
        )
      )
      
      #cpu characteristics
      output$monitor_cpu_info <- renderUI({
        physical_cpus <- self$getMetric("PHYSICAL_CPUS")
        logical_cpus <- self$getMetric("LOGICAL_CPUS")
        running_process <- self$getMetric("RUNNING_PROCESS")
        running_threads <- self$getMetric("RUNNING_THREADS")
        tags$div(
          h4("CPU characteristics"), hr(),
          tags$ul(
            tags$li(paste0(physical_cpus$description,": "), tags$b(physical_cpus$value)),
            tags$li(paste0(logical_cpus$description,": "), tags$b(logical_cpus$value)),
            tags$li(paste0(running_process$description,": "), tags$b(running_process$value)),
            tags$li(paste0(running_threads$description,": "), tags$b(running_threads$value))
          )
        )
        
      })
      
      #monitor cpu load
      require(plotly)
      output$monitor_cpu_load <- renderPlotly({
        data = monitoring()
        p = plot_ly(data = data)
        p = p %>% add_lines(x=~ TIME, y = ~ CPU_LOAD, color = I("black"), name = self$getMetric("CPU_LOAD")$description, text = ~sprintf("%s %s",round(CPU_LOAD,2), self$getMetric("CPU_LOAD")$unit))
        logical_cpus <- data[,colnames(data)[startsWith(colnames(data), "CPU ")]]
        logical_cpu_names = names(logical_cpus)
        for(i in 1:length(logical_cpu_names)){
          dfk <- data.frame(y= data[[logical_cpu_names[i]]], TIME = data$TIME)
          p = p %>% add_trace(x= ~TIME, y = ~y, data = dfk, name = self$getMetric("PER_CPU_LOAD")[i,]$description, 
                              type = "scatter", mode = "lines",
                              text = ~sprintf("%s %s",round(y,2), self$getMetric("PER_CPU_LOAD")[i,]$unit))
        }
        p %>% layout(
          showlegend=T,
          hovermode ='closest',
          xaxis = list(
            titlefont = list(size = 10), 
            tickfont = list(size = 10),
            title = "TIME",
            zeroline = F
          ),
          yaxis = list(
            titlefont = list(size = 10), 
            tickfont = list(size = 10),
            title = "CPU LOAD (%s)",
            zeroline = F
          )
        )
      })
      
    }
    
  ),
  public = list(
    initialize = function(manager, file = NULL, append = FALSE, sleep = 1){
      monitor_file <- file
      if(is.null(file)){
        monitor_file <- tempfile( fileext = ".csv")
        append <- FALSE
      }
      private$monitor_file <- monitor_file
      private$sleep <- sleep
      private$manager <- manager
      private$gs_url <- unlist(strsplit(private$manager$getUrl(), "/rest"))[1]
      
      status <- private$manager$getSystemStatus()
      readr::write_csv(status$values, path = monitor_file, append = append)
      private$status_metrics <- status$raw[,c("name", "description", "unit", "value")]
      
      requireNamespace("magrittr")
      requireNamespace("shiny")
      requireNamespace("shinydashboard")
      requireNamespace("shinyWidgets")
      requireNamespace("DT")
      requireNamespace("plotly")
    },
    
    #getMetric
    getMetric = function(name){
      return(private$status_metrics[private$status_metrics$name == name,])
    },
    
    #run
    run = function(){
      shiny::shinyApp(ui = private$monitor_ui, server = private$monitor_server)
    }
 )                     
)
