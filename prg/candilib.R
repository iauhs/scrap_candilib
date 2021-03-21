# devtools::install_github("ropensci/RSelenium")

library(emayili)
library(dplyr)
library(curl)
library(RSelenium)
library(stringi)
library(XML)
require(httr)
library(dplyr)
library(xml2)

# help(emayili)

# driver<- rsDriver()
# remDr <- driver[["client"]]

# remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
#                                  port =4446L,
#                                  browserName = "chrome")
# startServer()

url = "https://beta.interieur.gouv.fr/candilib/candidat?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlMzA1ZTZjOTU5ZDAwMDAxMDMzYjk5MCIsImxldmVsIjowLCJpYXQiOjE1OTc4MjM2NjgsImV4cCI6MTU5ODA4Mjg2OH0.Gvk22hJ5Tqk6nFwmUhh1Omlkl7K923pjmwO7TUj-vGw"
# https://beta.interieur.gouv.fr/candilib/candidat?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlMzA1ZTZjOTU5ZDAwMDAxMDMzYjk5MCIsImxldmVsIjowLCJpYXQiOjE1OTEzMzM4NzAsImV4cCI6MTU5MTU5MzA3MH0.1BNHPbYISlsE3vbu72W8OGw1xEBNPoSDIZEDUhScQFo

RSelenium::checkForServer()
# docker pull selenium/standalone-chrome

# system('docker pull selenium/standalone-chrome')
system('docker run -d -p 4445:4444 selenium/standalone-chrome') # let docker run a chrome with the port 4445
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445L, browserName = "chrome")

# system('docker pull selenium/standalone-firefox')
# system('docker run -d -p 4447:4446 selenium/standalone-firefox')
# remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4447L) #, browserName = "firefox") remoteServerAddr = "192.168.1.255", 

Sys.sleep(10)

remDr$open()
remDr$navigate(url)


for(i in 1:2000){
  tryCatch({
    # Sys.sleep(rnorm(1, 50, 5))
    remDr$refresh()
    Sys.sleep(abs(rnorm(1, 2, .2)))
    remDr$getStatus()
    #Entering our URL gets the browser to navigate to the page
    remDr$getTitle()
    remDr$maxWindowSize()
    # remDr$setWindowPosition(x=2, y=0)
    
    remDr$screenshot(file = paste0('screenshot/test', i, '.png'), display = FALSE, useViewer = F) 
    #display = FALSE ,  file = paste0('screenshot/test', i, '.png')) :  
    # the screenshot is written to the file denoted by file
    #This will take a screenshot and display it in the RStudio viewer
    # Sys.sleep(rnorm(1, 200, 10))
    
    # /html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[5]/div/div/div[1]/text()
    state_92 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
      rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[5]/div/div/div[1]/text()') %>%
      rvest::html_text() %>% 
      stringr::str_replace_all("\n", "") %>% 
      stringr::str_replace_all(" ", "") %>% 
      stringr::str_match('[:digit:]') %>% 
      as.integer()
    
    # state_95 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
    #   rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[2]/div/div/div[1]/text()') %>%
    #   rvest::html_text() %>% 
    #   stringr::str_replace_all("\n", "") %>% 
    #   stringr::str_replace_all(" ", "") %>% 
    #   stringr::str_match('[:digit:]') %>% 
    #   as.integer()
    # 
    # state_93 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
    #   rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[3]/div/div/div[1]/text()') %>%
    #   rvest::html_text() %>% 
    #   stringr::str_replace_all("\n", "") %>% 
    #   stringr::str_replace_all(" ", "") %>% 
    #   stringr::str_match('[:digit:]') %>% 
    #   as.integer()
    # 
    # state_94 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
    #   rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[6]/div/div/div[1]/text()') %>%
    #   rvest::html_text() %>% 
    #   stringr::str_replace_all("\n", "") %>% 
    #   stringr::str_replace_all(" ", "") %>% 
    #   stringr::str_match('[:digit:]') %>% 
    #   as.integer()
    # 
    # state_78 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
    #   rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[7]/div/div/div[1]/text()') %>%
    #   rvest::html_text() %>% 
    #   stringr::str_replace_all("\n", "") %>% 
    #   stringr::str_replace_all(" ", "") %>% 
    #   stringr::str_match('[:digit:]') %>% 
    #   as.integer()
    # 
    # state_91 <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
    #   rvest::html_nodes(xpath = '/html/body/div/div[1]/main/div/div[2]/div/div[2]/div/div/div/div/div/div[8]/div/div/div[1]/text()') %>%
    #   rvest::html_text() %>% 
    #   stringr::str_replace_all("\n", "") %>% 
    #   stringr::str_replace_all(" ", "") %>% 
    #   stringr::str_match('[:digit:]') %>% 
    #   as.integer()
     
    state = state_92 # state_78+state_91+state_93+state_94+state_95+
    print(paste(Sys.time(), ":", 
                # state_78, state_91, 
                state_92
                #, state_93, state_94, state_95
                )
          )
    if(state > 0){
        email <- envelope() %>%
          from("pascal.ws@gmail.com") %>%
          to(c("shuai2wang@gmail.com")) %>%
          subject(paste0("give a try : ", paste(Sys.time(), ":",state_92))) %>% 
          text(paste("Hello! Please check : ", 
                      url, "at", Sys.time(), " les departement : ",
                      state_92))
        
        smtp <- server(host = "smtp.gmail.com",
                       port = 465,
                       username = "pascal.ws@gmail.com",
                       password = "************")
        smtp(email, verbose = TRUE)
      }
    Sys.sleep(rnorm(1, 49, 2))
    
    print("next try !!!")
    },
    error=function(err){
      
      print (err)
      email <- envelope() %>%
        from("pascal.ws@gmail.com") %>%
        # to("shuai2wang@gmail.com") %>%
        to("shuai.wang@axa-direct.com") %>%
        subject(paste0("give a try for the candilib : ", url)) %>% 
        text(paste0("There is a bug, you need to change the url : \n", 
                    url))
      
      smtp <- server(host = "smtp.gmail.com",
                     port = 465,
                     username = "pascal.ws@gmail.com",
                     password = "**********")
      smtp(email, verbose = TRUE)
      Sys.sleep(rnorm(1, 360, 10))
      
    }, # Optional Second Block
    warning=function(w) {
      # (Optional)
      # Do this if an warning is caught... # return(NULL)
    },
    finally = {
      Sys.sleep(rnorm(1, 1, 0.01))
      # NOTE:
      # (Optional)
      # Do this at the end before quitting the tryCatch structure...
      # print(paste("state_GENNEVILLIERS : ", state_GENNEVILLIERS))
    }
  )
}

remDr$close()

remDr$server$stop()

rm(remDr)
gc()
