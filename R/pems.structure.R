########################
########################
##pems.structure
########################
########################

#pemsElement (gone 2018/06/30 0.2.25.17)
#pemsElement.old (gone 2018/06/30 0.2.25.17)
#pemsin, pemsin2, pemsin2.old (gone 2018/06/30 0.2.25.17)


#in place
#################
#getPEMSElement



#other pems... function under review
########################################
#pemsData
#pemsConstants
#pemsHistory
#pemsDim




#next project
################
#getPEMSData/pemsData


#TO DO
##########################
#pemsConstants
#tidy
#document
#namespace





#questions
###################
#is this better than check...
#do functions need a test that first element is pems, etc?
#




########################
########################
##getPEMSElement
########################
########################

#version 0.3.0
#karl 22/06/2018

#getPEMSElement replaces pemsElement
#pemsElement using rlang/dplyr

#getElement already used...

#########################
#need to think about
#########################
#if.missing warning
#attribute name handling
#attribute units handling


getPEMSElement <- function (x, pems = NULL, units = NULL, ..., 
                         fun.name = "getPEMSElement", if.missing = "stop",
                         .x = enquo(x)){

#################################################
#I guess there must be a better way of doing this
#but I am not seeing it
#################################################

    #################################################
    #I die if arg is missing
    #################################################
    #element.name <- quo_name(.x)
    #test...
    #NB if quo_is_null(.x) that means x is null because nothing to do???

    ref.name <- if(is.null(list(...)$ref.name)) "element" else list(...)$ref.name
    ##element.name <- try(quo_name(.x), silent=TRUE)
    if(quo_is_null(.x)){
         checkIfMissing(if.missing = if.missing,
                       reply = paste("required ", ref.name, " NULL", sep=""),
                       suggest = "checking call arguments", 
                       if.warning = NULL, 
                       fun.name = fun.name)
         return(NULL)
    }
    element.name <- quo_name(.x)    

    ans <- if (is.null(pems)) NULL else 
                try(pems[element.name], silent = TRUE)
###############
#testing cond eval
    if (is.null(ans) | class(ans)[1] == "try-error") {
        ans <- try(eval_tidy(enquo(x), pemsData(pems)), silent=TRUE)
    }
#################

    if (is.null(ans) | class(ans)[1] == "try-error") {
             ans <- try(eval_tidy(.x), silent = TRUE)
    }
    if (is.null(ans) | class(ans)[1] == "try-error") {
             ans <- try(eval_tidy(x), silent = TRUE)
    }
    if (class(ans)[1] == "try-error") 
             ans <- NULL
    if(is.null(ans))
         checkIfMissing(if.missing = if.missing,
                       reply = paste(ref.name, " '", element.name[1], "' not found or NULL", sep=""),
                       suggest = "checking call arguments", 
                       if.warning = NULL, 
                       fun.name = fun.name) 

#no name attribute management
    #pass ref to convertUnits?
#no option if units are set but ans does not have units...

    if (!is.null(units) & !is.null(ans)) 
        ans <- convertUnits(ans, to = units)
    ans
}




#########################
#########################
##testPEMS
#########################
#########################

#version 0.0.1
#karl 24/06/2018

#this is a general test for several of the getPEMS... functions
#might not export it....

#this kills function if missing and if.missing="stop"
#returns NULL, FALSE or TRUE

testPEMS <- function(pems=NULL, fun.name = "testPEMS", if.missing = "stop",
         .pems = enquo(pems), ...){

    if(quo_is_null(.pems)){
         checkIfMissing(if.missing = if.missing,
                       reply = paste("required pems NULL", sep=""),
                       suggest = "checking call arguments", 
                       if.warning = NULL, 
                       fun.name = fun.name)
         return(NULL)
    }
    pems.name <- quo_name(.pems)
    if(is.null(pems)){
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not found", sep=""),
               suggest = "checking call arguments", 
               if.warning = NULL, 
               fun.name = fun.name)
         return(NULL)
    }
    if(!"pems" %in% class(pems)) {
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not a pems", sep=""),
               suggest = "checking pems", 
               if.warning = NULL, 
               fun.name = fun.name)
        return(FALSE)
    }
    TRUE
}



##############################
##############################
##getPEMSConstants
##############################
##############################

#replacing pemsConstants

getPEMSConstants <- function(pems=NULL, ..., 
         fun.name = "getPEMSConstants", if.missing = "stop",
         .pems = enquo(pems)){

    test <- testPEMS(pems, fun.name=fun.name, if.missing=if.missing, 
             .pems=.pems)
    if(is.logical(test) && test) pems[["constants"]] else NULL
}



##############################
##############################
##getPEMSData
##############################
##############################

#replacing with pemsData

getPEMSData <- function(pems=NULL, ..., 
         fun.name = "getPEMSData", if.missing = "stop",
         .pems = enquo(pems)){

#################
#might want to include option for 
#more aggressive conversions
#################

    test <- testPEMS(pems, fun.name=fun.name, if.missing=if.missing, 
             .pems=.pems)
    if(is.logical(test) && test) pems[["data"]] else NULL
}




























##############################
##############################
##pemsData
##############################
##############################


pemsData <- function(pems=NULL, ..., 
         fun.name = "pemsData", if.missing = "stop",
         pems.name = deparse(substitute(pems))){

    if(is.null(pems)){
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not found", sep=""),
               suggest = "checking call arguments", 
               if.warning = NULL, 
               fun.name = fun.name)
    }
    #class(pems) <- "not.pems"
    #pems$data

#new build
#might want to strip out units, etc...?

    pems <- rebuildPEMS(pems)
    as.data.frame(pems)

}




##############################
##############################
##pemsConstants
##############################
##############################

#replacing with getPEMSContansts


pemsConstants <- function(pems=NULL, ..., 
         fun.name = "pemsConstants", if.missing = "stop",
         pems.name = deparse(substitute(pems))){

    if(is.null(pems)){
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not found", sep=""),
               suggest = "checking call arguments", 
               if.warning = NULL, 
               fun.name = fun.name)
    }
    pems <- rebuildPEMS(pems, "old")
    class(pems) <- "not.pems"
    pems$constants

}










##############################
##############################
##pemsHistory
##############################
##############################


pemsHistory <- function(pems=NULL, ..., 
         fun.name = "pemsHistory", if.missing = "stop",
         pems.name = deparse(substitute(pems))){

    if(is.null(pems)){
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not found", sep=""),
               suggest = "checking call arguments", 
               if.warning = NULL, 
               fun.name = fun.name)
    }
    pems <- rebuildPEMS(pems, "old")
    class(pems) <- "not.pems"
    pems$history

}








##############################
##############################
##pemsDim   
##############################
##############################


pemsDim <- function(pems=NULL, ..., 
         fun.name = "pemsDim", if.missing = "stop",
         pems.name = deparse(substitute(pems))){

    if(is.null(pems)){
          checkIfMissing(if.missing = if.missing,
               reply = paste("pems '", pems.name[1], "' not found", sep=""),
               suggest = "checking call arguments", 
               if.warning = NULL, 
               fun.name = fun.name)
    }
    pems <- rebuildPEMS(pems, "old")
    class(pems) <- "not.pems"
    dim(pems$data)

}





