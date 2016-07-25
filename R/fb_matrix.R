# filters json data into a matrix
fb.matrix <- function(x){
    # filter json data into data list
    raw_list <- lapply(x, FUN='[[',1)
    dat_list <- c()
    for(i in 1:length(raw_list)) dat_list[i] <- list(rapply(raw_list[i],c))
    
    # creates matrix
    cats <- sort(unique(names(unlist(dat_list))))
    rnames <- c()
    for(i in 1:length(x)) rnames[i] <- x[[i]]$end_time
    mat <- matrix(0, ncol=length(cats)+1, nrow=length(dat_list), dimnames = list(c(), c("index", cats)))
    for(j in 1:length(dat_list)){
        r <- c()
        for(i in 1:length(dat_list[[j]])) r[i] <- which(sort(names(dat_list[[j]][i]))==colnames(mat))
        mat[j,r] <- dat_list[[j]]
    }
    # convert to data frame
    mat <- data.frame(mat)
    rnames <- as.character(as.Date(rnames))
    mat$index <- rnames
    return(mat)
}

