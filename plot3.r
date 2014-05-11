# loading data
df <- read.csv("household_power_consumption.txt", sep=";")
df2 <- subset(df, df$Date == "1/2/2007" | df$Date == "2/2/2007")

df_fulldate <- data.frame(FullDate = 1:dim(df2)[1])
df_fulldate[,1] <- as.data.frame(strptime(paste(df2[,'Date'], df2[,'Time'], sep = ' '), "%d/%m/%Y %H:%M:%S"))
names(df_fulldate) <- c("fulldate")
df3 <- cbind(df_fulldate, df2)

df3$Sub_metering_1 <- as.numeric(as.character(df3$Sub_metering_1))
df3$Sub_metering_2 <- as.numeric(as.character(df3$Sub_metering_2))
df3$Sub_metering_3 <- as.numeric(as.character(df3$Sub_metering_3))

# drawing graph
Sys.setlocale("LC_TIME", "en") # in order to show english text (otherwise it will be in italian)
par(cex.lab=0.7, cex.axis=0.7, cex.main=0.7, cex.sub=0.7)

plot_colors <- c("black", "red", "blue")
plot(df3$fulldate, df3$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df3$fulldate, df3$Sub_metering_2, type = "l", col = "red")
lines(df3$fulldate, df3$Sub_metering_3, type = "l", col = "blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = plot_colors, 
       cex=0.7,
       lty=c(1,1,1), 
       lwd=c(2.5,2.5, 2.5))

dev.copy(png, file = "plot3.png") 
dev.off()

