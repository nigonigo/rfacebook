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

}


