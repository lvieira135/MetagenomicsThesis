# MMRR performs Multiple Matrix Regression with Randomization analysis
# Edited by Lucas Vieira in 23/07/2022.
# Y is a dependent distance matrix
# X is a list of independent distance matrices (with optional names)

MMRR<-function(Y,X,nperm=999){
	#compute regression coefficients and test statistics
	nrowsY<-nrow(Y)
	y<-unfold(Y)
	if(is.null(names(X)))names(X)<-paste("X",1:length(X),sep="")
        Xmats<-sapply(X,unfold)
        fit<-lm(y~Xmats)
	coeffs<-fit$coefficients
	summ<-summary(fit)
	r.squared<-summ$r.squared
	tstat<-summ$coefficients[,"t value"]
	Fstat<-summ$fstatistic[1]
	tprob<-rep(1,length(tstat))
	Fprob<-1

	#perform permutations
	for(i in 1:nperm){
		rand<-sample(1:nrowsY)
		Yperm<-Y[rand,rand]
		yperm<-unfold(Yperm)
		fit<-lm(yperm~Xmats)
		summ<-summary(fit)
                Fprob<-Fprob+as.numeric(summ$fstatistic[1]>=Fstat)
                tprob<-tprob+as.numeric(abs(summ$coefficients[,"t value"])>=abs(tstat))
	}

	#return values
	tp<-tprob/(nperm+1)
	Fp<-Fprob/(nperm+1)
	names(r.squared)<-"r.squared"
	names(coeffs)<-c("Intercept",names(X))
	names(tstat)<-paste(c("Intercept",names(X)),"(t)",sep="")
	names(tp)<-paste(c("Intercept",names(X)),"(p)",sep="")
	names(Fstat)<-"F-statistic"
	names(Fp)<-"F p-value"
	return(list(r.squared=r.squared,
		coefficients=coeffs,
		tstatistic=tstat,
		tpvalue=tp,
		Fstatistic=Fstat,
		Fpvalue=Fp))
}

# unfold converts the lower diagonal elements of a matrix into a vector
# unfold is called by MMRR

unfold<-function(X){
	x<-vector()
	for(i in 2:nrow(X)) x<-c(x,X[i,1:i-1])
	x<-scale(x, center=TRUE, scale=TRUE)  # Comment this line out if you wish to perform the analysis without standardizing the distance matrices! 
	return(x)
}


# Tutorial for data files gendist.txt, geodist.txt, and ecodist.txt

# Read the matrices from files.
# The read.matrix function requires {tseries} package to be installed and loaded.
# If the files have a row as a header (e.g. column names), then specify 'header=TRUE', default is 'header=FALSE'.
library(tseries)
genMat <- read.matrix("Nestedness.txt")
geoMat <- read.matrix("DistGeo.txt")
SHDI <- read.matrix("SHDI.txt")
DM <- read.matrix("dominance_matrix.txt")
PA <- read.matrix("pct_agriculture.txt")
PF <- read.matrix("pct_forest.txt")
PH <- read.matrix("pct_habitat.txt")
PP <- read.matrix("pct_pasture.txt")
PS <- read.matrix("pct_savanna.txt")
SM <- read.matrix("Shape_mean.txt")

# Make a list of the explanatory (X) matrices.
# Names are optional.  Order doesn't matter.
# Can include more than two matrices, if desired.
Xmats1 <- list(geography=geoMat,SHDI=SHDI,DominanceMatrix=DM, pct_Agriculture=PA,
               pct_Forest=PF,
               pct_Habitat=PH,
               pct_Pasture=PP,
               pct_Savanna=PS,
               ShapeMean=SM)
Xmats2 <- list(geography=geoMat,DominanceMatrix=DM)
Xmats3 <- list(geography=geoMat,pct_Agriculture=PA)
Xmats4 <- list(geography=geoMat,pct_Forest=PF)
Xmats5 <- list(geography=geoMat,pct_Habitat=PH)
Xmats6 <- list(geography=geoMat,pct_Pasture=PP)
Xmats7 <- list(geography=geoMat,pct_Savanna=PS)
Xmats8 <- list(geography=geoMat,ShapeMean=SM)

# Run MMRR function using genMat as the response variable and Xmats as the explanatory variables.
# nperm does not need to be specified, default is nperm=999)
A1 <- MMRR(genMat,Xmats1,nperm=999)
ols_step_backward_p(A1)
plot(PH)
A2 <- MMRR(genMat,Xmats2,nperm=999)
A3 <- MMRR(genMat,Xmats3,nperm=999)

require(PopGenReport)
require(olsrr)
lgrMMRR(genMat, Xmats1, eucl.mat = NULL, nperm = 10000)

# These data should generate results of approximately:
# Coefficient of geography = 0.778 (p = 0.001)
# Coefficient of ecology = 0.167 (p = 0.063)
# Model r.squared = 0.727 (p = 0.001)
# Note that significance values may change slightly due to the permutation procedure.

# Soil
AL <- read.matrix("Al.txt")
BS <- read.matrix("BS.txt")
CA <- read.matrix("Ca.txt")
CEC <- read.matrix("CEC.txt")
CR <- read.matrix("Cr.txt")
H <- read.matrix("H.txt")
K <- read.matrix("K.txt")
MG <- read.matrix("Mg.txt")
OrgMat <- read.matrix("Org.Mat.txt")
P <- read.matrix("P.txt")
pctClay <- read.matrix("pct_Clay.txt")
pctSand <- read.matrix("pct_Sand.txt")
pctSilt <- read.matrix("pct_Silt.txt")
pH <- read.matrix("pH.txt")
ZN <- read.matrix("Zn.txt")

XmatsAll <- list(geography=geoMat,Al=AL,BS=BS,Ca=CA,
                 CEC=CEC,Cr=CR,H=H,K=K,Mg=MG,
                 Org.Mat=OrgMat,P=P,pct_Clay=pctClay,pct_Sand=pctSand,pct_Silt=pctSilt,pH=pH,Zn=ZN)

Xmats1 <- list(geography=geoMat,Al=AL)
Xmats2 <- list(geography=geoMat,BS=BS)
Xmats3 <- list(geography=geoMat,Ca=CA)
Xmats4 <- list(geography=geoMat,CEC=CEC)
Xmats5 <- list(geography=geoMat,Cr=CR)
Xmats6 <- list(geography=geoMat,H=H)
Xmats7 <- list(geography=geoMat,K=K)
Xmats8 <- list(geography=geoMat,Mg=MG)
Xmats9 <- list(geography=geoMat,Org.Mat=OrgMat)
Xmats10 <- list(geography=geoMat,P=P)
Xmats11 <- list(geography=geoMat,pct_Clay=pctClay)
Xmats12 <- list(geography=geoMat,pct_Sand=pctSand)
Xmats13 <- list(geography=geoMat,pct_Silt=pctSilt)
Xmats14 <- list(geography=geoMat,pH=pH)
Xmats15 <- list(geography=geoMat,Zn=ZN)


lgrMMRR(genMat, XmatsAll, eucl.mat = NULL, nperm = 10000)
