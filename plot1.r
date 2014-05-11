# loading data
df <- read.csv("household_power_consumption.txt", sep=";")
df2 <- subset(df, df$Date == "1/2/2007" | df$Date == "2/2/2007")
df_fulldate <- data.frame(FullDate = 1:dim(df2)[1])
df_fulldate[,1] <- as.data.frame(strptime(paste(df2[,'Date'], df2[,'Time'], sep = ' '), "%d/%m/%Y %H:%M:%S"))
names(df_fulldate) <- c("fulldate")
df3 <- cbind(df_fulldate, df2)

df3$Global_active_power <- as.numeric(as.character(df3$Global_active_power))

# drawing graph
par(cex.lab=0.7, cex.axis=0.7, cex.main=0.7, cex.sub=0.7)
hist(df3$Global_active_power, col = "red", main = "Global Active Power", font.main=2, xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png") 
dev.off()
