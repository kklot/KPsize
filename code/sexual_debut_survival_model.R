rm(list=ls())

require(INLA)
require(R.utils)
require(data.table)

# data
# -------------------------------------------------------------------------
mydat <- fread('data/AFS_full.csv.bz2')
nbmat <- readRDS('data/nbmat.rds')

# included missing data countries to predict
mydat[, .N, ISO_A2] 
# survey weight scaled by sample size
mydat[, .(svy_weight = sum(scaled_w), .N), ISO_A2] 

# INLA options
#-----------------------------------------------------------------------------
inla.setOption("enable.inla.argument.weights", TRUE)
assign("enable.model.likelihood.loglogisticsurv", TRUE, 
       envir=INLA:::inla.get.inlaEnv())
c_inla <- list(strategy = "gaussian", int.strategy='eb')

# Model and priors
#-----------------------------------------------------------------------------
c_fami <- list(variant=1, hyper=list(theta=list(param=c(18, 1), prior='loggamma')))

fm <- inla.surv(afs, event) ~ 1 + 
    f(subrgid, model='iid', hyper=list(prec = list(prior = "pc.prec"))) +
    f(cid, model="besag", graph=nbmat, constr=TRUE, adjust.for.con.comp = FALSE, scale.model=TRUE)

inla.setOption('smtp', 'tauc')

# Fit separate model for male and female, each with 10 threads and assumed log
# logistic distribution for the survival time

fit_all_female = inla(fm,
    family='loglogisticsurv',
    data = mydat[sex==2],
    weight = mydat[sex==2, scaled_w],
    control.inla = c_inla,
    control.family = c_fami,
    control.compute = c_comp,
    num.threads = 10, verbose=TRUE)

fit_all_male = inla(fm,
    family='loglogisticsurv',
    data = mydat[sex==1],
    weight = mydat[sex==1, scaled_w],
    control.inla = c_inla,
    control.family = c_fami,
    control.compute = c_comp,
    num.threads = 10, verbose=TRUE)
