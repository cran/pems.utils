\name{2.3.1.common.calculations}
\alias{2.3.1.common.calculations}
\alias{common.calculations}
\alias{calcDistance}
\alias{calcSpeed}
\alias{calcAccel}
\alias{calcAcceleration}
\alias{calcJerk}
\alias{calcChecks}
\alias{calcPack}


\title{
  Common calculations
}

\description{
  Various common calculations associated with PEMS data.
}

\usage{


calcDistance(speed = NULL, time = NULL, data = NULL, 
          ..., fun.name = "calcDistance", hijack= FALSE)

calcSpeed(distance = NULL, time = NULL, data = NULL, 
          ..., fun.name = "calcSpeed", hijack= FALSE)


calcAccel(speed = NULL, time = NULL, data = NULL, 
          ..., fun.name = "calcAccel", hijack= FALSE)

calcAcceleration(...)

calcJerk(accel = NULL, time = NULL, data = NULL, 
          ..., fun.name = "calcJerk", hijack= FALSE)

#associated

calcChecks(fun.name = "calcChecks", ..., data = NULL,
          if.missing = c("stop", "warning", "return"), 
          output = c("input", "data.frame", "pems", "special"),
          unit.conversions = NULL, overwrite = FALSE)

calcPack(output = NULL, data = NULL, settings = NULL, 
          fun.name = "calcPack", this.call = NULL)

}




\arguments{

  \item{speed, time, distance, accel}{
  (Required data series typically vectors) The inputs to use when doing a calculation. These 
  can typically be vectors or elements in either a \code{data.frame} or \code{pems} object.
} 

  \item{data}{
  (Optional \code{data.frame} or \code{pems} object) The data source if either a \code{data.frame} 
  or \code{pems} object is being used.
} 

  \item{\dots}{
  (Optional) Other arguments, currently passed on to \code{calcChecks}.
}

  \item{fun.name}{
  (Optional character) The name of the parent function, to be used in error messaging.
}

  \item{hijack}{
  (Logical) Is this function being locally 'hijacked' by a user/function developer? See Note on 
  \code{hijack} below.
}

  \item{if.missing, output, unit.conversions, overwrite, settings, this.call}{
  (Various) Along with \code{data} and \code{fun.name}, arguments used by \code{calcCheck} and 
  \code{calcPack} to manage error and unit handling and workhorse \code{calc...} operations. These 
  are typically passed to the appropriate \code{check...} or \code{...Units} function for evaluation. 
  See Details, Note and Examples below. 

}
    
}


\details{

  With the exception of \code{calcChecks}, \code{calc...} functions do common 
  calculations.

  \code{calcDistance} calculates distance (in m) using speed and time.    

  \code{calcSpeed} calculates speed (in m/s) using distance and time.

  \code{calcAccel} calculates acceleration (in m/s/s) using speed and time.

  \code{calcJerk} calculates jerk (rate of change of acceleration in m/s/s/s) using 
  acceleration and time.

  By default results are returned as \code{pems.elements}. Other options include 
  returning as the original data plus the results as either a \code{data.frame} or a 
  \code{pems} object. One final option is to return the results in the supplied 
  format. So, for example, uf: inputs are supplied as vectors, the answer is returned 
  as a vector; If inputs are supplied in a \code{pems} object, that \code{pems} object 
  is returned with the answer added in. This behaviour is enabled by the default 
  \code{output = "special"}. 

  Unit management is by \code{\link{convertUnits}}. See Note below. 

  The extra functions \code{calcChecks} and \code{calcPack} are add-ins that anyone can use 
  to develop other similiar functions. They are add at the start and end of standard 
  \code{calc...} functions to provide a 'minimal code' mechanism for the integrating 
  of third-party code. See Note and Example 3 below. 
 
}


\value{

  With the exception of \code{calcChecks} and \code{calcPack}, all \code{calc...} functions 
  return either a vector, \code{data.frame} or \code{pems} object, depending on \code{output} 
  and \code{data} settings.

}

\references{
  References in preparation.
}
\author{
  Karl Ropkins
}
\note{

  Unit handling in \code{pems.utils} is via \code{\link{checkUnits}}, \code{\link{getUnits}}, 
  \code{\link{setUnits}} and \code{\link{convertUnits}}. Allowed unit conversion methods have 
  to be defined in \code{\link{ref.unit.conversions}} or a locally defined alternative supplied 
  by the user. See \code{\link{convertUnits}} for an example of how to locally work with unit 
  conversions.

  \code{hijack} is an in-development argument, supplied to allow code developers to run multiple 
  functions in different function environments. When developers 'mix and match' code from 
  several sources it can become unstable, especially if functions are run within functions within 
  functions, etc. \code{hijack = TRUE} and associated code makes a function local to 'side-step' 
  this issue. This work by assuming/expecting all inputs to be local, i.e. supplied directly by 
  the code user. See Example 3 below.         
 
}

%\section{Warning }{
%  No warnings
%}

\seealso{

  \code{\link{calcVSP}} for VSP calculations. \code{\link{calcEm}} for emissions calculations.
 
  \code{\link{getElement}} (\code{\link{checkInput}} if passing elements as inputs), \code{\link{checkUnits}} 
  and \code{\link{convertUnits}} for data management.

}
\examples{

###########
##example 1 
###########

#basic usage

#calculated accel as pems.element

calcAccel(velocity, local.time, pems.1)

#answer returned as suppied pems + calculated accel

calcAccel(velocity, local.time, pems.1, output = "pems")

#or, if you would rather... 
#ans <- pems.1
#ans$accel <- calcAccel(velocity, local.time, pems.1)


###########
#example 2
###########

#making wrappers for routine data processing 

my.pems <- list(pems.1, pems.1)

sapply(my.pems, function(x) 
                  calcAccel(velocity, local.time, data=x))

#ans = accel data series for each pems in my.pems list

#             [,1]        [,2]
# [1,]  0.00000000  0.00000000
# [2,]  0.00000000  0.00000000
# [3,]  0.05555556  0.05555556
# [4,]  0.00000000  0.00000000
# [5,] -0.02777778 -0.02777778
# [6,]  0.05555556  0.05555556
# ...

#or
#lapply(my.pems, function(x) 
#                  calcAccel(velocity, local.time, data=x, output="pems"))
#for output as a list of pems objects with accel added to each

#note:
#sapply if you can/want to simiplify outputs
#lapply if you want to keep output as a list of answers


###########
#example 3
###########

#making a function that allows third party hijack
#and pems management

my.fun <- function(speed, time, data = NULL, hijack = FALSE, 
                   ..., fun.name = "my.function"){

    #setup
    this.call <- match.call()
    
    #run checks
    settings <- calcChecks(fun.name, ..., data = data)
    
    #get pems elements if not already got
    if(!hijack){
 
        #the check handle errors and error messaging
        #checkInput 
        speed <- checkInput(speed, data, fun.name = fun.name,   
                            if.missing = settings$if.missing,
                            unit.conversions = settings$unit.conversions)

        time <- checkInput(time, data, fun.name = fun.name,   
                            if.missing = settings$if.missing,
                            unit.conversions = settings$unit.conversions)
    }

    #any extra error/missing case handling? 

    #run 'hijacked' code

    #reset units to what you want
    #... allows you to pass local unit.conversions
    speed <- convertUnits(speed, to = "km/h", hijack = TRUE, 
                          if.missing = settings$if.missing,
                          unit.conversions = settings$unit.conversions)

    #use someone else's calculation
    distance <- calcDistance(speed, time, hijack = TRUE, 
                          if.missing = settings$if.missing,
                          unit.conversions = settings$unit.conversions)

    #do other stuff?

    #reset units again?

    #output
    #calcPack handling the output type  
    #and my pems history tracking if data modified
    calcPack(output = distance, data = data, settings = settings, 
             fun.name = fun.name, this.call = this.call)     

}

ans <- my.fun(velocity, local.time, pems.1, output="pems")

#seems long winded but gives you control of 
##the error handling, unit management, and output type
##and (if working in pems objects) history logging 

##and lets you do this

ans <- lapply(my.pems, function(x) 
                  my.fun(velocity, local.time, data=x, output="pems"))

#which will not always work if you are running 
#functions in functions, especially if those functions
#are also running functions in functions...


}

\keyword{ methods }
