data <-read.csv("/home/abel/insurance.csv")
#--------------------------------PRIMER INCISO----------------------------------
columnas_hist <- names(data)

for (column in columnas_hist) {
  hist(data[,column], col="#198CE7", xlab=column,main=paste0("Histogram of ",column), probability = TRUE)
  
}

#-------------------------------SEGUNDO INCISO ---------------------------------
columnas <- c("Insured", "Claims", "Payment")
array1 <-c()
array2<-c()
array3<-c()
for (j in columnas ) {
  for (i in c(1:5)) {
    subdata <- subset(data, Kilometres == i, select = c(paste(j)))
    array1[i] <- sum(subdata)
  }
  barplot(array1, names.arg = c(1:5) ,xlab = "Kilometros", ylab=paste("Suma de ",j,sep = ""))
} 
for (j in columnas ) {
  for (i in c(1:7)) {
    subdata <- subset(data, Zone == i, select = c(paste(j)))
    array2[i] <- sum(subdata)
  }
  barplot(array2, names.arg = c(1:7) ,xlab = "Municipio", ylab=paste("Suma de ",j,sep = ""))
}  
for (j in columnas ) {
  for (i in c(1:9)) {
    subdata <- subset(data, Make == i, select = c(paste(j)))
    array3[i] <- sum(subdata)
  }
  barplot(array3,names.arg = c(1:9), xlab = "Modulo", ylab=paste("Suma de ",j,sep = "") )
}  
#------------------------------------------------------------------------------
#-----------------------------TERCER INCISO------------------------------------
library(corrplot)
correlacion<-round(cor(data),1) 
corrplot::corrplot(correlacion, method ="number")
plot(data$Claims, data$Payment)
plot(data$Insured, data$Payment)
#------------------------------------------------------------------------------
#---------------------------CUARTO INCISO--------------------------------------
linear_model <- lm(formula = Payment~., data = data)
summary(linear_model)
library(ggplot2)
KvsPay <- ggplot(data, aes(Kilometres, Payment)) +
  geom_point() +
  stat_smooth(method = lm)
KvsPay
ZonevsPay <- ggplot(data, aes(Zone, Payment)) +
  geom_point() +
  stat_smooth(method = lm)
ZonevsPay
InsvsPay<-KvsPay <- ggplot(data, aes(Insured, Payment)) +
  geom_point() +
  stat_smooth(method = lm)
InsvsPay
ClaimsvsPay <- ggplot(data, aes(Claims, Payment)) +
  geom_point() +
  stat_smooth(method = lm)
ClaimsvsPay
#-----------------------------------------------------------------------------#
#-----------------------------QUINTO INCISO------------------------------------
costo_riesgo1 <-c()
costo_riesgo2 <-c()
costo_riesgo3 <-c()
for (i in c(1:7)) {
  pagos <- subset(data, Zone == i, select = Payment )
  asegurados <- subset(data, Zone == i, select = Insured )
  suma_pagos <- sum(pagos)
  suma_asegurados <- sum(asegurados)
  costo_riesgo1[i] <- suma_pagos/suma_asegurados
}
barplot(costo_riesgo1, names.arg = c(1:7) ,xlab = "Municipio", ylab= "Pago especial")
for (i in c(1:5)) {
  pagos <- subset(data, Kilometres == i, select = Payment )
  asegurados <- subset(data, Kilometres == i, select = Insured )
  suma_pagos <- sum(pagos)
  suma_asegurados <- sum(asegurados)
  costo_riesgo2[i] <- suma_pagos/suma_asegurados
}
barplot(costo_riesgo2, names.arg = c(1:5) ,xlab = "Kilometros", ylab= "Pago especial")
for (i in c(1:7)) {
  pagos <- subset(data, Bonus == i, select = Payment )
  asegurados <- subset(data, Bonus == i, select = Insured )
  suma_pagos <- sum(pagos)
  suma_asegurados <- sum(asegurados)
  costo_riesgo3[i] <- suma_pagos/suma_asegurados
}
barplot(costo_riesgo3, names.arg = c(1:7) ,xlab = "Bono", ylab= "Pago especial")

