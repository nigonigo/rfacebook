# access graph api to get json data
fb.api.data <- function(user, token, params) {
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

}

dat <- fb.api.data(user, token, params)

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

