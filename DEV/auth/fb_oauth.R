require(httr)
# 1. Find OAuth settings for facebook:
#    http://developers.facebook.com/docs/authentication/server-side/
oauth_endpoints("facebook")

# 2. Register an application at https://developers.facebook.com/apps/
#    Insert your values below - if secret is omitted, it will look it up in
#    the FACEBOOK_CONSUMER_SECRET environmental variable.
myapp <- oauth_app(app, id, secret)

# 3. Get OAuth credentials
facebook_token <- oauth2.0_token(
    oauth_endpoints("facebook"),
    myapp,
    type = "application/x-www-form-urlencoded"
)

# 4. Use API
req <- GET("https://graph.facebook.com/me/accounts", config(token = facebook_token))
stop_for_status(req)
dat <- content(req)

# this is my access token
ll_token <- dat$data[[1]]$access_token
