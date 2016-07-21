#navigates to website
browseURL('https://developers.facebook.com/tools/explorer/')
# try to make something that prompts you for parameters
# INCLUDE:
# 1. date (since, until)
# 2. metric
# 3. period
params <- c("metric=page_impressions_by_age_gender_unique","since=2016-06-1", "until=2016-06-30", "period=day")
token <- readline("What is your page token? ")
user <- readline("What is your page username or id? ")


# access graph api to get json data
fb.api <- function(user, token, params) {
    require(rjson) # Load Library
    # Create Connection URL
    paramStr <- paste(params, "", sep = "&", collapse = "")
    connectStr <- paste('https://graph.facebook.com/v2.6/', 
                        user, '/insights?', paramStr, "access_token=", 
                        token, sep = "")
    api_con <- URLencode(connectStr)
    rd <- readLines(api_con, warn = F)
    dat <- fromJSON(rd)
    return(dat$data[[1]]$values)
    # unpacking nested lists
    
}

dat <- fb.api(user, token, params)

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

test <- fb.matrix(dat)


# reorganize matrix to be usable by ggplot
require(ggplot2)
require(reshape2)
g2 <- ggplot(test, aes(index, F.25.34, group=1))+geom_point()+geom_line()

g <- ggplot(melt(test), aes(x=index, y=value, col=variable, group=variable))+geom_line()
g



require(dplyr)
plot(M.25.34~as.Date(index), data = test)
fit <- lm(M.25.34~as.Date(index), test)
abline(fit)
m <- melt(test)
m2 <- filter(m, variable%in%c("F.25.34","M.25.34"))
g3 <- ggplot(m2, aes(x=index, y=value, col=variable, group=variable))+geom_line()+geom_smooth(method = "lm", se = F)
g3

