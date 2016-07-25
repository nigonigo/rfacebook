# source
sourceDir <- function(path, trace = TRUE, ...){
    for(i in list.files(path, pattern = ".R")){
        if(trace) cat(i, ":")
        source(file.path(path, i), ...)
        if(trace) cat("\n")
    }
}
sourceDir("../R")


# getting data from first metric
imp_list <- list(metric="page_impressions_by_age_gender_unique", since="2016-06-01", until="2016-07-30", period="day")
dat <- fb.data(param_list, T, T)
impressions <- fb.df(dat)

# getting data for second metric
str_list <- list(metric="page_storytellers_by_age_gender", since="2016-06-01", until="2016-07-30", period="day")
dat2 <- fb.data(str_list, F, F)
stories <- fb.df(dat2)

# trying out a third, get no results
plc_list <- list(metric="page_places_checkins_by_age_gender", since="2016-06-01", until="2016-06-30", period="day")
dat3 <- fb.data(plc_list, F,F)
