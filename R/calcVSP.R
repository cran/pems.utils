##########################
##########################
##VSP calculations
##########################
##########################
#need checking re new pems structure
#description
##########################
#functions to calculate and handle VSP
##########################
#includes 
##########################
#calcVSP
#calcVSP_JimenezPalacios
#binVSP
#binVSP_NCSU.14
#binVSP_MOVES.24
##########################
#to do
##########################
#rethink/remake calcVSP
#   think it wants to be more like 
#remake calcCMEM or equivalent
#tidy binVSP
###########################
#comments
##########################
#used calcChecks, checkIfMissing
#binVSP and binVSP_... are current methods


##########################
##########################
##calcVSP
##########################
##########################

#kr 17/06/2018 v 0.0.7

#what it does
##########################
#calcVSP and calcVSP_ calculate VSP based 
##########################
#urgent
##########################
#need to tidy the this.call
#handling give current
#not parent call!!!
##########################
#to do
##########################
#tidy all of this 
#no very rational
#think I am writing same or very 
#similar code in too many places 
#make more like binVSP??

#comments
##########################
#

calcVSP <- function(speed = NULL, accel = NULL, slope = NULL, 
                    time = NULL, distance = NULL, data = NULL,
                    calc.method = calcVSP_JimenezPalacios,
                    ..., fun.name = "calcVSP", this.call = NULL){
  ##############
  #setup
  ##############
  dots <- quos(...)
  this.call <- match.call()
  settings <- calcChecks(fun.name=fun.name, ..., data = data)
  ##############
  #inputs
  ##############
  if(!missing(speed))
    speed <- getPEMSElement(!!enquo(speed), data, if.missing="return")
  if(!missing(accel))
    accel <- getPEMSElement(!!enquo(accel), data, if.missing="return")
  if(!missing(slope))
    slope <- getPEMSElement(!!enquo(slope), data, if.missing="return")
  if(!missing(time))
    time <- getPEMSElement(!!enquo(time), data, if.missing="return")
  if(!missing(distance))
    distance <- getPEMSElement(!!enquo(distance), data, if.missing="return")
  #if missing they are left as NULL
  #so I can see we we can make what we need from what we have...
  #better way to do this???
  if(is.null(speed) & is.null(accel) & is.null(time) & is.null(distance))
    checkIfMissing(if.missing = settings$if.missing, 
                  reply = "want speed and accel but insufficient inputs\n\t can make do with time and distance and work up", 
                  suggest = "add something I can work with to call", if.warning = NULL, 
                  fun.name = fun.name)
  if(is.null(speed)){
    if(is.null(time) | is.null(distance)){
      checkIfMissing(if.missing = settings$if.missing, 
                    reply = "want speed but insufficient inputs\n\t can make do with time and distance and work up", 
                    suggest = "add speed or time and distance to call", if.warning = NULL, 
                    fun.name = fun.name)
    } else {
      speed <- calcSpeed(distance = distance, time = time, if.missing = settings$if.missing, 
                        unit.conversions= settings$unit.conversions)
    }
  }
  if(is.null(accel)){
    if(is.null(time) | is.null(speed)){
      checkIfMissing(if.missing = settings$if.missing, 
                    reply = "want accel but insufficient inputs\n\t can make do with time and distance or time and speed", 
                    suggest = "add speed and time or distance and time to call", if.warning = NULL, 
                    fun.name = fun.name)
    } else {
      accel <- calcAccel(speed = speed, time = time, if.missing = settings$if.missing, 
                        unit.conversions= settings$unit.conversions)
    }
  }
  #to think about
  #calc.method could be character?
  if(is.function(calc.method)){
    #new version
    #strip output because calcVSP packing this...
    if("output" %in% names(dots))
      dots[[which(names(dots)=="output")]]<-NULL
    vsp <- eval_tidy(quo(calc.method(speed=speed, accel=accel, slope=slope, 
                                     data=data, fun.name=fun.name, 
                                     this.call=this.call, !!!dots)))
    return(pemsOutput(vsp, output = settings$output, data = data,  
                      fun.name = fun.name, this.call = this.call))
  }
  #not good if we get here...
  checkIfMissing(if.missing = settings$if.missing, 
                reply = "could not run calc.method!", 
                suggest = "check ?calcVSP if reason unclear", if.warning = "returning NULL", 
                fun.name = fun.name)
  return(NULL)    
}


##########################
##########################
##calcVSP_JimenezPalacios
##########################
##########################

#kr 16/11/2018 v 0.0.1

#this is part replacement for calcVSP_JimenezPalaciosCMEM
#because I want separate methods... 

#REF needed

calcVSP_JimenezPalacios <- function(speed = NULL, accel = NULL, slope = NULL, 
                                    vehicle.weight = NULL, vsp.a = NULL, 
                                    vsp.b = NULL, vsp.c = NULL, vsp.g = NULL, 
                                    ..., data = NULL,  
                                    fun.name = "calcVSP_JimenezPalacios", 
                                    this.call = NULL){
  #######################  
  #setup
  #######################
  settings <- calcChecks(fun.name, ..., data = data)
  #######################
  #get inputs
  #######################
  if(!missing(speed))
    speed <- getPEMSElement(!!enquo(speed), data, if.missing="return")
  if(!missing(accel))
    accel <- getPEMSElement(!!enquo(accel), data, if.missing="return")
  if(!missing(slope))
    slope <- getPEMSElement(!!enquo(slope), data, if.missing="return")
  #######################
  #checks
  ########################
  if(is.null(speed) | is.null(accel))
    checkIfMissing(if.missing = settings$if.missing, 
                   reply = "Need speed and accel", 
                   suggest = "add speed and accel to see or see ?calcVSP", if.warning = NULL, 
                   fun.name = fun.name)
  if(is.null(slope)){
    checkIfMissing(if.missing = "warning", 
                   reply = "slope not supplied; assuming 0", 
                   suggest = "add slope to call and rerun if required", if.warning = NULL, 
                   fun.name = fun.name)
    slope <- 0
  }
  #############################
  #units
  #############################
  #want specific units
  speed <- convertUnits(speed, to = "m/s", unit.conversions = settings$unit.conversions, 
                        if.missing = settings$if.missing, fun.name = fun.name)  
  accel <- convertUnits(accel, to = "m/s/s", unit.conversions = settings$unit.conversions, 
                        if.missing = settings$if.missing, fun.name = fun.name)  
############################
#to do
############################
#slope units to sort out
############################
  #############################
  #make data always pems
  #############################
  if(!isPEMS(data)) data <- makePEMS(data)
################
#testing
################
#any more needed?
###############################
  ####################
  #get pems.constants
  ####################
  #what if data=NULL or not supplied?
  pems.const <- getPEMSConstants(data)    
  if(is.null(vehicle.weight))        
    if(!is.null(pems.const$vehicle.weight))
      vehicle.weight <- pems.const$vehicle.weight
  if(is.null(vehicle.weight)){
    checkIfMissing(if.missing = "warning", 
                   reply = "vehicle.weight unknown; assuming < 3.885 Tons", 
                   suggest = "confirming vehicle.weight", 
                   if.warning = NULL, fun.name = fun.name)
  } else if(vehicle.weight > 3.885)
    checkIfMissing(if.missing = "warning", 
                   reply = "calcVSP_JimenezPalacios not for vehicles > 3.885 Tons",
                   suggest = "apply different calc.method and rerun", 
                   if.warning = NULL, fun.name = fun.name)
  ######################
  #calc parameters
  ######################
  if(is.null(vsp.a)) 
     vsp.a <- if(is.null(pems.const$vsp.a)) 1.1 else pems.const$vsp.a  
  if(is.null(vsp.b)) 
     vsp.b <- if(is.null(pems.const$vsp.b)) 0.132 else pems.const$vsp.b  
  if(is.null(vsp.c)) 
     vsp.c <- if(is.null(pems.const$vsp.c)) 0.000302 else pems.const$vsp.c  
  if(is.null(vsp.g))        
    vsp.g <- if(is.null(pems.const$vsp.g)) 9.81 else pems.const$vsp.g
  ########################
  #In case every need to check what we are using here 
  ########################
  #might think tidying/renaming this 
  #making diagnostic 
  if(!is.null(list(...)$sneaky))
    print(paste(vehicle.weight, vsp.a, vsp.b, vsp.c, vsp.g, sep="; "))
  ########################
  #calc vsp using this method  
  #########################  
  vsp <- speed * (vsp.a * accel + (vsp.g * slope) + vsp.b) + (vsp.c * speed^3)
  vsp <- pems.element(vsp, name="vsp", units="kW/metric ton")
  vsp <- pemsOutput(vsp, output = settings$output, data = data,  
                    fun.name = fun.name, this.call = this.call)
  vsp
}

########################
#NOT EXPORTING THIS
########################

calcVSP_JimenezPalaciosCMEM <- function(speed = NULL, accel = NULL, 
                    slope = NULL, vehicle.weight = NULL, vsp.a = NULL, 
                    vsp.b = NULL, vsp.c = NULL, vsp.g = NULL, ..., data = NULL,  
                    fun.name = "calcVSP_JimenezPalaciosCMEM", 
                    this.call = NULL){

    #constant g might be messy...
  
    #setup
    settings <- calcChecks(fun.name, ..., data = data)

    if(!missing(speed))
        speed <- getPEMSElement(!!enquo(speed), data, if.missing="return")
    if(!missing(accel))
        accel <- getPEMSElement(!!enquo(accel), data, if.missing="return")
    if(!missing(slope))
        slope <- getPEMSElement(!!enquo(slope), data, if.missing="return")

    if(is.null(speed) | is.null(accel))
            checkIfMissing(if.missing = settings$if.missing, 
                           reply = "Need speed and accel", 
                           suggest = "add speed and accel to see or see ?calcVSP", if.warning = NULL, 
                           fun.name = fun.name)
      
    if(is.null(slope)){
            checkIfMissing(if.missing = "warning", 
                           reply = "slope not supplied\n\t assuming 0", 
                           suggest = "add slope to call and rerun if required", if.warning = NULL, 
                           fun.name = fun.name)
            slope <- 0
    }
    
    #want specific units
    speed <- convertUnits(speed, to = "m/s", unit.conversions = settings$unit.conversions, 
                          if.missing = settings$if.missing, fun.name = fun.name)  
    accel <- convertUnits(accel, to = "m/s/s", unit.conversions = settings$unit.conversions, 
                          if.missing = settings$if.missing, fun.name = fun.name)  

#slope to sort out

    #make data always pems
    if(!isPEMS(data)) data <- makePEMS(data)

################
#testing
################

################
#



    pems.const <- getPEMSConstants(data)    
       
    if(is.null(vehicle.weight)){        
        vehicle.weight <- if(is.null(pems.const$vehicle.weight))
                 1.5 else pems.const$vehicle.weight
    }

#note no special bus handling

    if(is.null(vsp.a)){        
        vsp.a <- if(is.null(pems.const$vsp.a)){
                    if(vehicle.weight < 3.855) 1.1
                       else if(vehicle.weight < 6.35) (0.0996 * vehicle.weight) / 2204.6 
                           else if(vehicle.weight < 14.968) (0.0875 * vehicle.weight) / 2204.6
                               else (0.0661 * vehicle.weight) / 2204.6 
                 } else pems.const$vsp.a
    }
    
    if(is.null(vsp.b)){        
        vsp.b <- if(is.null(pems.const$vsp.b))
                 0.132 else pems.const$vsp.b
    }

    if(is.null(vsp.c)){        
        vsp.c <- if(is.null(pems.const$vsp.c)){
                    if(vehicle.weight < 3.855) 0.000302
                       else if(vehicle.weight < 6.35) (1.47 + (5.2e-05 * vehicle.weight)) / 2205 
                           else if(vehicle.weight < 14.968) (1.93 + (5.90e-5 * vehicle.weight)) / 2205
                               else (2.89 + (4.21e-5 * vehicle.weight)) / 2205
                 } else pems.const$vsp.c
    }

    if(is.null(vsp.g)){        
        vsp.g <- if(is.null(pems.const$vsp.g))
                 9.81 else pems.const$vsp.g
    }

########################
#need to check a, b, c for different wt vehicles 
#might need vsp.a, vsp.b, vsp.c?
#vehicle.weight?
########################
    if(!is.null(list(...)$sneaky))
          print(paste(vehicle.weight, vsp.a, vsp.b, vsp.c, vsp.g, sep="; "))
########################
#might think about a sneaky=TRUE 
#option for diagnostic info
########################


    vsp <- speed * (vsp.a * accel + (vsp.g * slope) + vsp.b) + (vsp.c * speed^3)
    vsp <- pems.element(vsp, name="vsp", units="kW/metric ton")
    vsp <- pemsOutput(vsp, output = settings$output, data = data,  
                      fun.name = fun.name, this.call = this.call)
    vsp
}









###################################
#binVSP
###################################

#kr v.0.1.3 19/06/2018

#notes binVSP_MOVES23 needs more work...
# issue noted in docs 


binVSP <- function(..., bin.method="ncsu.14"){
   #NSE method?
   bin.method <- paste("binVSP_", toupper(bin.method), sep="")
   bin.method <- try(get(bin.method))
   #error catch#tidy later
   if(class(bin.method)[1]=="try-error" || !is.function(bin.method))
         stop("bin.method not found")     
   #one line of code?
   dots <- quos(...)
   eval_tidy(quo(bin.method(!!!dots)))
}


binVSP_NCSU.14 <- function (vsp = NULL, data = NULL, 
                    ..., fun.name="binVSP_NSCU.14") {
    #setup
    this.call <- match.call()
    settings <- calcChecks(fun.name=fun.name, ..., data = data)
    #get vsp
    vsp <- getPEMSElement(!!enquo(vsp), data, units="kW/metric ton", 
                          ref.name="vsp")
    ##vsp binning method that just uses vsp
    #ncsu 14 bin method
    #Frey et al 2002/3
    temp <- cut(vsp, right=FALSE,
	        breaks=c(-Inf, -2, 0, 1, 4, 7, 10, 13, 16, 19, 
	                 23, 28, 33, 39, Inf),
	        labels=sprintf("MODE%02d", 1:14),
	        ordered_result=TRUE, exclude=FALSE)
    vsp.bin <- makePEMSElement(temp, units="")
    #output
    pemsOutput(vsp.bin, output = settings$output, data = data,  
                  fun.name = fun.name, this.call = this.call) 
}


binVSP_MOVES.23 <- function (vsp = NULL, speed = NULL, data = NULL, 
                    ..., fun.name="binVSP_MOVES.23") {

    #setup
    this.call <- match.call()
    settings <- calcChecks(fun.name=fun.name, ..., data = data)
    #get vsp and speed
    vsp <- getPEMSElement(!!enquo(vsp), data, units="kW/metric ton", 
                          ref.name="vsp")
    speed <- getPEMSElement(!!enquo(speed), data=data, units="mph", 
                            ref.name="speed")
    ##modes 23 bin method 
    #Koupal, J., Cumberworth, M. and Beardsley, M., 
    #Introducing MOVES2004, the initial release of EPA's new generation mobile source emission model. Ann Arbor, 1001, p.48105.
    temp <- rep(NA, length(vsp))
#doing this up hand
    temp[vsp < 0 & speed >= 1 & speed < 25] <- "MODE11"
    temp[vsp >= 0 & vsp < 3 & speed >= 1 & speed < 25] <- "MODE12"
    temp[vsp >= 3 & vsp < 6 & speed >= 1 & speed < 25] <- "MODE13"
    temp[vsp >= 6 & vsp < 9 & speed >= 1 & speed < 25] <- "MODE14"
    temp[vsp >= 9 & vsp < 12 & speed >= 1 & speed < 25] <- "MODE15"
    temp[vsp >= 12 & speed >= 1 & speed < 25] <- "MODE16"
    temp[vsp < 0 & speed >= 25 & speed < 50] <- "MODE21"
    temp[vsp >=0 & vsp < 3 & speed >= 25 & speed < 50] <- "MODE22"
    temp[vsp >=3 & vsp < 6 & speed >= 25 & speed < 50] <- "MODE23"
    temp[vsp >=6 & vsp < 9 & speed >= 25 & speed < 50] <- "MODE24"
    temp[vsp >=9 & vsp < 12 & speed >= 25 & speed < 50] <- "MODE25"
    temp[vsp >=12 & vsp < 18 & speed >= 25 & speed < 50] <- "MODE27"
    temp[vsp >=18 & vsp < 24 & speed >= 25 & speed < 50] <- "MODE28"
    temp[vsp >=24 & vsp < 30 & speed >= 25 & speed < 50] <- "MODE29"
    temp[vsp >=30 & speed >= 25 & speed < 50] <- "MODE30"
    temp[vsp < 6 & speed >= 50] <- "MODE33"
    temp[vsp >= 6 & vsp < 12 & speed >= 50] <- "MODE35"
    temp[vsp >= 12 & vsp < 18 & speed >= 50] <- "MODE37"
    temp[vsp >= 18 & vsp < 24 & speed >= 50] <- "MODE38"
    temp[vsp >= 24 & vsp < 30 & speed >= 50] <- "MODE39"
    temp[vsp >= 30 & speed >= 50] <- "MODE40"
    temp[speed < 1] <- "MODE01"
#00 Braking to assign 
    temp1 <- c("MODE00", "MODE01", 
               "MODE11", "MODE12", "MODE13", "MODE14", "MODE15", "MODE16", 
               "MODE21", "MODE22", "MODE23", "MODE24", "MODE25", "MODE27", "MODE28", "MODE29", "MODE30",
               "MODE33", "MODE35", "MODE37", "MODE38", "MODE39", "MODE40")
    temp <- factor(temp, levels=temp1, labels=temp1, ordered=TRUE, 
                   exclude=FALSE)
    vsp.bin <- makePEMSElement(temp, units="")
    pemsOutput(vsp.bin, output = settings$output, data = data,  
              fun.name = fun.name, this.call = this.call) 
}








