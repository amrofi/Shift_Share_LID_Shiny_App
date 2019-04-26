require(shiny)
require(googleVis)
require(dplyr)
require(reshape2)
require(tidyr)
require(plm)


#setwd("~/Dropbox/Phd Illinois/Work with Pedro/Shiny/Shift Share/shift_share/shift_share_v2/")
#load("~/Dropbox/Phd\ Illinois/Work\ with\ Pedro/Shiny/Shift\ Share/shift_share/shift_share_v2/Shift_Share_Data_Prov_2017.Rda")
load("Shift_Share_Data_Prov_2019.Rda")








shinyServer(function(input, output) {

  ################################################################################################################################################
  ################################################################################################################################################
  ###################                          Indicador De Generacion de Empleo Regional                           ##############################
  ################################################################################################################################################
  ################################################################################################################################################
  pr_index_provincias<-reactive({
    provincia<-PR_index %>% filter(Provincia%in%input$provincia_pr, date>=input$trim_init_viz) %>% ungroup()#lubridate::ymd("2015-01-01")) %>% ungroup()
    provincia<-spread(provincia,Provincia,PR)

    provincia<-data.frame(provincia[order(provincia$date),])
    return(provincia)
  })

  output$linePR <- renderGvis({
    gvisLineChart(pr_index_provincias(),
                 options=list(height=700, width=1000,  vAxes="[{textPosition: 'in'}]", legend="bottom"))
                 #options=list( width=900,  vAxes="[{textPosition: 'in'}]", legend="bottom"))
  })

  ################################################################################################################################################
  ################################################################################################################################################
  ###################                          Shift Share Bars x Provincias                                        ##############################
  ################################################################################################################################################
  ################################################################################################################################################

  data_bars_provincias<-reactive({
    # input<-data.frame(sector="A")
    # input$sector<-"pesca"
    # input$provincia<-"CABA"
    # input$provincia_pr<-"CABA"
    # input$trim_init<-"1 Trim 2014"
    # input$trim_fin<-"1 Trim 2015"
    Eit <-dta3 %>% group_by(Act) %>% summarise_if(is.numeric, sum, na.rm = TRUE) %>% ungroup()
    dta <- dta3 %>% dplyr::select(Provincia, Act, input$trim_init,input$trim_fin)
    Eit <- Eit %>% dplyr::select(Act, input$trim_init,input$trim_fin)
    colnames(Eit)<-c("Act","Eit_1","Eit")
    Eit<-Eit %>% mutate(Var_ind=Eit/Eit_1)

    eit<-dta %>% filter(Act!="Total Nacional")
    eit$var_provincia<- eit[,4]/eit[,3]
    eit$var_provincia[eit$var_provincia=="NaN"]<-NA
    eit$var_provincia[eit$var_provincia=="Inf"]<-NA

    PR<-left_join(eit,Eit)
    PR<- PR %>% mutate(PR=(var_provincia-Var_ind)*100)

    PR_sector<- PR %>% filter(Act==input$sector)

    colnames(PR_sector)[colnames(PR_sector)=="PR"]<-paste0("Cambio % en el empleo del ", input$sector," respecto al cambio % nacional en el sector")
    return(PR_sector)

})


  output$barPR <- renderGvis({
    gvisBarChart(data_bars_provincias(),
                 xvar="Provincia",
                 yvar=paste0("Cambio % en el empleo del ", input$sector," respecto al cambio % nacional en el sector"),
                 options=list(width=500, height=700,colors="['#3FAD46']",  vAxes="[{textPosition: 'in'}]", legend="bottom"))
  })
  
dta_map<-reactive({
    # input<-data.frame(sector="A")
    # input$sector<-"agro"
    # input$provincia<-"CABA"
    # input$trim_init<-"1 Trim 2014"
    # input$trim_fin<-"1 Trim 2015"
    Eit <-dta3 %>% group_by(Act) %>% summarise_if(is.numeric, sum, na.rm = TRUE) %>% ungroup()
    dta <- dta3 %>% dplyr::select(code,Prov, Act, input$trim_init,input$trim_fin)
    colnames(dta)<-c("code","Prov","Act","Eit_1","Eit")
    dta <- dta %>% group_by(code,Prov,Act) %>%  dplyr::summarise(Eit_1=sum(Eit_1),Eit=sum(Eit)) %>% ungroup()
    Eit <- Eit %>% dplyr::select(Act, input$trim_init,input$trim_fin) %>% ungroup()
    colnames(Eit)<-c("Act","Eit_1","Eit")
    Eit<-Eit %>% mutate(Var_ind=Eit/Eit_1) %>% ungroup()
    
    eit<-dta %>% filter(Act!="Total Nacional")
    eit<- eit %>%  mutate(var_provincia=Eit/Eit_1)
    eit$var_provincia[eit$var_provincia=="NaN"]<-NA
    eit$var_provincia[eit$var_provincia=="Inf"]<-NA
    
    PR<-left_join(eit,Eit)
    PR<- PR %>% mutate(PR=(var_provincia-Var_ind)*100)
    
    PR_sector<- PR %>% filter(Act==input$sector)
    
    colnames(PR_sector)[colnames(PR_sector)=="PR"]<-paste0("Cambio % en el empleo del ", input$sector," respecto al cambio % nacional en el sector")
    return(PR_sector)
    
  })
  


output$mapa <- renderGvis({
  gvisGeoChart(dta_map(), locationvar="code", colorvar="var_provincia", hovervar="Prov", options=list(region="AR", displayMode="region", resolution="provinces", width=500, height=400))  
})


################################################################################################################################################
################################################################################################################################################
###################                          Shift Share                                        ##############################
################################################################################################################################################
################################################################################################################################################

E_tot_nac<-dta3  %>% filter(dta3$Act=="Total Nacional")
E_tot_nac<-data.frame(t(apply(E_tot_nac[5:dim(E_tot_nac)[2]],2,sum, na.rm=T)))
colnames(E_tot_nac)<-colnames(dta3[5:dim(dta3)[2]])


data_shift<-reactive({
  # input<-data.frame(sector="A")
  # input$sector<-"agro"
  # input$prov_shift_share<-"CABA"
  # input$trim_init<-"1 Trim 2014"
  # input$trim_fin<-"1 Trim 2015"

  
  Eit_tot<-dta3[dta3$Act==input$sector,]
  Eit_tot<-data.frame(t(apply(Eit_tot[5:dim(Eit_tot)[2]],2,sum, na.rm=T)))
  colnames(Eit_tot)<-colnames(dta3[5:dim(dta3)[2]])
  
  
  et_tot<-dta3[dta3$Provincia==input$prov_shift_share & dta3$Act==input$sector,]
  et_tot<-data.frame(t(apply(et_tot[5:dim(et_tot)[2]],2,sum, na.rm=T)))
  colnames(et_tot)<-colnames(dta3[5:dim(dta3)[2]])
  
  db<-rbind(et_tot,Eit_tot,E_tot_nac)
  provincia<-input$prov_shift_share
  Act<-tolower(input$sector)
  db$name<-NA
  db$name[1]<-paste("Empleo en",provincia,"en",Act, sep=" ")
  db$name[2]<-paste("Empleo en", Act, sep=" ")
  db$name[3]<-paste("Empleo total nacional")
  
  db<-db[,c("name",input$trim_init,input$trim_fin)]
  
  NS<-db[1,input$trim_init]*((db[3,input$trim_fin]-db[3,input$trim_init])/db[3,input$trim_init])
  IM<-db[1,input$trim_init]*((db[2,input$trim_fin]/db[2,input$trim_init])-(db[3,input$trim_fin]/db[3,input$trim_init]))
  RS<-db[1,input$trim_init]*((db[1,input$trim_fin]/db[1,input$trim_init])-(db[2,input$trim_fin]/db[2,input$trim_init]))
  
  #db[1,input$trim_fin]==round((db[1,input$trim_init]+db$NS+db$IM+db$RS)[1])
  
  Total<-NS+IM+RS
  
  #DF for plot
  a<-round(data.frame(NS,IM,RS,Total),2)
  a<-data.frame(t(a))
  a$Componente<-c("Efecto Nacional","Cambio en la Industria","Efecto Provincial","Efecto Neto en los Empleos")
  colnames(a)<-c("Cambio en el Empleo","Componente")
  
  
  a<-droplevels(a)
  return(a)
  
})

output$shift_share <- renderGvis({
  gvisBarChart(data_shift(),xvar="Componente",yvar="Cambio en el Empleo", options=list(width=700, height=600,colors="['#3FAD46']",  vAxes="[{textPosition: 'in'}]"))
})
################################################################################################################################################
################################################################################################################################################
###################                                     Download_data                            ##############################
################################################################################################################################################
################################################################################################################################################
  #Donwload_data
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data_empleo.csv", sep="_")
    },
    content = function(file) {
      write.csv(dta3, file)
    }
  )

#  plot( gvisLineChart(data_4,  options=list(hAxes="[{title:'Trimestre',textPosition: 'out'}]", vAxes="[{title:'Cambio en el Empleo',textPosition: 'out'}]",width=1000, height=500)))







}) #close server.R








