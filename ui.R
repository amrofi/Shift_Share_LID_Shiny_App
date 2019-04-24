require(shiny)

#Color green: rgb(63, 173, 70)
#
fluidPage(
  # Application title
  title="Shift-Share LiD",  theme="theme.css",
 withMathJax(),
  fluidRow(
     column(12,
        tags$head(
          tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
          tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript'),
        tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config'),
          tags$style(type="text/css", "select"),
          tags$style(type="text/css", ".span4"),
          tags$style(type="text/css",  ".well {background-color: #3FAD46:
                     ; }")),
          tags$div(class="header", checked=NA,
               h1("Análisis de Variación y Participación del Empleo Privado"),
               tags$h4(tags$em(tags$a(href="http://lid.maimonides.edu", 'LiD. Universidad Maimonides')), align="right")
               ),
        hr(),
          HTML("
<br>
<br>

    <p>La evolución del empleo constituye un termómetro esencial para el seguimiento del desenvolvimiento de la economía nacional, provincial y sectorial.</p>
<p> El analisis de variación y participación (<i>shift-share</i>) produce resultados que permiten diagnosticar, describir y entender las principales diferencias entre los patrones de crecimiento del empleo formal sectorial distinguiendo patrones provinciales y nacionales. </p>
    <p>En la presente página es posible analizar la evolución del empleo privado registrado (<i>formal</i>). A traves de 3 modulos</p>
        <ol type='1'>
                <li>Indicador de Generación de Empleo Regional</li>
               <li>Evolución Sectorial </li>
               <li>Analisis  de Variación y Participación  (<i>Shift Share</i>)</li>
               </ol>
    <p>Los datos son oficiales y provienen del Observatorio de Empleo y Dinámica Empresarial del Ministerio de Trabajo.</p>

             <br>
            <hr>

             ")
            ) #end column,
  ), #close fluidRow
     ################################################################################################################################################
     ################################################################################################################################################
     ###################                          Indicador De Generacion de Empleo Regional                           ##############################
     ################################################################################################################################################
     ################################################################################################################################################
 fluidRow(
   column(12, h1("Indicador de Generación de Empleo Provincial"))
 ),
 sidebarLayout(
   sidebarPanel(width = 2, offset=2,
     checkboxGroupInput(inputId="provincia_pr",
                                                                  label = "Escoja Provincia",
                                                                  choices = list("CABA",
                                                                                 "Catamarca",
                                                                                 "Chaco",
                                                                                 "Chubut",
                                                                                 "Cordoba",
                                                                                 "Corrientes",
                                                                                 "Entre Rios",
                                                                                 "Formosa",
                                                                                 "GBA",
                                                                                 "Jujuy",
                                                                                 "La Pampa",
                                                                                 "La Rioja",
                                                                                 "Mendoza",
                                                                                 "Misiones",
                                                                                 "Neuquen",
                                                                                 "Resto BsAs",
                                                                                 "Rio Negro",
                                                                                 "Salta",
                                                                                 "San Juan",
                                                                                 "San Luis",
                                                                                 "Santa Cruz",
                                                                                 "Santa Fe",
                                                                                 "Santiago del Estero",
                                                                                 "Tierra del Fuego",
                                                                                 "Tucuman"),
                                                                  selected = "CABA"), #close checkboxGroupInput
     selectInput('trim_init_viz',
                 label = "Desde",
                 choices = list("1 Trim 1997"="1997-1-1",
                                "2 Trim 1997"="1997-2-1",
                                "3 Trim 1997"="1997-3-1",
                                "4 Trim 1997"="1997-4-1",
                                "1 Trim 1998"="1998-1-1",
                                "2 Trim 1998"="1998-2-1",
                                "3 Trim 1998"="1998-3-1",
                                "4 Trim 1998"="1998-4-1",
                                "1 Trim 1999"="1999-1-1",
                                "2 Trim 1999"="1999-2-1",
                                "3 Trim 1999"="1999-3-1",
                                "4 Trim 1999"="1999-4-1",
                                "1 Trim 2000"="2000-1-1",
                                "2 Trim 2000"="2000-2-1",
                                "3 Trim 2000"="2000-3-1",
                                "4 Trim 2000"="2000-4-1",
                                "1 Trim 2001"="2001-1-1",
                                "2 Trim 2001"="2001-2-1",
                                "3 Trim 2001"="2001-3-1",
                                "4 Trim 2001"="2001-4-1",
                                "1 Trim 2002"="2002-1-1",
                                "2 Trim 2002"="2002-2-1",
                                "3 Trim 2002"="2002-3-1",
                                "4 Trim 2002"="2002-4-1",
                                "1 Trim 2003"="2003-1-1",
                                "2 Trim 2003"="2003-2-1",
                                "3 Trim 2003"="2003-3-1",
                                "4 Trim 2003"="2003-4-1",
                                "1 Trim 2004"="2004-1-1",
                                "2 Trim 2004"="2004-2-1",
                                "3 Trim 2004"="2004-3-1",
                                "4 Trim 2004"="2004-4-1",
                                "1 Trim 2005"="2005-1-1",
                                "2 Trim 2005"="2005-2-1",
                                "3 Trim 2005"="2005-3-1",
                                "4 Trim 2005"="2005-4-1",
                                "1 Trim 2006"="2006-1-1",
                                "2 Trim 2006"="2006-2-1",
                                "3 Trim 2006"="2006-3-1",
                                "4 Trim 2006"="2006-4-1",
                                "1 Trim 2007"="2007-1-1",
                                "2 Trim 2007"="2007-2-1",
                                "3 Trim 2007"="2007-3-1",
                                "4 Trim 2007"="2007-4-1",
                                "1 Trim 2008"="2008-1-1",
                                "2 Trim 2008"="2008-2-1",
                                "3 Trim 2008"="2008-3-1",
                                "4 Trim 2008"="2008-4-1",
                                "1 Trim 2009"="2009-1-1",
                                "2 Trim 2009"="2009-2-1",
                                "3 Trim 2009"="2009-3-1",
                                "4 Trim 2009"="2009-4-1",
                                "1 Trim 2010"="2010-1-1",
                                "2 Trim 2010"="2010-2-1",
                                "3 Trim 2010"="2010-3-1",
                                "4 Trim 2010"="2010-4-1",
                                "1 Trim 2011"="2011-1-1",
                                "2 Trim 2011"="2011-2-1",
                                "3 Trim 2011"="2011-3-1",
                                "4 Trim 2011"="2011-4-1",
                                "1 Trim 2012"="2012-1-1",
                                "2 Trim 2012"="2012-2-1",
                                "3 Trim 2012"="2012-3-1",
                                "4 Trim 2012"="2012-4-1",
                                "1 Trim 2013"="2013-1-1",
                                "2 Trim 2013"="2013-2-1",
                                "3 Trim 2013"="2013-3-1",
                                "4 Trim 2013"="2013-4-1",
                                "1 Trim 2014"="2014-1-1",
                                "2 Trim 2014"="2014-2-1",
                                "3 Trim 2014"="2014-3-1",
                                "4 Trim 2014"="2014-4-1",
                                "1 Trim 2015"="2015-1-1",
                                "2 Trim 2015"="2015-2-1",
                                "3 Trim 2015"="2015-3-1",
                                "4 Trim 2015"="2015-4-1",
                                "1 Trim 2016"="2016-1-1",
                                "2 Trim 2016"="2016-2-1",
                                "3 Trim 2016"="2016-3-1",
                                "4 Trim 2016"="2016-4-1",
                                "1 Trim 2017"="2017-1-1"),
                 selected = "2015-1-1") #close trim_init
   ),
   mainPanel (
     htmlOutput("linePR")
     

   ) #close mainPanel

 ), #close sidebarLayout
 br(),
 br(),
 hr(), #white line
 ################################################################################################################################################
 ################################################################################################################################################
 ###################                          Shift Share Bars x Provincias                                        ##############################
 ################################################################################################################################################
 ################################################################################################################################################
 fluidRow(
   column(12,
          h1("Evolucion Sectorial"),
          p("En esta parte puede ver la variación del empleo formal entre dos trimestres y en el Sector industrial de su elección por provincia respecto al performance nacional"))
   ), #close fluidRow
   sidebarLayout(
     sidebarPanel(width = 2, offset=2,

                selectInput('trim_init',
                    label = "Desde",
                    choices = list("1 Trim 1996",
                                   "2 Trim 1996",
                                   "3 Trim 1996",
                                   "4 Trim 1996",
                                   "1 Trim 1997",
                                   "2 Trim 1997",
                                   "3 Trim 1997",
                                   "4 Trim 1997",
                                   "1 Trim 1998",
                                   "2 Trim 1998",
                                   "3 Trim 1998",
                                   "4 Trim 1998",
                                   "1 Trim 1999",
                                   "2 Trim 1999",
                                   "3 Trim 1999",
                                   "4 Trim 1999",
                                   "1 Trim 2000",
                                   "2 Trim 2000",
                                   "3 Trim 2000",
                                   "4 Trim 2000",
                                   "1 Trim 2001",
                                   "2 Trim 2001",
                                   "3 Trim 2001",
                                   "4 Trim 2001",
                                    "1 Trim 2002",
                                    "2 Trim 2002",
                                    "3 Trim 2002",
                                    "4 Trim 2002",
                                    "1 Trim 2003",
                                    "2 Trim 2003",
                                    "3 Trim 2003",
                                    "4 Trim 2003",
                                    "1 Trim 2004",
                                    "2 Trim 2004",
                                    "3 Trim 2004",
                                    "4 Trim 2004",
                                    "1 Trim 2005",
                                    "2 Trim 2005",
                                    "3 Trim 2005",
                                    "4 Trim 2005",
                                    "1 Trim 2006",
                                    "2 Trim 2006",
                                    "3 Trim 2006",
                                    "4 Trim 2006",
                                    "1 Trim 2007",
                                    "2 Trim 2007",
                                    "3 Trim 2007",
                                    "4 Trim 2007",
                                    "1 Trim 2008",
                                    "2 Trim 2008",
                                    "3 Trim 2008",
                                    "4 Trim 2008",
                                    "1 Trim 2009",
                                    "2 Trim 2009",
                                    "3 Trim 2009",
                                    "4 Trim 2009",
                                    "1 Trim 2010",
                                    "2 Trim 2010",
                                    "3 Trim 2010",
                                    "4 Trim 2010",
                                    "1 Trim 2011",
                                    "2 Trim 2011",
                                    "3 Trim 2011",
                                    "4 Trim 2011",
                                    "1 Trim 2012",
                                    "2 Trim 2012",
                                    "3 Trim 2012",
                                    "4 Trim 2012",
                                    "1 Trim 2013",
                                    "2 Trim 2013",
                                    "3 Trim 2013",
                                    "4 Trim 2013",
                                    "1 Trim 2014",
                                    "2 Trim 2014",
                                    "3 Trim 2014",
                                    "4 Trim 2014",
                                    "1 Trim 2015",
                                    "2 Trim 2015",
                                    "3 Trim 2015",
                                    "4 Trim 2015",
                                   "1 Trim 2016",
                                   "2 Trim 2016",
                                   "3 Trim 2016",
                                   "4 Trim 2016",
                                   "1 Trim 2017"),
                    selected = "1 Trim 2014"), #close trim_init
                selectInput('trim_fin',
                    label = "Hasta",
                    choices = list( "1 Trim 1996",
                                    "2 Trim 1996",
                                    "3 Trim 1996",
                                    "4 Trim 1996",
                                    "1 Trim 1997",
                                    "2 Trim 1997",
                                    "3 Trim 1997",
                                    "4 Trim 1997",
                                    "1 Trim 1998",
                                    "2 Trim 1998",
                                    "3 Trim 1998",
                                    "4 Trim 1998",
                                    "1 Trim 1999",
                                    "2 Trim 1999",
                                    "3 Trim 1999",
                                    "4 Trim 1999",
                                    "1 Trim 2000",
                                    "2 Trim 2000",
                                    "3 Trim 2000",
                                    "4 Trim 2000",
                                    "1 Trim 2001",
                                    "2 Trim 2001",
                                    "3 Trim 2001",
                                    "4 Trim 2001",
                                    "1 Trim 2002",
                                    "2 Trim 2002",
                                    "3 Trim 2002",
                                    "4 Trim 2002",
                                    "1 Trim 2003",
                                    "2 Trim 2003",
                                    "3 Trim 2003",
                                    "4 Trim 2003",
                                    "1 Trim 2004",
                                    "2 Trim 2004",
                                    "3 Trim 2004",
                                    "4 Trim 2004",
                                    "1 Trim 2005",
                                    "2 Trim 2005",
                                    "3 Trim 2005",
                                    "4 Trim 2005",
                                    "1 Trim 2006",
                                    "2 Trim 2006",
                                    "3 Trim 2006",
                                    "4 Trim 2006",
                                    "1 Trim 2007",
                                    "2 Trim 2007",
                                    "3 Trim 2007",
                                    "4 Trim 2007",
                                    "1 Trim 2008",
                                    "2 Trim 2008",
                                    "3 Trim 2008",
                                    "4 Trim 2008",
                                    "1 Trim 2009",
                                    "2 Trim 2009",
                                    "3 Trim 2009",
                                    "4 Trim 2009",
                                    "1 Trim 2010",
                                    "2 Trim 2010",
                                    "3 Trim 2010",
                                    "4 Trim 2010",
                                    "1 Trim 2011",
                                    "2 Trim 2011",
                                    "3 Trim 2011",
                                    "4 Trim 2011",
                                    "1 Trim 2012",
                                    "2 Trim 2012",
                                    "3 Trim 2012",
                                    "4 Trim 2012",
                                    "1 Trim 2013",
                                    "2 Trim 2013",
                                    "3 Trim 2013",
                                    "4 Trim 2013",
                                    "1 Trim 2014",
                                    "2 Trim 2014",
                                    "3 Trim 2014",
                                    "4 Trim 2014",
                                    "1 Trim 2015",
                                    "2 Trim 2015",
                                    "3 Trim 2015",
                                    "4 Trim 2015",
                                    "1 Trim 2016",
                                    "2 Trim 2016",
                                    "3 Trim 2016",
                                    "4 Trim 2016",
                                    "1 Trim 2017"),
                    selected = "1 Trim 2015"), #close trim_fin
                selectInput('sector',
                            label = "Sector",
                            choices = list("Agricultura, Ganaderia, Caza y Silvicultura" = "agro",
                                           "Pesca y Servicios Conexos"= "pesca",
                                           "Industria Manufacturera"="ind",
                                           "Construcción"="const",
                                           "Comercio al por mayor y al por menor"="com",
                                           "Otros Servicios"="ot_ss",
                                           "Otros Bienes"="ot_bs"),
                            selected =  "agro"), #close sector
              HTML("   <br>
                       <br>

                       Otros Servicios incluye:
                       <ul>
                       <li> Hoteleria y restaurantes </li>
                       <li> Servicios de transporte, de almacenamiento y de comunicaciones </li>
                       <li> Intermediacioón financiera y otros servicios financieros </li>
                       <li> Servicios inmobilidarios, empresariales y de alquiler </li>
                       <li> Enseñanza </li>
                       <li> Servicios sociales y de salud </li>
                       <li> Servicios comunitarios, sociales y personales n.c.p. </li>
                       </ul>
                        Otros Bienes incluye:
                       <ul>
                       <li> Explotación de minas y canteras</li>
                       <li> Electricidad, gas y agua</li>
                       </ul>
                            ")
              ), #end sidebarPanel,

     mainPanel(
       fluidRow(
         column(width = 4,
                htmlOutput("barPR")),
         column(width = 5, offset =3,
                htmlOutput("mapa")))
       
     ) #close mainPanel
   ), #close sidebarLayout
    br(),
    hr(),
 ################################################################################################################################################
 ################################################################################################################################################
 ###################                          Shift Share                                                  ##############################
 ################################################################################################################################################
 ################################################################################################################################################
 column(12,
        h1("Analisis  de Variación y Participación")
  ), #close fluidRow
 sidebarLayout(
   sidebarPanel(width = 2, offset=2,
          selectInput('prov_shift_share',
                      label = "Escoja una provincia a visualizar",
                      choices = list("CABA",
                                     "Catamarca",
                                     "Chaco",
                                     "Chubut",
                                     "Cordoba",
                                     "Corrientes",
                                     "Entre Rios",
                                     "Formosa",
                                     "GBA",
                                     "Jujuy",
                                     "La Pampa",
                                     "La Rioja",
                                     "Mendoza",
                                     "Misiones",
                                     "Neuquen",
                                     "Resto BsAs",
                                     "Rio Negro",
                                     "Salta",
                                     "San Juan",
                                     "San Luis",
                                     "Santa Cruz",
                                     "Santa Fe",
                                     "Santiago del Estero",
                                     "Tierra del Fuego",
                                     "Tucuman"),
                                      selected = "CABA") #close provincias
   ), #close sidebarPanel

          mainPanel(
            htmlOutput("shift_share")
           #htmlOutput("barPR")
          ) #close mainPanel

 ), #close sidebarLayout
 br(),
 hr(),
 br(),
 column(12,
        HTML("<p>Puede descargar los datos de empleo aqui utilizados en el siguiente link</p>"),
        downloadButton("downloadData", "Descargar los Datos"),
        HTML("<p>
    <br>
    <br>Para ver las fórmulas que desglosan las variaciones anteriores ver el siguiente <a href='shift_share.pdf' target='_blank'>pdf</a>
    <br>
    <br>
      N.B.: por comentarios o sugerencias por favor escribir a <a href='mailto:ignaciomsarmiento@gmail.com' target='_top'>ignaciomsarmiento@gmail.com</a> o <a href='mailto:pelosegui@hotmail.com' target='_top'>pelosegui@hotmail.com</a>
  <br>
    <br>
         <br>
         <br>
         <br>
         <br>

         </p>")
 ) #close fluidRow

) #close fluidPage
