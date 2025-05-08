# test Omicsoft R-API access

load(url("http://omicsoft.com/downloads/land/Rapi/Land_R_API.Rda"))
Land.Help() 

#Initiate Oshell environment----

OshellDirectory = "C:/Users/xliu/OneDrive - /Desktop/Omicsoft/Oshell"

Land.InitiateOshell(
  MonoPath = MonoPath,
  OshellDirectory = OshellDirectory,
  BaseDirectory  = "C:/Users/xliu/OneDrive - /Desktop/Omicsoft/Oshell",
  TempDirectory = "C:/Users/xliu1/OneDrive - /Documents/Omicsoft/Temp")

Land.CheckVersion()
Land.OshellUpdate()

#Initiate Land environment

Land.InitiateLand(Server = "tcp://awsacdnva1046.jnj.com:8065", UserID = "compbiobe", Password = "*****", LandName = "Blueprint_B38")
Land.ConnectServer()
#Download meta data to a variable

DownloadMetaData = Land.DownloadMetaData()
head(DownloadMetaData)
