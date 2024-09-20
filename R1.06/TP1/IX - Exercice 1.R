(unObjet <- list(unObjet = c(5,4,3,2,1) ,data = matrix(6 :1,nrow = 2, ncol = 3), L = numeric(5), test = vector(mode = "logical", length = 3)))

names(unObjet)

mode(unObjet[[4]])
length(unObjet[[4]])

dim(unObjet[2])

unObjet[[2]][2]
unObjet[[2]][3]

unObjet[[3]] = 3 :8
unObjet[[3]]
