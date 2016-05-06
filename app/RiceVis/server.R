#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

data.geno <- read.csv("RiceSNPData/Rice_44K_genotypes.csv.gz", row.names=1, na.strings=c("NA","00"))
data.geno.2500<-data.geno[,sample(1:ncol(data.geno),2500,replace=FALSE)]
geno.numeric <- data.matrix(data.geno.2500)
genDist <- as.matrix(dist(geno.numeric))
geno.mds <- as.data.frame(cmdscale(genDist))
data.pheno <- read.csv("RiceSNPData/RiceDiversity.44K.MSU6.Phenotypes.csv",row.names=1,na.strings=c("NA","00"))
genopheno.merge.data <- merge(geno.mds,data.pheno,by="row.names")
data.geno.2500.c <- apply(data.geno.2500,2,as.character)
data.geno.2500.ps <- matrix("",nrow=nrow(data.geno.2500.c)*2,ncol=ncol(data.geno.2500.c))
for (i in 1:nrow(data.geno.2500.c)) {
  data.geno.2500.ps[(i-1)*2+1,] <- substr(data.geno.2500.c[i,],1,1)
  data.geno.2500.ps[(i-1)*2+2,] <- substr(data.geno.2500.c[i,],2,2)
}
library(PSMix)
load("RiceSNPData/ps4.2500.RData")
ps4.df <- as.data.frame(cbind(round(ps4$AmPr,3),ps4$AmId)) 
colnames(ps4.df) <- c(paste("pop",1:(ncol(ps4.df)-1),sep=""),"popID") 
maxGenome <- apply(ps4$AmPr,1,max) 
ps4.df <- ps4.df[order(ps4.df$popID,-maxGenome),]
ps4.df$sampleID <- factor(1:413)
library(reshape2)
ps4.df.melt <- melt(ps4.df,id.vars=c("popID","sampleID"))
geno.mds$popID <- factor(ps4$AmId)
genopheno.merge.data$popID <- factor(ps4$AmId)
colnames(ps4$AmPr) <- paste("pr",1:4,sep="")
geno.mds <- cbind(geno.mds,ps4$AmPr)
genopheno.merge.data <- cbind(genopheno.merge.data,ps4$AmPr)
data.pheno.mds <- merge(geno.mds,data.pheno,by="row.names",all=T)

save(data.pheno.mds,file="data.pheno.Rdata")
load("data.pheno.Rdata")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$boxPlot <- renderPlot({
    
    # set up the plot
    pl <- ggplot(data = data.pheno.mds,
                 #Use aes_string below so that input$trait is interpreted
                 #correctly.  The other variables need to be quoted
                 aes_string(x=input$pheno,
                            y=input$trait,
                            color=input$color
                 )
    )
    
    # draw the boxplot for the specified trait
    pl + geom_point() + geom_smooth(method=lm,   # Add linear regression lines
                                    se=FALSE,    # Don't add shaded confidence region
                                    fullrange=FALSE)
    
  })
  
})
