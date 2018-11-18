########################
########################
##export.pems.data
########################
########################

#in place
#################
#pemsData
#



#TO DO
################
#tidy
#document
#



#questions
###################
#develop this subject to requests 
#





########################
########################
##exportPEMSData
########################
########################

#version 0.2.0
#karl 17/09/2010


exportPEMSData <- function(data, file="tempfile", ..., sep="\t", file.writer = write.table,
                       row.names = FALSE){

    if(isPEMS(data))
        data <- pemsData(data)

    file.writer(data, file = file, sep="\t", row.names = row.names)

}



########################
########################
##
########################
########################


#versions 0.1.2
#karl 18/11/2016

exportPEMS2CSV <- function(pems, file = "tempfile", ...){

     #this take a pems object, tidies it and saves it as file.name 
     #this is a file which you should be able to open in excel

     #excel.headers = pems names + (units) if units set
     #note: earlier versions used pems names _units

     #remove special columns
     if("..count" %in% names(pems))
           pems <- pems[names(pems)!="..count"]

     #get units
     units <- unlist(c(as.vector(units(pems))))

     #add units to names
     col.names <- names(pems)
     #this might seem long-winded but it stops pems object
     #mucking up if element orders in pems[[data]] and pems[[units]] are different 

###############
#replacing
##     for(i in col.names)
##          col.names[col.names==i] <- if(!is.na(units(pems)[col.names==i]) && units(pems)[col.names==i]!= "")
##                            paste(i, units(pems)[col.names==i], sep="_") else i
#with
     for(i in col.names)
          col.names[col.names==i] <- if(!is.na(units(pems)[col.names==i]) && units(pems)[col.names==i]!= "")
                            paste(i, "(", units(pems)[col.names==i], ")", sep="") else i
###############

###################
#this does not write units nicely to excel
#if I make this character vector rather than names
#that would be neater but then need to write to csv
###################
#remove names from data and then
#col.names might do this
###################

     #add .csv extension if missing
     if(grepl("[.]csv$", tolower(file))!=TRUE)
            file <- paste(file, ".csv", sep="")    
     
     #output
##########################
#could move args to formals or .../listUpdate
##########################

     #write.csv(pems,...) would work because write...(x,...) 
     #converts x to data.frame if not a data.frame or matrix
     #so like write.csv(as.data.frame(pems),...)
     ##pems <- as.data.frame(pems)
     ##names(pems) <- NULL
       
     write.table(as.data.frame(pems), file = file, col.names = col.names, row.names = FALSE, na = "", sep=",")
}










