#Source




run_prophet = function(symbol){
    df <- data.frame(Date=as.POSIXct(index(symbol)),coredata(symbol)) 
    dfs = df[,c(1,4)]
    colnames(dfs) = c('ds','y')
    m = prophet(dfs)
    future = make_future_dataframe(m, periods = 720)
    forecast <- predict(m, future)
    the_list = list(m, forecast, dfs)
    return(the_list)
}


m = x[[1]]
forecast = x[[2]]
dfs = x[[3]] 

#basic plot
prophplot = plot(m,forecast)