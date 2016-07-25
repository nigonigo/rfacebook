# rfacebook
use facebook graph api to pull analytical page data


# Functions: 

## fb.data()
This is the main call to the graph api.  It queries Facebook graph api and extracts the data in json format. 

## params()
This converts a named list or vector into string of metric field/value pairs.  E.g. field, metric name = "metric"; field metric value = "page_impressions_by_age_gender_unique": "metric=page_impressions_by_age_gender_unique"

## fb.df()
This converts the json data into a data frame

