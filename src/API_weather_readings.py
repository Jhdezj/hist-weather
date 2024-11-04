import pandas as pd

# Data cleaning for a given variable in a dataframe

def cleansing(dframe, variable):
    # z-score method for detecting outliers
    z_scores = (dframe[variable]-dframe[variable].mean())/dframe[variable].std()

    # mean value excluding outliers
    dates_mean = dframe[variable][abs(z_scores)<=3].mean()

    #replacement of NAN values for the mean value
    dframe.loc[:, variable] = dframe[variable].fillna(dates_mean)

    #replacement of outliers for the mean value
    mean_value = dframe[variable].mean()
    dframe.loc[np.abs(z_scores) > 3, variable] = mean_value

    dframe = dframe[[variable]]
    return dframe


#Location = Point(20.61, -100.43)
# Function that filters average measures on the same day by year
# variables tavg	tmin	tmax	prcp	snow	wdir	wspd	wpgt	pres	tsun
def hist_by_same_day(latitude, longitude, variable, start=  datetime(1994, 1, 1), end= datetime(2024, 10, 28)): 
    Location =Point(latitude, longitude)
    data = Daily(Location, start, end)
    data = data.fetch()
    years = data.index.strftime('%m-%d')=='01-10'
    set_of_dates = data[years].copy()
    return cleansing(set_of_dates, variable)
  



#  Function that filters hourly measures on the same day by year
Location = Point(20.61, -100.43)
def hist_by_same_day_and_hour(latitude, longitude, the_hour, variable, start= datetime(1994, 1, 1,0,0), end= datetime(2024, 1, 1,0,0)): 
    Location = Point(latitude, longitude)
    start =start.replace(hour=the_hour)
    end = end.replace(hour=the_hour)
    years = [start.year + n  for n in range(end.year-start.year+1)]
    df = pd.DataFrame(columns=['temp',	'dwpt',	'rhum',	'prcp',	'snow',	'wdir',	'wspd',	'wpgt',	'pres',	'tsun',	'coco'])
    for y in years: 
        start = start.replace(year=y)
        end = end.replace(year =y)
        data = Hourly(Location, start, end)
        data = data.fetch()
        df=pd.concat([df,data])
    return cleansing(df, variable)
   