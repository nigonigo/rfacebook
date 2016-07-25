# CREATE A FUNCTION THAT GETS TOKEN FROM GRAPH API EXPLORER
fb.auth <- function(){
    cat("\n What is your username or user id ")
    user <- scan(what=character(),nmax=1,quiet=TRUE)
    browseURL('https://developers.facebook.com/tools/explorer/')
    cat("\n Enter your token ")
    token <- scan(what=character(), nmax=1, quiet = TRUE)
    auth <- c(user, token)
    return(auth)
}