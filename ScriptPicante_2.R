# Running the picante package and other phylogenetic analyses
# Criado por Lucas Vieira em 20/06/2022

BiocManager::install("ggtree")
BiocManager::install("ComplexHeatmap")


library(vegan)
library(picante)
library(pez)
library(DAMOCLES)
library(adephylo)
require(ggpubr)
library(ggplot2)
library(reshape2)
require(nodiv)
require(ggtree)
require(betapart)
require(gridGraphics)
require(grid)
require(ComplexHeatmap)
require(tabula)
require(abdiv)


comm.j <- read.csv("Bracken_samles2.csv", row.names = 1)
tree.j <- read.tree(file = "Point4.tree")
tree.j <- drop.tip(tree.j, setdiff(tree.j$tip.label,  colnames(comm.j)))
#tree.j$tip.label <- as.factor(tree.j$tip.label)
#class(tree.j$tip.label)
#tree.j$tip.label <- na.omit(tree.j$tip.label)
#summary(tree.j)

matchs <- match.phylo.comm(phy = tree.j, comm = comm.j)
dat <- comparative.comm(phy = tree.j, comm = as.matrix(comm.j))

foo <- function() {
  col <- "green"
  for (i in 1:2)
    axis(i, col = col, col.ticks = col, col.axis = col, las = 1)
  box(lty = "19")
}


plot(tree.j, "f", FALSE); foo()

# Counting the number of descending branches from each node connecting one end of the phylogeny to the root.
tax.dis.j <- tax.distinctiveness(tree.j, type = "Vane-Wright")

# Calculate the sum total of branch lengths for single or multiple samples
pd.j <- pd(comm.j, tree.j)

cor.test(pd.j$PD, pd.j$SR)
plot(pd.j$PD, pd.j$SR, xlab = "Phylogenetic Diversity", ylab = "Species Richness", pch = 16)

pdf(file = "pd.j.pdf", width = 6, height = 4)
sp <- ggscatter(pd.j, x = "PD", y = "SR", xlab = "Phylogenetic Diversity", ylab = "Species Richness",
                add = "reg.line",  # Add regressin line
                add.params = list(color = "blue", fill = "lightgray"), # Customize reg. line
                conf.int = TRUE # Add confidence interval
)
# Add correlation coefficient
sp + stat_cor(method = "pearson", p.accuracy = 0.001, r.accuracy = 0.01)
#> `geom_smooth()` using formula 'y ~ x'
dev.off()

tax.dis.j
pd.j

write.csv(pd.j,"phylogenetic_branch_length.csv")

ses.pd.j <- ses.pd(samp = matchs$comm, tree = matchs$phy, runs = 1000)
write.csv(ses.pd.j, file = "PD_Pradonizada.csv")

# Viewing the results
head(ses.pd.j)
write.csv(ses.pd.j,file = "Standardized_PD.csv")

# Phylogenetic measures of communities
psv.j <- psv(samp = matchs$comm, tree = matchs$phy, compute.var = TRUE)

# Viewing the results
psv.j
write.csv(psv.j, file = "Phylogenetic_species_variability.csv")

# To calculate phylogenetic beta diversity, we will use the function "phylosor" in the pacote package
phybeta.j <- phylosor(samp = matchs$comm, tree = matchs$phy)

pdf(file = "Beta_Diversity.pdf", width = 12, height = 8)
heatmap(as.matrix(phybeta.j), 
        Rowv = NA, 
        Colv = NA, ColSideColors, RowSideColors)
dev.off()

mydf<-as.data.frame(as.matrix(phybeta.j))
write.csv(mydf,file = "Beta_Diversity.csv")

phybeta.rnd.j <- phylosor.rnd(samp = matchs$comm, tree = matchs$phy, cstSor = TRUE, null.model = "taxa.labels", runs = 100)

# We then need to test whether our observed phylogenetic ??-diversity differs from this random expectation.
# Script auxiliar ses.PBD.R

# calculate the standardized effect size of Phylosor (SES_PhyloSor) using our function  
jasper.ses.sor  <- ses.PBD(obs = phybeta.j,
                           rand = phybeta.rnd.j)

# Plotando:
jasper.ses.sor.m <- phybeta.j
for(i in 1:length(phybeta.j)) {jasper.ses.sor.m[i] <- jasper.ses.sor$pbd.ses[i]}

pdf(file = "Null_Beta_Diversity.pdf", width = 12, height = 8)
jasper.ses.sor.m %>% as.matrix() %>% melt() %>% # manipulate data into a format that works for ggplot
  ggplot() + 
  geom_tile(aes(x = Var1, y = Var2, fill = value)) + # create the heatmap
  scale_fill_gradient2(low = "blue", mid = "white", high = "red") + # create a diverging color palette
  xlab("sites") + ylab("sites") + labs(fill = "SES_PhyloSor") + # edit axis and legend titles
  theme(axis.text.x = element_text(angle = 90)) # rotates x axis labels
dev.off()

mydf2<-as.data.frame(as.matrix(jasper.ses.sor.m))
write.csv(mydf2,file = "Null_Beta_Diversity.csv")

#---------------------#
# MPD, MNTD, NRI, NTI #
#---------------------#

# MPD e ses.MPD
MPD<-mpd(matchs$comm, cophenetic(matchs$phy), abundance.weighted=TRUE)
MPD

pdf(file = "MPD_Abundance_Weighted.pdf", width = 6, height = 4)
plot(MPD$MPD, xlab = "Site", ylab = "MPD")
dev.off()

MPD <-data.frame(MPD)
colnames(MPD ) <- "MPD"
rownames(MPD ) <- rownames(comm.j)
write.csv(MPD,"MPD_Abundance_Weighted.csv")

ses.mpd.j <- picante::ses.mpd(samp = matchs$comm, cophenetic(matchs$phy), null.model = "taxa.labels", runs = 1000, abundance.weighted = TRUE)

write.csv(ses.mpd.j, file = "MPD.ses_Abundance_Weighted.csv")

# MNTD e ses.MNTD
MNTD<-mntd(matchs$comm, cophenetic(matchs$phy), abundance.weighted=T)
MNTD

MNTD.d <-data.frame(MNTD)
colnames(MNTD.d ) <- "MNTD.d"
rownames(MNTD.d ) <- rownames(comm.j)
write.csv(MNTD.d,"MNTD_Abundance_Weighted.csv")

pdf(file = "MNTD_Abundance_Weighted.pdf", width = 6, height = 4)
plot(MNTD.d$MNTD.d, xlab = "Site", ylab = "MNTD")
dev.off()

ses.mntd.j <- picante::ses.mntd(samp = matchs$comm, cophenetic(matchs$phy), null.model = "taxa.labels", runs = 1000, abundance.weighted = TRUE)

ses.mntd.j
write.csv(ses.mntd.j, file = "MNTD.ses_Abundance_Weighted.csv")

# SES metric values will be multiplied by -1 to allow interpretation in terms of phylogenetic relationship, values greater than 0 indicate clustering and less than 0 dispersion (Webb et al. 2002).
nti.j <- ses.mntd.j$mntd.obs.z*(-1)
nti.j
write.csv(nti.j, file = "nti.csv")

nri.j <- ses.mpd.j$mpd.obs.z*(-1)
nri.j
write.csv(nri.j, file = "nri.csv")

MPD.file <- (ses.mpd.j$mpd.obs-ses.mpd.j$mpd.rand.mean)/ses.mpd.j$mpd.rand.sd
MPD.file <- data.frame(MPD.file)
colnames(MPD.file ) <- "MPD"
rownames(MPD.file ) <- rownames(comm.j)

MNTD.file <- (ses.mntd.j$mntd.obs-ses.mntd.j$mntd.rand.mean)/ses.mntd.j$mntd.rand.sd
MNTD.file <- data.frame(MNTD.file)
colnames(MNTD.file ) <- "MNTD"
rownames(MNTD.file ) <- rownames(comm.j)

# Plotting MPD e MNTD
pdf(file = "MPD_MNTD.pdf", width = 6, height = 4)
plot(MPD.file$MPD,
     xlab = "Sites",
     ylab = "Standartised effect size",
     type="p",
     col="blue", xlim=c(0, 33), ylim=c(-3, -1))
points(MNTD.file$MNTD, col="red")
legend("topleft",                              # Add legend to plot
       legend = c("MPD", "MNTD"),
       fill=c("blue","red"))
dev.off()

#---------#
# Nodesig #
#---------#
coords <- read.table("Coleta.txt", header = T)

# Transforming the abundance matrix into presence/absence
class(matchs$comm)
comm.k <- matchs$comm
comm.k[comm.k>0] <- 1

NG <- nodiv_data(matchs$phy, comm.k, coords = coords)

NG.results <- Nodesig(NG, Node_sp = NULL, repeats = 100, method = "quasiswap", show = T)

write.csv(NG.results, file = "Nodesig.csv")

# Node_analysis
Node <- Node_analysis(NG, repeats = 100, method = c("quasiswap"), cores = 10, log_parallel_progress = FALSE)
#--------------------------#
# Plotando a árvore matchs #
#--------------------------#

ggtree(matchs$phy) + theme_tree2()
ggtree(matchs$phy, branch.length='none', layout='circular') + geom_tiplab(size=1, aes(angle=angle))
ggtree(matchs$phy, layout="daylight", branch.length = 'none') + geom_tiplab(size=1, aes(angle=angle))

# BETAPART

# functional.beta.pair e functional.beta.multi

DEN.BETA.PAIR <- phylo.beta.pair(comm.k,matchs$phy, index.family="sorensen")
DEN.BETA.PAIR
ls(DEN.BETA.PAIR)
class(DBP)
phylo.beta.sim <- as.data.frame(as.matrix(DEN.BETA.PAIR$phylo.beta.sim))
phylo.beta.sne <- as.data.frame(as.matrix(DEN.BETA.PAIR$phylo.beta.sne))
phylo.beta.sor <- as.data.frame(as.matrix(DEN.BETA.PAIR$phylo.beta.sor))
write.csv(phylo.beta.sim,"den_beta_pair_result1.csv")
write.csv(phylo.beta.sne,"den_beta_pair_result2.csv")
write.csv(phylo.beta.sor,"den_beta_pair_result3.csv")

DEN.BETA.MULTI<-phylo.beta.multi(comm.k,matchs$phy, index.family="sorensen")
DEN.BETA.MULTI
ls(DEN.BETA.MULTI)
write.csv(DEN.BETA.MULTI,"den_beta_multi_result.csv")

# Plot Betapart
attach(mtcars)
par(mfrow=c(2,2))
Heatmap(as.matrix(phybeta.j), name = "Value", column_title = "Beta Diversity (phylosor)", width = unit(15, "cm"), height = unit(15, "cm"))

svg("Beta.svg", width = 11, height = 9, family = "Times")
Heatmap(as.matrix(DEN.BETA.PAIR$phylo.beta.sor), name = "?? SOR", column_title = "Beta Diversity (Sorensen)", width = unit(15, "cm"), height = unit(15, "cm"))
dev.off()

svg("Turnover.svg", width = 11, height = 9, family = "Times")
Heatmap(as.matrix(DEN.BETA.PAIR$phylo.beta.sim), name = "?? SIM", column_title = "Species Turnover", width = unit(15, "cm"), height = unit(15, "cm"))
dev.off()

svg("Nestedness.svg", width = 11, height = 9, family = "Times")
Heatmap(as.matrix(DEN.BETA.PAIR$phylo.beta.sne), name = "?? SNE", column_title = "Species Nestedness", width = unit(15, "cm"), height = unit(15, "cm"))
dev.off()

# Alpha Diversity
alphaS <- diversity(matchs$comm, index = "shannon")
alphaS
write.csv(alphaS, file = "ShannonAlpha.csv")
alphaSi <- diversity(matchs$comm, index = "simpson")
alphaSi
write.csv(alphaSi, file = "SimpsonAlpha.csv")

eve <- evenness(matchs$comm, "simpson")
eve <- data.frame(eve)
colnames(eve ) <- "Evenness"
rownames(eve ) <- rownames(comm.j)
write.csv(eve, file = "Evenness.csv")

rich <- richness(matchs$comm, "menhinick")
rich <- data.frame(rich)
write.csv(rich, file = "Richness.csv")

# Margalef
sum(matchs$comm[3,])
margalef(matchs$comm[5,])

for (i in c(1:32)) {
  print(margalef(matchs$comm[i,]))
}

margs <- c()
for (i in c(1:32)) {
  margs[i] <- print(margalef(matchs$comm[i,]))
}
margs
margs <- data.frame(margs)
margs
write.csv(margs, file = "Margalef.csv")

spp <- c()
for (i in c(1:32)) {
  spp[i] <- print(sum(comm.k[i,]))
}
spp <- data.frame(spp)
rownames(spp ) <- rownames(comm.j)
write.csv(spp, file = "Spp.csv")

Count <- c()
for (i in c(1:32)) {
  Count[i] <- print(sum(matchs$comm[i,]))
}
Count <- data.frame(Count)
rownames(Count ) <- rownames(comm.j)
write.csv(Count, file = "Count.csv")

write.tree(matchs$phy, file = "Matchs.tree")
