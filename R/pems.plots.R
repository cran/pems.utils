##########################
##########################
##various plots 
##########################
##########################

#this uses checkInput

#kr

#description
##########################
#different plot functions


#includes 
##########################
#pemsPlot
#(plot, preprocess, panel)
#WatsonPlot
#(plot, preprocess, panels for different plot.types)

#

#old plots
#latticePlot
#panel.PEMSXYPlot
#XYZPlot
#


#to do
##########################

#comments
##########################
#XYZPlot is not staying
#


###########################
###########################
##pemsPlot
###########################
###########################

####################
#pemsPlot
####################

#kr 17/02/2014
#version 0.0.1


pemsPlot <- function(x, y = NULL, z = NULL, 
         groups = NULL, cond = NULL, ..., data = NULL, 
         units = TRUE, multi.y = "special", 
         fun.name="pemsPlot",
         panel = panel.pemsPlot, scheme = pems.scheme){

    #passes settings on to convert units

    #setup
    extra.args <- list(...)
    settings <- calcChecks(fun.name, ..., data = data)
    
#    x <- getPEMSElement(!!enquo(x), data, if.missing="stop")
    
#    if(!missing(y))
#        y <- getPEMSElement(!!enquo(y), data, if.missing="stop")

#    if(!missing(z))
#        z <- getPEMSElement(!!enquo(z), data, if.missing="stop")

#    if(!missing(groups))
#        groups <- getPEMSElement(!!enquo(groups), data, if.missing="stop")

#    if(!missing(cond))
#        cond <- getPEMSElement(!!enquo(cond), data, if.missing="stop")

    #standardise formula or x,y,z,cond input as formula
    #and grab units
    extra.args$units <- listLoad(listUpdate(extra.args, list(load="units")))
    extra.args <- pemsXYZCondUnitsHandler(x=!!enquo(x), 
                                          y=!!enquo(y), 
                                          z=!!enquo(z), 
                                          cond=!!enquo(cond),
                              groups=!!enquo(groups), data = data,
                              units = units, settings = settings, 
                              multi.y = multi.y, ...)

    extra.args <- listUpdate(extra.args, list(panel = panel, scheme = scheme, 
                                              data = data))

    plt <- do.call(loaPlot, extra.args)
    
    #scales handling
    #done after plot because 
    #    loa::loaPlot currently can't handle scales internally
    #think about 
    #    moving code to loa or fixing in loa 
    #    error catcher for below because 
    #          lattice::scales error messages are not great...
    test <- grep("scales[.]", names(extra.args))
    if(any(test)){
        extra.args <- extra.args[test]
        extra.args <- do.call(scalesHandler, extra.args)
        extra.args <- listUpdate(list(object=plt),
                                 extra.args)
        plt <- do.call(update, extra.args)
    }
    
    #output
    plt

}


##############################
#pemsXYZCondUnitsHandler
##############################

pemsXYZCondUnitsHandler <- function(x, y = NULL, z = NULL, cond = NULL, 
                                    groups = NULL, data = NULL, units = TRUE, 
         ..., fun.name = "pemsXYZCondHandler"){

#think about error messaging and 
#visible message sources

#think about returning redundant data with not.formula

    #allows user to use both 
    #plot(x,y,z,...) and plot(formula,...) type calls
    #returns plot(formula) and updates units

    #setup
    extra.args <- list(...)
    settings <- calcChecks(fun.name, ..., data = data)
    #data <- as.data.frame(data)

    #units handling 
    #note: this could be less complex
    extra.args <- do.call(listLoad, listUpdate(extra.args, 
                                               list(load="units", units=units)))
    extra.args$units <- listUpdate(list(add.to.labels=TRUE), extra.args$units)
    extra.args$units$units <- if(isGood4LOA(units)) TRUE else FALSE
    
    l.x <- as_label(enquo(x))
    l.y <- as_label(enquo(y))
    l.z <- as_label(enquo(z))
    l.groups <- as_label(enquo(groups))
    l.cond <- as_label(enquo(cond))

    x <- getPEMSElement(!!enquo(x), data, if.missing="stop")
#factor handling
#move to loa?
#same for others?
    if(is.factor(x)){
        extra.args <- listUpdate(list(scales=list(x=list(at=c(1:length(levels(x))),
                                                         labels=levels(x),
                                                         rot=45))),
                                 extra.args)
        x <- pems.element(as.numeric(x))
    }

    if(!missing(y))
        y <- getPEMSElement(!!enquo(y), data, if.missing="stop", 
                            if.null="return")
    if(is.factor(y)){
        extra.args <- listUpdate(list(scales=list(y=list(at=c(1:length(levels(y))),
                                                         labels=levels(y)))),
                                 extra.args)
        y <- pems.element(as.numeric(y))
    }
    
    if(!missing(z))
        z <- getPEMSElement(!!enquo(z), data, if.missing="stop",
                            if.null="return")
    
    if(!missing(groups))
        groups <- getPEMSElement(!!enquo(groups), data, if.missing="stop",
                                 if.null="return")
    
    if(!missing(cond))
        cond <- getPEMSElement(!!enquo(cond), data, if.missing="stop",
                               if.null="return")

    
###########################
#rlang update
#    temp <- if(hijack) x else 
#                checkInput(x, data=data, if.missing="return")
############################
    
#####################################    
#    temp <- getPEMSElement(!!enquo(x), data, fun.name=fun.name,
#                            if.missing = "return")

#    if(!is.na(as.character(temp[1])) && as.character(temp)[1]=="~"){
#        #this is a formula
#        is.formula <- TRUE
#    } else {
#        is.formula <- FALSE
#        x <- temp
#    }

    #if formula I assume you have put everything in formula
#    if(is.formula){

         #add x and y units to units
#         temp <- formulaHandler(x, data, output="lattice.like")
#         extra.args$units$x.units <- eval(parse(text=paste("getUnits(", temp$xlab,", ", "data", ", if.missing='return')", sep="")))
#         extra.args$units$y.units <- eval(parse(text=paste("getUnits(", temp$ylab,", ", "data", ", if.missing='return')", sep="")))
#         if("zlab" %in% names(temp))
#             extra.args$units$z.units <- eval(parse(text=paste("getUnits(", temp$zlab,", ", "data", ", if.missing='return')", sep="")))
         #return ans
         #note units already in extra.args
#         return(listUpdate(extra.args, list(x=x, data=data)))
        
#    }

    #if formula you cant get to here
    #so this is none formula handling

    
    
 #   y <- getPEMSElement(!!enquo(y), data, fun.name=fun.name,
 #                       if.missing = "stop", if.null="return")
 #   z <- getPEMSElement(!!enquo(z), data, fun.name=fun.name,
 #                       if.missing = "stop", if.null="return")
 #   cond <- getPEMSElement(!!enquo(cond), data, fun.name=fun.name,
 #                          if.missing = "stop", if.null="return")
 #   groups <- getPEMSElement(!!enquo(groups), data, fun.name=fun.name,
 #                          if.missing = "stop", if.null="return")

################################
#as of pemsGetElement update
#    if(!hijack){   
#        y <- checkInput(y, data=data, if.missing="return")
#        z <- checkInput(z, data=data, if.missing="return")
#        cond <- checkInput(cond, data=data, if.missing="return")
#    }
################################

    #index case, like plot(x)
    if(is.null(y)){
        y <- x
        x <- 1:length(x)
        attr(x, "name") <- "Index"
    }

    #multi.y 
    if("sub.id" %in% names(attributes(y))){
        if(is.null(extra.args$multi.y)) {
            extra.args$multi.y <- "special"   #should never happen
        }
        if("special" %in% extra.args$multi.y){
            if(is.null(groups)){
                extra.args$multi.y <- c(extra.args$multi.y, 
                                        "groups")
            } else {
                if(!"zcases" %in% names(extra.args)){
                    extra.args$multi.y <- c(extra.args$multi.y, 
                                            "zcases")
                } else {
                    if(is.null(cond)){
                        extra.args$multi.y <- c(extra.args$multi.y, 
                                                "cond")
                    } else {
                        warning("using all multi.y handlers; not tracking...",
                                call. = FALSE)
                    }
                        
                }
            }
        }
        sub.id <- rep(attributes(y)$sub.nm, 
                      attributes(y)$sub.id)
        if("groups" %in% extra.args$multi.y){
            groups <- ordered(sub.id)
        }
        if("zcases" %in% extra.args$multi.y){
            extra.args$zcases <- ordered(sub.id)
        }
        if("cond" %in% extra.args$multi.y){
            cond <- ordered(sub.id)
        }
    }


    if(is.null(x))
        checkIfMissing(settings$if.missing, reply = "argument 'x' not supplied or null")
    extra.args$units$x.units <- getUnits(x, if.missing="return", unit.conversions = settings$unit.conversions)
    if(is.null(y))
        checkIfMissing(settings$if.missing, reply = "argument 'y' not supplied or null")
    extra.args$units$y.units <- getUnits(y, if.missing="return", unit.conversions = settings$unit.conversions)
    if(!is.null(z))
        extra.args$units$z.units <- getUnits(z, if.missing="return", unit.conversions = settings$unit.conversions)

    if(is.null(z) & is.null(cond)) extra.args$x <- ~x*y
    if(is.null(z) & !is.null(cond)) extra.args$x <- ~x*y|cond
    if(!is.null(z) & is.null(cond)) extra.args$x <- z~x*y
    if(!is.null(z) & !is.null(cond)) extra.args$x <- z~x*y|cond

#    lab.fun <- function(x, def, units, units2){
#        temp <- if(is.null(attr(x, "name"))) def else attr(x, "name")
#        if(isGood4LOA(units$units))
#            if(units$add.to.label)
#                if(!is.null(units2))
#                    temp <- paste(temp, " [", units2, "]", sep="") 
#        temp
#    } 
    if(!"xlab" %in% names(extra.args)) 
       extra.args$xlab <- if(is.null(attr(x, "name"))) l.x else attr(x, "name")
    if(!"ylab" %in% names(extra.args)) 
       extra.args$ylab <- if(is.null(attr(y, "name"))) l.y else attr(y, "name")
    if(!is.null(z) && !"zlab" %in% names(extra.args)) 
       extra.args$zlab <- if(is.null(attr(z, "name"))) l.z else attr(z, "name")

    extra.args$groups <- groups

#        extra.args$xlab <- lab.fun(x, "x", extra.args$units, extra.args$units$x.units)

    #extra.args$x must exist and data not needed
    #extra.args$units updated
    
    return(extra.args)


}



#######################
#preprocess.pemsPlot
#######################

preprocess.pemsPlot <- function(lattice.like=lattice.like, units=units,...){

#this is a bit messy
#might rethink how stuff goes in 

        extra.args <- list(...)
        settings <- calcChecks(...) #don't set fun.name or data here or put back in later

        xlab <- if(is.null(extra.args$xlab)) lattice.like$xlab else extra.args$xlab
        ylab <- if(is.null(extra.args$ylab)) lattice.like$ylab else extra.args$ylab
        zlab <- if(is.null(extra.args$zlab)) lattice.like$zlab else extra.args$zlab


# this is now in panel so ignored by key
# 
#        if(is.null(lattice.like$z)) lattice.like$z <- 1

        if(isGood4LOA(units$units)){

            if("x.to" %in% names(extra.args)){
                from <- if("x.from" %in% names(extra.args)) extra.args$x.from else units$x.units     
                lattice.like$x <- convertUnits(lattice.like$x, to=extra.args$x.to, from=from, 
                                               unit.conversions = settings$unit.conversions, 
                                               force=TRUE)
                units$x.units <- extra.args$x.to
            }
            if("y.to" %in% names(extra.args)){
                from <- if("y.from" %in% names(extra.args)) extra.args$y.from else units$y.units     
                lattice.like$y <- convertUnits(lattice.like$y, to=extra.args$y.to, from=from, 
                                               unit.conversions = settings$unit.conversions,
                                               force=TRUE)
                units$y.units <- extra.args$y.to
            }
            if("z.to" %in% names(extra.args)){
                from <- if("z.from" %in% names(extra.args)) extra.args$z.from else units$z.units     
                lattice.like$z <- convertUnits(lattice.like$z, to=extra.args$z.to, from=from, 
                                               unit.conversions = settings$unit.conversions,
                                               force=TRUE)
                units$z.units <- extra.args$z.to
            }

            if("add.to.labels" %in% names(units) && units$add.to.labels){
               if(!is.null(xlab))
                   if(is.character(xlab) && xlab!=""){
                        lattice.like$xlab <- if("x.units" %in% names(units))
                            paste(xlab, " [", units$x.units, "]", sep = "") else xlab
                        xlab <- lattice.like$xlab
                   }
               if(!is.null(ylab))
                   if(is.character(ylab) && ylab!=""){
                        lattice.like$ylab <- if("y.units" %in% names(units))
                            paste(ylab, " [", units$y.units, "]", sep = "") else ylab
                        ylab <- lattice.like$ylab
                   }
###################
#update to zlab so units on next line
###################
               if(!is.null(zlab))
                   if(is.character(zlab) && zlab!=""){
                        lattice.like$zlab <- if("z.units" %in% names(units))
                            paste(zlab, "\n[", units$z.units, "]", sep = "") else zlab
                        zlab <- lattice.like$zlab
                   }
            }

        }
        list(lattice.like=lattice.like, units=units, xlab=xlab, ylab=ylab, zlab=zlab)
     }


############################
#panel.pemsPlot
############################

panel.pemsPlot <- function(..., loa.settings = FALSE){

#could probably lose a lot of these arguments
#but then I would not document them anywhere

#not sure I need to set multi.y here... 

        extra.args <- list(...)

        if(loa.settings){
            temp <- loaHandler(panel.loa, loa.settings = TRUE)
            temp$common.args <- unique(c(temp$common.args, "units"))
            temp$default.settings <- listUpdate(temp$default.settings, 
                                                list(loa.preprocess = preprocess.pemsPlot, 
                                                     grid = TRUE,
                                                     multi.y = "special"))
            return(temp)
        }
        
        #add z if missing
        if(is.null(extra.args$z)) extra.args$z <- 1

        #plot
        do.call(panel.loa, extra.args)

    }




############################
#panel.routePath
############################

panel.routePath <- function(..., loa.settings = FALSE){

#could probably lose a lot of these arguments
#but then I would not document them anywhere

        extra.args <- list(...)

        if(loa.settings){
            temp <- loaHandler(panel.loa)
            temp$common.args <- unique(c(temp$common.args, "units"))
            temp$default.settings <- listUpdate(temp$default.settings, 
                                                list(loa.preprocess = preprocess.pemsPlot, 
                                                     grid=TRUE, group.args= c("col", "lwd"),
                                                     type="l",  
                                                     lwd=8,
                                                     start.cex=1,
                                                     start.pch=20,
                                                     smooth.path=5))
            return(temp)
        }

        #add z if missing give proxy...
        if(is.null(extra.args$z)) extra.args$z <- 1
        if(isGood4LOA(extra.args$grid)){
            panel.loaGrid(panel.scales = extra.args$panel.scales, 
                          grid = extra.args$grid, 
                          xlim = extra.args$xlim, 
                          ylim = extra.args$ylim)
        }
        extra.args$grid <- NULL

        #plot
        plot.fun <- function(...) {
            extra.args <- list(...)
            if("smooth.path" %in% names(extra.args)){
                #by distance smooth journey
                if(length(extra.args$y)<2 | length(extra.args$x)<2)
                    stop("need at least two lat/lon sets to draw path",
                         call. = FALSE)
                deg2rad <- function(x) x * (pi/180)
                rad2deg <- function(x) x * (180/pi)
                
                lat2 <- extra.args$y[-1]
                lat1 <- extra.args$y[-length(extra.args$y)]
                lon2 <- extra.args$x[-1]
                lon1 <- extra.args$x[-length(extra.args$x)]
                
                #using The haversine formula
                dLat <- deg2rad(lat2-lat1)
                dLon <- deg2rad(lon2-lon1)
                lat1 <- deg2rad(lat1)
                lat2 <- deg2rad(lat2)
                
                #the square of half the chord length between the points
                a <- sin(dLat/2) * sin(dLat/2) +
                    sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2)
                
                #the angular distance in radians
                c <- 2 * atan2(sqrt(a), sqrt(1-a)) 
                
                #radius of earth, km
                R <- 6371
                
                #output as m
                dist <- R * c * 1000
                dist <- ifelse(is.na(dist), 0, dist)
                #dist[dist<0.15] <- 0
                
                dist <- c(0, cumsum(dist))
                res <- length(dist)/extra.args$smooth.path
                new.dist <- seq(0, dist[length(dist)], 
                                length.out=res)
                new.lat <- suppressWarnings(approx(dist, extra.args$y, new.dist))
                new.lon <- suppressWarnings(approx(dist, extra.args$x, new.dist))
                
                extra.args$y <- new.lat$y 
                extra.args$x  <- new.lon$y
                
            }
            extra.args$col <- do.call(colHandler, extra.args)
            #extra.args$cex <- do.call(cexHandler, extra.args)
            #extra.args$pch <- do.call(pchHandler, listUpdate(extra.args, 
            #                                                 list(z = NULL)))
            #starts
            temp <- extra.args
            temp$load <- "start"
            temp <- listUpdate(temp, do.call(listLoad, temp)$start)
            panel.xyplot(x=temp$x[1], y=temp$y[1],
                         col=temp$col[1],
                         cex=temp$cex[1]*4,
                         type="p", pch=temp$pch[1])
            #lines
            do.call(panel.xyplot, extra.args)
            #end
            if(length(extra.args$x)>2){
                ref <- length(extra.args$x)
                temp <- extra.args
                temp$load <- "end"
                temp <- listUpdate(temp, do.call(listLoad, temp)$end)
                panel.arrows(x1=temp$x[ref], 
                             x2=temp$x[ref-1],
                             y1=temp$y[ref],
                             y2=temp$y[ref-1],
                             col=temp$col[1],
                             lwd=temp$lwd,
                             cex=4)
                
            }
        
        }
        do.call(groupsAndZcasesPanelHandler, listUpdate(extra.args, 
                                                        list(panel = plot.fun)))
    }







###########################
###########################
##WatsonPlot
###########################
###########################

####################
#WatsonPlot
####################

#kr 17/02/2014
#version 0.0.1

#to do
######################
#wireframe output for plot.type = 3

#to look into
######################
#move z and cond to front of arg
##so (x,y,z, data=...) works
##currently need (x,y, z=z, data=...)
#n/breaks does not pass to contour plot version
#maybe use bin then surfacesmooth for contour plot version


WatsonPlot <- function(speed, accel = NULL, z = NULL, ..., data = NULL, 
         cond = NULL, units = TRUE, plot.type = 2, fun.name="WatsonPlot",
         scheme = pems.scheme){

    #passes settings on to convert units

    #setup
    extra.args <- list(...)
    settings <- calcChecks(fun.name, ..., data = data)

    #standardise formula or x,y,z,cond input as formula
    #and grab units
    extra.args$units <- listLoad(listUpdate(extra.args, list(load="units")))
    extra.args <- pemsXYZCondUnitsHandler(!!enquo(speed), !!enquo(accel), !!enquo(z), 
                              !!enquo(cond), data = data,
                              units = units, settings = settings, ...)
    if(!"panel" %in% names(extra.args)){
        if(plot.type==1) extra.args$panel <- panel.pemsPlot
        if(plot.type==2) extra.args$panel <- panel.WatsonBinPlot
        if(plot.type==3) extra.args$panel <- panel.WatsonContourPlot
        if(plot.type==4) extra.args$panel <- panel.WatsonSmoothContourPlot
    }
    if(is.null(extra.args$panel)){ 
        warning("WatsonPlot: unknown plot.type [generating scatter plot]", 
                call.=FALSE)
        extra.args$panel <- panel.pemsPlot
    }
    extra.args <- listUpdate(extra.args, list(scheme = scheme, 
                                              data = data))

    do.call(loaPlot, extra.args)

}




####################
#preprocess.WatsonPlot
####################

preprocess.WatsonPlot <- function (lattice.like = lattice.like, ...) 
{

    #setup
    extra.args <- list(...)

    #use preprocess.pemsPlot to handle units
    temp <- preprocess.pemsPlot(lattice.like=lattice.like, ...)
    lattice.like <- temp$lattice.like
    new.args <- temp[names(temp) != "lattice.like"]

    new.args$scheme <- if(is.null(extra.args$scheme))
                           pems.scheme else extra.args$scheme

    #x.breaks y.breaks defaults for speed/accel based data
#new bit
#to think about
###############
    #(breaks being set should override this)
    if(!is.null(extra.args$breaks)){
        if(is.null(extra.args$x.breaks)) extra.args$x.breaks <- extra.args$breaks
        if(is.null(extra.args$y.breaks)) extra.args$y.breaks <- extra.args$breaks
    }
    new.args$x.breaks <- if (is.null(extra.args$x.breaks)) 
        pretty(c(0, max(lattice.like$x, na.rm = T)), 20) else 
            if(length(extra.args$x.breaks<2))
                pretty(c(0, max(lattice.like$x, na.rm = T)), extra.args$x.breaks) else 
                     extra.args$x.breaks
    new.args$y.breaks <- if (is.null(extra.args$y.breaks)) 
        pretty(lattice.like$y, 20) else if(length(extra.args$y.breaks<2))
            pretty(lattice.like$y, extra.args$y.breaks) else 
                extra.args$y.breaks
##############
#replaces 
##############
#    new.args$x.breaks <- if(is.null(extra.args$x.breaks))
#        pretty(c(0, max(lattice.like$x, na.rm=T)), 20) else extra.args$x.breaks 
#    new.args$y.breaks <- if(is.null(extra.args$y.breaks))
#        pretty(lattice.like$y, 20) else extra.args$y.breaks

    
    #stopped handling
    omit.stopped <- if("omit.stopped" %in% names(extra.args))
                        extra.args$omit.stopped else "none"
    if(is.logical(omit.stopped))
        omit.stopped <- if(omit.stopped) "points" else "none"

    if(omit.stopped == "points"){
        temp <- extra.args$stopped.speed.accel
        if(length(temp)<1 || !is.numeric(temp)) temp <- 0.1
        if(length(temp)==1) temp <- c(temp, range(c(-temp, temp)))
        if(length(temp)==2) temp <- c(temp[1], range(c(-temp[2], temp[2])))
        if(length(temp)==3) temp <- c(temp[1], range(c(-temp[2:3], temp[2:3])))

        test1 <- lattice.like$x <= temp[1]
        test2 <- lattice.like$y >= temp[2]
        test3 <- lattice.like$y <= temp[3]

        lattice.like$x[test1 & test2 & test3] <- NA
        lattice.like$y[test1 & test2 & test3] <- NA
        if(!is.null(lattice.like$z))
            lattice.like$z[test1 & test2 & test3] <- NA
    }

    if(omit.stopped == "cell" | omit.stopped == "cells"){
        
        temp <- new.args$x.breaks
        temp <- min(temp[temp>0])
        test1 <- lattice.like$x <= temp
        temp <- new.args$y.breaks
        temp2 <- max(temp[temp<0])
        test2 <- lattice.like$y >= temp2
        temp2 <- min(temp[temp>0])
        test3 <- lattice.like$y <= temp2

        lattice.like$x[test1 & test2 & test3] <- NA
        lattice.like$y[test1 & test2 & test3] <- NA
        if(!is.null(lattice.like$z))
            lattice.like$z[test1 & test2 & test3] <- NA

    }
 
    #output
    listUpdate(list(lattice.like = lattice.like), new.args)

}


#############################
#panel.Watson...
#############################


panel.WatsonBinPlot <- function(..., ref.line = TRUE,
         process.panel = panel.binPlot, plot.panel = panel.binPlot, 
         omit.stopped = FALSE, process = TRUE, plot = TRUE, 
         loa.settings = FALSE){

    extra.args <- list(...)

    if (loa.settings) {
        temp <- loaHandler(process.panel)
        temp$common.args <- unique(c(temp$common.args, "units", "omit.stopped", 
                                     "stopped.speed.accel", "settings"))
        temp$default.settings <- listUpdate(temp$default.settings, 
                                     list(loa.preprocess = preprocess.WatsonPlot, 
                                          grid = TRUE, aspect = 0.5))
        return(temp)
    }

    if(process){
        if(!"z" %in% names(extra.args)){
            extra.args$z <- rep(1, length(extra.args$x))
            if(!"statistic" %in% names(extra.args))
                extra.args$statistic <- function(x) length(na.omit(x))
        } else {
            if(!"statistic" %in% names(extra.args))
                extra.args$statistic <- function(x) mean(na.omit(x))
        }
        ans <- do.call(process.panel, 
                       listUpdate(extra.args, list(plot=FALSE, process=TRUE)))
        if(!plot) return(ans)
    }

    if(plot){

        #bin border cols
        col <- getPlotArgs("background")$col
        if(col=="transparent") col <- "white" 
        if(!"col" %in% names(extra.args))
            extra.args$col <- col

#will need to remove this 
#if grid goes into panel.binPlot
#or switch it off here after it is called

        #grid
        if (isGood4LOA(extra.args$grid)) 
            panel.loaGrid(panel.scales = extra.args$panel.scales, 
                grid = extra.args$grid)
                        
        #plot bins and ref.line
        do.call(plot.panel, 
            listUpdate(extra.args, list(plot=TRUE, process=FALSE)))
        if(isGood4LOA(ref.line))
            do.call(panel.abline, getPlotArgs(local.resets=list(h=0, lty=3), user.resets=ref.line, defaults.only=FALSE))               
    }
}



###################################
#another panel

#think about making all of these standalone

#don't know if I can do test
#maybe drop cases outside rather than add in max/min???

panel.WatsonContourPlot <- function(..., plot.panel=panel.kernelDensity,          
         process = TRUE, plot = TRUE, loa.settings = FALSE){

    extra.args <- listUpdate(list(...), list(plot.panel=plot.panel, 
                                             process=process, plot=plot, 
                                             loa.settings=loa.settings))

    if(loa.settings){
        temp <- loaHandler(panel.WatsonBinPlot)
        temp$default.settings <- listUpdate(temp$default.settings, 
                                            list(key.fun=draw.loaColorRegionsKey, 
                                                 alpha.regions = 0.5))
        return(temp)
    }

    if(plot & !process){

        if(!"at" %in% names(extra.args)){
            temp <- pretty(extra.args$zlim, 10)
######################
#test
######################
#might come back to bite me
#
#            temp[temp<min(extra.args$zlim)] <- min(extra.args$zlim)
#            temp[temp>max(extra.args$zlim)] <- max(extra.args$zlim)
######################
            temp <- unique(temp)
            extra.args$at <- temp
        }

    #contout cols
    if(!"col" %in% names(extra.args))
        extra.args$col <- getPlotArgs()$col
    
    #other tweaks
    if(!"labels" %in% names(extra.args))
        extra.args$labels <- TRUE
   
    }
                     
    do.call(panel.WatsonBinPlot, extra.args)
}



##################################
#another panel

#not in package yet...
#not namespace, import, or documented
#

#see above about test

#edges do not go out far enough
#x1, y2, y1, y2????
#see what xlim and ylim are??? 
#I think surfaceSmooth uses them if there...
#might be a shortcut

#lim.borders

panel.WatsonSmoothContourPlot <- function(..., plot.panel=panel.surfaceSmooth,          
         process = TRUE, plot = TRUE, loa.settings = FALSE){

    extra.args <- listUpdate(list(...), list(plot.panel=plot.panel, 
                                             process=process, plot=plot, 
                                             loa.settings=loa.settings))

    if(loa.settings){
        temp <- loaHandler(panel.WatsonBinPlot)
        temp$default.settings <- listUpdate(temp$default.settings, 
                                            list(key.raster = TRUE,  
                                                 contour = TRUE, regions = TRUE,
                                                 alpha.regions = 0.5))
        return(temp)
    }

    if(process){
        if(!"z" %in% names(extra.args)){
            extra.args$z <- rep(1, length(extra.args$x))
            if(!"statistic" %in% names(extra.args))
                extra.args$statistic <- function(x) length(na.omit(x))
        } else {
            if(!"statistic" %in% names(extra.args))
                extra.args$statistic <- function(x) mean(na.omit(x))
        }
        ans <- do.call(panel.binPlot, 
                       listUpdate(extra.args, list(plot=FALSE, process=TRUE)))

        extra.args <- listUpdate(extra.args, ans)

######################
#stop surface smooth using x/ylims 
#might move this to panel.surfaceSmooth
#or refine the modelling
#currently just nas between x/ys and borders
#        extra.args <- listUpdate(extra.args, list(x.breaks=200, y.breaks=200))

        extra.args <- listUpdate(extra.args, list(x.breaks=200, y.breaks=200), ignore=c("xlim", "ylim"))

        ans <- do.call(panel.surfaceSmooth, extra.args)

        if(!plot) return(ans)
    }


    if(plot & !process){

#currently does contours and regions
#want it to just do at

#        if(!"at" %in% names(extra.args)){
#            temp <- pretty(extra.args$zlim, 10)
######################
#test
######################
#might come back to bite me
#
#            temp[temp<min(extra.args$zlim)] <- min(extra.args$zlim)
#            temp[temp>max(extra.args$zlim)] <- max(extra.args$zlim)
######################
#            temp <- unique(temp)
#            extra.args$at <- temp
#        }

    #contout cols
    if(!"col" %in% names(extra.args))
        extra.args$col <- getPlotArgs()$col
    
    #other tweaks
#    if(!"labels" %in% names(extra.args))
#        extra.args$labels <- TRUE
                     
    do.call(panel.WatsonBinPlot, extra.args)
    }
}




























##########################
##########################
##latticePlot
##########################
##########################

#kr 23/01/2012 v 0.0.6

#what it does
##########################
#wrapper for various nice bits 
#of lattice and latticeExtra
#

#to do
##########################
#make test more robust?

#panel... function to fix 
#re conditioning bwplots?



#comments
##########################
#



latticePlot <- function(x = NULL, data = NULL, plot = xyplot, panel = NULL, ..., 
                   greyscale = FALSE, fun.name = "latticePlot"){

    this.call <- match.call()
    extra.args <- list(...)
    settings <- calcChecks(fun.name, ..., data = data)

    #if greyscale
    if(greyscale){
         symbol <- gray(1:8 / 8)
         fill <- "grey"
         region <- gray(11:1 / 11)
         reference <- "black"
         bg <- "transparent"
         fg <- "black"

##################
#tidy code
#track down strip fore colour
##################

         temp <-list(plot.polygon = list(col = fill[1], border = fg[1]),
                     box.rectangle = list(col= symbol[1]),
             box.umbrella      = list(col= symbol[1]),
             dot.line          = list(col = reference),
             dot.symbol        = list(col = symbol[1]),
             plot.line         = list(col = symbol[1]),
             plot.symbol       = list(col= symbol[1]),
             regions           = list(col = colorRampPalette(region)(100)),
             reference.line    = list(col = reference),
             superpose.line    = list(col = symbol),
             superpose.symbol  = list(col = symbol),
             superpose.polygon = list(col = fill, border = fg),

             background        = list(col = bg),
             add.line          = list(col = fg),
             add.text          = list(col = fg),
             box.dot           = list(col = fg),
             axis.line         = list(col = fg),
             axis.text         = list(col = fg),
             strip.border      = list(col = fg),
             strip.background = list(col = "white"),
             strip.shingle = list(col="grey"),
             box.3d            = list(col = fg),
             par.xlab.text     = list(col = fg),
             par.ylab.text     = list(col = fg),
             par.zlab.text     = list(col = fg),
             par.main.text     = list(col = fg),
             par.sub.text      = list(col = fg))

       if(is.null(extra.args$par.settings))
           extra.args$par.settings <- temp else
           extra.args$par.settings[!names(temp) %in% names(extra.args$par.settings)] <- temp[!names(temp) %in% names(extra.args$par.settings)]
       
       #need to talk to ds?
    }

    #if x is NULL/not formula catcher
    if(is.null(x) || !is(x)[1] == "formula"){
         checkIfMissing(if.missing = settings$if.missing, 
             reply = "need a formula to work with", 
             suggest = "see ?latticePlot if unclear", if.warning = "resetting x to NULL", 
             fun.name = fun.name)
         x <- NULL
    }

    #work out dimensions of conditioning
    cond.dim <- as.character(x)
    temp <- grep("[|]", cond.dim[length(cond.dim)])
    if(length(temp)<1) temp <- 0
    if(temp > 0){
        temp2 <- grep("[+]", cond.dim[length(cond.dim)])
        if(length(temp2)<1) temp2 <- 0
        temp3 <- grep("[*]", cond.dim[length(cond.dim)])
        if(length(temp3)<1) temp3 <- 0
        cond.dim <- temp2 + temp3 + 1
    }

    #set up data
    if(isPEMS(data)) data <- pemsData(data)

    #set up inputs
    temp <- list(x = x, data = data)
    if(!is.null(panel)) temp$panel <- panel
    temp[names(extra.args)] <- extra.args
    
    ans <- do.call(plot, temp)

#    latter
#    if (cond.dim != 2) plot(ans) else plot(useOuterStrips(ans, strip = strip, strip.left = strip.left))

    ans

}





###############################
###############################
##panel.PEMSXYPlot
###############################
###############################



panel.PEMSXYPlot <- function(..., grid=NULL){

    temp <- list(h = -1, v = -1)
    if(is.list(grid))
        temp[names(grid)] <- grid

    do.call(panel.grid, temp)
    panel.xyplot(...)

} 










################################
################################
##XYZPlot
################################
################################

#notes
###################
#may supercede this with something from loa
#



XYZPlot <- function(x = NULL, ..., data = NULL, statistic = NULL, 
                    x.res = 10, y.res = 20, plot = levelplot,
                    fun.name = "XYZPlot"){


    ####################
    #setups
    ####################

    #extra.args

    this.call <- match.call()
    extra.args <- list(...)
    settings <- calcChecks(fun.name, ..., data = data)

    if(isPEMS(data)) data <- pemsData(data)
    
#    if(is.null(subset))
#        subset <- TRUE


    #get structure formula
    d1 <- try(latticeParseFormula(x, data, dimension = 3, 
                                  multiple = TRUE),
              silent = TRUE)
    if(is(d1)[1] == "try-error")
        checkIfMissing(if.missing = settings$if.missing, reply = "mismatched 'x/data' data combination", 
                       suggest = "see ?XYZPlot for help", fun.name = fun.name)

    ##################
    #statistcs handling 
    ##################

    #if missing 
    #if no z count of cases
    # if z mean
    if(is.null(statistic)){
        if(is.null(d1$left)){
            d1$left <- rep(1, length(d1$right.x))
            d1$left.name <- "count"
            statistic <- function(x) length(na.omit(x))
        } else {
            statistic <- function(x) mean(x, na.rm=TRUE)
        }
    }


    ##################
    #range settings 
    ##################

    #note axis are flipped 
    #relative to lattice

    ylim <- if("ylim" %in% names(extra.args))
                extra.args$ylim else range(d1$right.x, na.rm=TRUE)

    xlim <- if("xlim" %in% names(extra.args))
                extra.args$xlim else range(d1$right.y, na.rm=TRUE)

#temp disabled

    ylim <- range(d1$right.x, na.rm=TRUE)

    xlim <- range(d1$right.y, na.rm=TRUE)



    #################
    #make grids
    #################

#tidy

    if(!is.numeric(x.res))    
          x.res <- 10
    if(!is.numeric(y.res))    
          y.res <- 10

    x.res <- do.breaks(xlim, x.res)
    y.res <- do.breaks(ylim, y.res)

    x <- cut(d1$right.y, x.res)
    y <- cut(d1$right.x, y.res)

#add in here conditioning

    temp <- data.frame(x=x, y=y)

    ans <- aggregate(d1$left, temp, statistic) 
    names(ans)[ncol(ans)] <- "z"

    #tidy names

#    temp <- gsub("[(]|[)]|[[]|[]]", "", levels(ans[,1]))

    temp.fun <- function(x){
                    temp <- gsub("[(]|[)]|[[]|[]]", "", x)
                    t1 <- as.numeric(unlist(strsplit(temp, ","))[seq(1, 40, 2)])
                    t2 <- as.numeric(unlist(strsplit(temp, ","))[seq(2, 40, 2)])
                    temp <- signif(((t2 - t1) / 2) + t1, 2)
    }
    levels(ans[,1]) <- temp.fun(levels(ans[,1]))
    levels(ans[,2]) <- temp.fun(levels(ans[,2]))
     
    #tidy the ...
    #or it will fall over
 #   map.axis <- function(components, ...) 
 #                  axis.default(components = list(check.overlap=TRUE) ...)

    if(!"ylab" %in% names(extra.args))
        extra.args$ylab <- d1$right.x.name
    if(!"xlab" %in% names(extra.args))
        extra.args$xlab <- d1$right.y.name
    if(!"zlab" %in% names(extra.args))
        extra.args$zlab <- d1$left.name

    temp <- list(x = z~x*y, data=ans)
    temp[names(extra.args)] <- extra.args

    do.call(plot, temp)

}    
    

#return(ans)


#############
#cond currently 
#dissabled
#############

#    cond.res <- 0
#    if(length(d1$condition)>0){
#        cond.res <- levels(d1$condition[[1]])
#        cond <- d1$condition[[1]]
#    }
    

#    grid <- expand.grid(x = x.res, y = y.res)

        

    

#return(d1)

    ###################
    #



#}