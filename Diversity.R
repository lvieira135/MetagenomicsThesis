# Interpreting Diversity Indices KrakenTools
# Created by Lucas Vieira em 28/06/2022

BSpp <- read.table("BetaSpp.txt", header = T, row.names = 1)
BSpp <- as.matrix(BSpp)
heatmap(BSpp)

BG <- read.table("BetaG.txt", header = T, row.names = 1)
BG <- as.matrix(BG)
heatmap(BG)

BF <- read.table("BetaF.txt", header = T, row.names = 1)
BF <- as.matrix(BF)
heatmap(BF)

BO <- read.table("BetaO.txt", header = T, row.names = 1)
BO <- as.matrix(BO)
heatmap(BO)

ASi <- read.table("AlphaSimpson.txt", header = T, row.names = 1)
ASi

plot(ASi$Ordem,
     xlab = "Sites",
     ylab = "Alpha Diversity (Simpson)",
     type="l",
     col="blue", xlim=c(0, 33), ylim=c(0.85, 1.1), lwd = 2)
lines(ASi$Familia, col="red", lwd = 2)
lines(ASi$Genero, col="green", lwd = 2)
lines(ASi$Especie, col="darkgrey", lwd = 2)
legend("topleft",                              # Add legend to plot
       legend = c("Ordem", "Família", "Genêro", "Espécie"),
       fill=c("blue","red","green","darkgrey"))

ASh <- read.table("AlphaShannon.txt", header = T, row.names = 1)
ASh

plot(ASh$Ordem,
     xlab = "Sites",
     ylab = "Alpha Diversity (Shannon)",
     type="l",
     col="blue", xlim=c(0, 33), ylim=c(2.5, 7.5), lwd = 2)
lines(ASh$Familia, col="red", lwd = 2)
lines(ASh$Genero, col="green", lwd = 2)
lines(ASh$Especie, col="darkgrey", lwd = 2)
legend("topleft",                              # Add legend to plot
       legend = c("Ordem", "Família", "Genêro", "Espécie"),
       fill=c("blue","red","green","darkgrey"))
