# TRANSLATES PARAMS INTO A CHARACTER STRING. 
# update it so that it can take any set of arguments.
params <- function(pars = list()){
    # checks that all fields are named
    for(i in 1:length(pars)){
        if(nchar(names(pars[i]))==0) stop("Not all items are named")
    }
    # probably want to add something to make sure that the metric fields are valid:
    
    # generates metric field/value list pairs, separated by "="
    p <- c()
    for(i in 1:length(pars)){
        p[i] <- paste(names(pars[i]), pars[i], sep = "=", collapse = "")
    }
    return(p)
}



