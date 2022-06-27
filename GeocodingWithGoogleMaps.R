#Load packages
library(ggmap)
library(dplyr)

#Register Google API Key
register_google(key = "")

#Do a quick query check of Google account
geocodeQueryCheck()

#########
#GEOCODE#
#########

#Import CSV with locations (cities, addresses, etc.) 
addresses <- read.csv("C:/Users/..../Coding/R/Addresses.csv", header = TRUE, stringsAsFactors = FALSE)

addresses$address_for_geocode <- paste0(addresses$ShipAddressLine3,", ", addresses$City,", ", addresses$ST,", ", addresses$Zipcode)

#Execute geocode
addresses$latlong <- geocode(location=addresses$address_for_geocode, output = "more")
View(addresses)
write.csv(addresses, "C:/Users/..../Coding/R/Addresses_Geocoded.csv")



#################
#REVERSE GEOCODE#
#################

#Import CSV with lat/longs. 
latlongs <- read.csv("C:/Users/psx8/OneDrive - CDC/Coding/R/Addresses_New.csv", header = TRUE, stringsAsFactors = FALSE)

#Reverse Geocode (the 1:2 columns in latlongs correspond to the columns of long,lat (respectively). 
result <- do.call(rbind,
                  lapply(1:nrow(latlongs),
                         function(i)revgeocode(as.numeric(latlongs[i,1:2]))))
data <- cbind(latlongs,result)
View(data)

write.csv(data, "C:/Users/..../Coding/R/Addresses_RevGeocodedR.csv", row.names = TRUE)


