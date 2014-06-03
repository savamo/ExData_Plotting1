png(file = "plot4.png")

par(mfrow = c(2,2))


df <- read.csv("household_power_consumption.txt", sep=";")
df2 <- subset(df, df$Date == "1/2/2007" | df$Date == "2/2/2007")

df_fulldate <- data.frame(FullDate = 1:dim(df2)[1])
df_fulldate[,1] <- as.data.frame(strptime(paste(df2[,'Date'], df2[,'Time'], sep = ' '), "%d/%m/%Y %H:%M:%S"))
names(df_fulldate) <- c("fulldate")
df3 <- cbind(df_fulldate, df2)

df3$Global_active_power <- as.numeric(as.character(df3$Global_active_power))
df3$Voltage <- as.numeric(as.character(df3$Voltage))
df3$Global_reactive_power <- as.numeric(as.character(df3$Global_reactive_power))

# font
Sys.setlocale("LC_TIME", "en") # in order to show english text (otherwise it will be in italian)
#par(cex.lab=0.7, cex.axis=0.7, cex.main=0.7, cex.sub=0.7)

# box(1,1)
plot(df3$fulldate, df3$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# box(1,2)
plot(df3$fulldate, df3$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# box(2,1)
plot_colors <- c("black", "red", "blue")
plot(df3$fulldate, 
     df3$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering",
     )

lines(df3$fulldate, df3$Sub_metering_2, type = "l", col = "red")
lines(df3$fulldate, df3$Sub_metering_3, type = "l", col = "blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = plot_colors, 
       lty=c(1,1,1),
       bty = "n", 
)

#box(2,2)
plot(df3$fulldate, df3$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#dev.copy(png, file = "plot4.png") 
dev.off()
