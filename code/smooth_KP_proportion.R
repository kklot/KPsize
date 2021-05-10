# 
# smoothing % from Keith
# 

library(INLA)

# Running smoothing model
# 
# The proportion were transformed by logit link

fmsm <- pMSM ~ 1 + 
    f(subrgid, model='iid', hyper=list(prec = list(prior = "pc.prec"))) + 
    f(cid, model="besag", graph=nbmat, constr=TRUE, 
        adjust.for.con.comp = TRUE, scale.model=TRUE)
ffsw <- pFSW ~ 1 + 
    f(subrgid, model='iid', hyper=list(prec = list(prior = "pc.prec"))) + 
    f(cid, model="besag", graph=nbmat, constr=TRUE, 
        adjust.for.con.comp = TRUE, scale.model=TRUE)
fmtg <- pTG ~ 1 + 
    f(subrgid, model='iid', hyper=list(prec = list(prior = "pc.prec"))) + 
    f(cid, model="besag", graph=nbmat, constr=TRUE, 
        adjust.for.con.comp = TRUE, scale.model=TRUE)

mod_msm <- inla(fmsm, data=map_, control.predictor=list(compute=TRUE, link=1))
map_$msm <- mod_msm$summary.fitted.values[,1]
map$msm  <- mod_msm$summary.fitted.values[,1]

mod_fsw <- inla(ffsw, data=map_, control.predictor=list(compute=TRUE, link=1))
map_$fsw <- mod_fsw$summary.fitted.values[,1]
map$fsw  <- mod_fsw$summary.fitted.values[,1]

mod_TG <- inla(fmtg, data=map_, control.predictor=list(compute=TRUE, link=1))
map_$TG <- mod_TG$summary.fitted.values[,1]
map$TG  <- mod_TG$summary.fitted.values[,1]
    
maxy = data.table(map_)[, .(msm, fsw, TG, pMSM, pFSW, pTG)] %>%
    range(na.rm=TRUE) *100
breaks = seq(0, 4, .5)

p1 = map_ %>% ggplot() + 
    geom_sf(aes(fill=msm*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% MSM - smoothed')
p2 = map_ %>% ggplot() + 
    geom_sf(aes(fill=fsw*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% FSW - smoothed')
p3 = map_ %>% ggplot() + 
    geom_sf(aes(fill=TG*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% TG - smoothed')
q1 = map_ %>% ggplot() + 
    geom_sf(aes(fill=pMSM*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% MSM - original')
q2 = map_ %>% ggplot() + 
    geom_sf(aes(fill=pFSW*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% FSW - original')
q3 = map_ %>% ggplot() + 
    geom_sf(aes(fill=pTG*100), col='white', size=.051, label_axes='----') + 
    theme_minimal() + theme(axis.text.x=element_blank()) +
    scale_fill_continuous(type='viridis', breaks=breaks) +
    labs(fill='%', subtitle='% TG - original')

ggpubr::ggarrange(p1, q1, p2, q2, p3, q3, nrow=3, ncol=2, 
                  common.legend=1, legend='right')

savePs('fig/MSMFSWTG')
    
data.table(map_)[, .(ISO_A2, pMSM, pFSW, pTG, msm, fsw, TG)] %>% 
    fwrite('fit/original_n_extrapolate_proportion.csv')

saveRDS(map_, 'fit/map_fit.rds')