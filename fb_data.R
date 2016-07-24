# Accesses graph api and gets data for specified parameters.
fb.data <- function(params, req_auth = FALSE, store_auth = FALSE) {
    # prompts for username/id and token
    if(req_auth == TRUE){
        auth <- fb.auth() 
        # stores username/id and token
        if(store_auth == TRUE){
            auth <<- auth
        }
    }
    user <- auth[1]
    token <- auth[2]
    # Create Connection URL
    params <- params(params)
    paramStr <- paste(params, "", sep = "&", collapse = "")
    connectStr <- paste('https://graph.facebook.com/v2.6/', 
                        user, '/insights?', paramStr, "access_token=", 
                        token, sep = "")
    api_con <- URLencode(connectStr)
    rd <- readLines(api_con, warn = F)
    dat <- rjson::fromJSON(rd)
    return(dat$data[[1]]$values)    
}
