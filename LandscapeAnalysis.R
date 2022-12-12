# Landscape influence analysis
# Created by Lucas Vieira in 30/07/2022 with the help of Juliana Silveira dos Santos
# Soil data is not entered in the multifit

rm(list=ls())

# Packages used
library(fitdistrplus)
require (readxl)
require(MASS)
require(car)
require(psych)
require(plyr)
require(bbmle)
require (ggplot2)
require (visreg)
require(olsrr)
require(corrplot)

# Loading the Dataset
data <- read_excel("teste4.xlsx", sheet = 1)
str(data)

# Data Distribution Analysis
descdist(data$rich, discrete = TRUE, boot=1001) #negative binomial
descdist(data$abund, discrete = TRUE, boot=1001) #negative binomial
descdist(data$H.Shannon, discrete = FALSE, boot=1001) #normal

# Choose the lowest AIC
om.wb = fitdist(data$H.Shannon, "norm")
om.wb$aic
om.g = fitdist(data$H.Shannon, "gamma")
om.g$aic
om.l = fitdist(data$H.Shannon, "lnorm")
om.l$aic
descdist(data$H.Simpson, discrete = FALSE, boot=1001) #gamma
descdist(data$Menhinick.index, discrete = FALSE, boot=1001) #gamma
descdist(data$Evenness.index, discrete = FALSE, boot=1001) #gamma
descdist(data$Margalef.index, discrete = FALSE, boot=1001) #gamma
descdist(data$Ca, discrete = FALSE, boot=1001) #lognormal

# Choose the lowest AIC
om.wb = fitdist(data$Ca, "exp") 
om.wb$aic
om.g = fitdist(data$Ca, "gamma")
om.g$aic
om.l = fitdist(data$Ca, "lnorm")
om.l$aic
descdist(data$Mg, discrete = FALSE, boot=1001) #gamma
descdist(data$Al, discrete = FALSE, boot=1001) #normal
descdist(data$H, discrete = FALSE, boot=1001) #gamma
descdist(data$K, discrete = FALSE, boot=1001) #gamma
descdist(data$PMel, discrete = FALSE, boot=1001) #gamma
descdist(data$Zn, discrete = FALSE, boot=1001) #gamma
descdist(data$CEC, discrete = FALSE, boot=1001) #gamma
descdist(data$BS, discrete = FALSE, boot=1001) #gamma
descdist(data$Org.Mat, discrete = FALSE, boot=1001) #gamma
descdist(data$pH, discrete = FALSE, boot=1001) #gamma
descdist(data$pct_Clay, discrete = FALSE, boot=1001) #uniform
om.wb = fitdist(data$pct_Clay, "unif") 
om.wb$aic
om.g = fitdist(data$pct_Clay, "gamma")
om.g$aic
om.l = fitdist(data$pct_Clay, "lnorm")
om.l$aic
descdist(data$pct_Silt, discrete = FALSE, boot=1001) #uniform
om.wb = fitdist(data$pct_Silt, "unif") 
om.wb$aic
om.g = fitdist(data$pct_Silt, "gamma")
om.g$aic
om.l = fitdist(data$pct_Silt, "lnorm")
om.l$aic
descdist(data$pct_Sand, discrete = FALSE, boot=1001) #uniform
descdist(data$Pb, discrete = FALSE, boot=1001) #normal
descdist(data$Cd, discrete = FALSE, boot=1001) #normal
descdist(data$Cr, discrete = FALSE, boot=1001) #lognormal
om.wb = fitdist(data$Cr, "exp") 
om.wb$aic
om.g = fitdist(data$Cr, "gamma")
om.g$aic
om.l = fitdist(data$Cr, "lnorm")
om.l$aic
descdist(data$Ni, discrete = FALSE, boot=1001) #normal
descdist(data$MPD, discrete = FALSE, boot=1001) #logistic ou gamma
om.wb = fitdist(data$MPD, "logis") 
om.wb$aic
om.g = fitdist(data$MPD, "gamma")
om.g$aic
om.l = fitdist(data$MPD, "lnorm")
om.l$aic
descdist(data$MNTD, discrete = FALSE, boot=1001) #logistic ou gamma
om.wb = fitdist(data$MNTD, "logis") 
om.wb$aic
om.g = fitdist(data$MNTD, "gamma")
om.g$aic
om.l = fitdist(data$MNTD, "lnorm")
om.l$aic

#---------------#
# Shannon Index #
#---------------#

#-----#
# VIF #
#-----#

mod <- glm(data$H.Simpson~
             data$SHDI1000+
             data$Shape_mean500+
             data$pct_habitat100+
             data$NP1000+
             data$dominance_matrix200, family = Gamma)

cutoff=3 #Baseado no livro de Zuur et al 2009
flag=TRUE
viftable=data.frame()
while(flag==TRUE) {
  vfit=vif(mod)
  viftable=rbind.fill(viftable,as.data.frame(t(vfit)))
  if(max(vfit)>cutoff) { mod=
    update(mod,as.formula(paste(".","~",".","-",names(which.max(vfit))))) }
  else { flag=FALSE } }

print(mod)
print(vfit)
print(viftable)

capture.output(vfit, file = "D:/OneDrive - Universidade Federal de Goiás/Documentos/Doutorado/Projeto_Metagenomics/2022/Paisagem/VIF/VIF_H.Simpson.txt")

#---------#
# Models #
#---------#

null_model <- glm(H.Shannon~1, data=data, family = gaussian)
mod1 <- glm(H.Shannon~SHDI100, data=data, family = gaussian)
mod2 <- glm(H.Shannon~Shape_mean100, data=data, family = gaussian)
# mod3 <- glm(rich~pct_habitat700, data=data, family = gaussian)
mod4 <- glm(H.Shannon~NP100, data=data, family = gaussian)
mod5 <- glm(H.Shannon~dominance_matrix100, data=data, family = gaussian)

#-----------------------------------#
# Running AIC to compare the models #
#-----------------------------------#

Select <- ICtab(null_model,mod1,mod2,mod4,mod5,type="AICc", delta=T, nobs=32, weights=T, base=T)

Select

capture.output(Select, file = "D:/OneDrive - Universidade Federal de Goiás/Documentos/Doutorado/Projeto_Metagenomics/2022/Paisagem/AIC/AIC_H.Shannon.txt")

# Chart
pdf(file = "Shannon_Index.pdf", width = 6, height = 4)
visreg(mod2, "Shape_mean100", gg=TRUE, line=list(col="#000000"),
       type="conditional",
       xlab="Shannon Index", ylab="Shape Mean (100m)",
       fill=list(fill="#000000", alpha=0.1),
       points=list(size=2, pch=16, col="#000000", alpha=0.7))+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        strip.background = element_rect(colour=NA, fill=NA))+
  theme(axis.text=element_text(size=22, colour = "black"),
        axis.title=element_text(size=22))  +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1))+
  theme(strip.text.x = element_text(colour = "black", face = "bold", size=22))+
  ylim(5.5, 6.5)+
  annotate(geom="text", x=1.75, y=3, label="a)", size=12,
           color="black")
dev.off()

# Colininity
round(cor(data), 2)

mymodel <- lm(H.Shannon~., data=data)
Tolerance <- ols_vif_tol(mymodel) 

capture.output(Tolerance, file = "D:/OneDrive - Universidade Federal de Goiás/Documentos/Doutorado/Projeto_Metagenomics/2022/Paisagem/Colinearidade/VIF_Tolerance.txt")
 
vif(mymodel) 

# Collinearity matrix
pdf(file = "ColMatrixR.pdf", width = 12, height = 8)
corrplot(cor(data), method = "number")
dev.off()
