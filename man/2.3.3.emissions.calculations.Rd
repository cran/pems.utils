\name{2.3.3.emissions.calculations}
\alias{2.3.3.emissions.calculations}
\alias{emissions.calculations}
\alias{emissions}
\alias{em}
\alias{calcEm}
\alias{calcEmHoribaPitot}


\title{
  Emission calculations
}

\description{
  Functions associated with emissions calculations.
}

\usage{

calcEm(conc = NULL, time = NULL, calc.method = calcEmHoribaPitot, 
          analyte = NULL, ..., data = NULL, fun.name = "calcEm", 
          force = FALSE, this.call = NULL, hijack= FALSE)

calcEmHoribaPitot(conc = NULL, time = "local.time", exflow = "exh.flow.rate", 
          extemp = "exh.temp", express = "exh.press", analyte = NULL, 
          delay = NULL, mm = NULL, ..., force = force, data = NULL, 
          fun.name = "calcEmHoribaPitot", this.call = NULL, hijack= FALSE)

}




\arguments{

  \item{conc}{
  (Data series, typically vector) Analyte/species concentrations, the main input for 
  calculating emissions. If \code{conc} is a concentration data series from a standard 
  \code{pems} source it should be named \code{conc.[analyte]} and \code{pems.utils} will 
  manage it accordingly. See below for further details.
}

  \item{time, exflow, extemp, express}{ 
  (Data series, typically vectors) Other inputs used when calculating emissions. The 
  combination depending on the calcuation method used (and set by \code{calc.method}).
} 

  \item{calc.method}{
  (Required function) The function to use to calculate emissions. (Default 
  \code{calcEmHoribaPitot}). See below for further details.
}

  \item{analyte}{
  (Optional character vector) The analyte emissions are to be calculated for. If supplied,
  this is used as a reference when assigning molecule weight and other analyte properties 
  if these are not provided as part of calculate call. If not supplied, \code{pems.utils} 
  attempts to recover these from available sources, e.g. \code{data} if supplied as part 
  of the calculation call or package references such as \code{\link{ref.chem}}.   
}

  \item{\dots}{
  (Optional) Other arguments, currently passed on to function provided as 
  \code{calc.method} (default \code{calcEmHoribaPitot}) and appropriate 
  \code{\link{check...}} functions.
}

  \item{data}{
  (Optional \code{data.frame} or \code{pems} object) The data source if either a 
  \code{data.frame} or \code{pems} object is being used.
} 

  \item{fun.name, hijack, this.call, force}{
  (Various pems management functions) \code{fun.name} (character vector) the name of the 
  parent function, to be used in error messaging. \code{hijack} (logical) Is this function being 
  locally 'hijacked' by a user/function developer? See Note on \code{hijack} below. 
  \code{this.call} the initial call (can generally be ignored) \code{force} 
  (Logical) Should \code{calcEm} and \code{calc.method} ignore any error checking, e.g. 
  units assignments, and do calculations anyway?
}

  \item{delay, mm}{
  (Optional numerics) Emissions calculation constants. \code{delay} is the time delay between 
  \code{conc} measurements and other timeseries. \code{mm} is the molecular mass of the 
  analyte. If supplied, these in-call values supercede any preset values previously assigned to 
  these constants, e.g. in the associated \code{pems} object or package \code{look-up.tables}.
}

    
}


\details{

  \code{calcEm...} functions calculate emissions.

  \code{calcEm} is a wrapper function which is intended to provide a conventient front for 
  emissions calculation methods. It accepts an input code{conc} which it checks and passes 
  on to \code{calc.method}, along with other supplied arguments. 

  \code{calcEmHoribaPitot} calculates emissions using methods described in the Horiba OBS 
  Operators Manual. In addition to \code{conc}, the function requires the time, and exhaust 
  flow data series (measured by the OBS Pitot flow meter). By default, the function assumes 
  that these are default names that are generated for these when standard OBS files are 
  imported into \code{R} using the \code{pems.utils} import function \code{\link{importOBS2PEMS}}. 
  See References and Note below. 
 
}


\value{

  \code{calcEmHoribaPitot} (and \code{calcEm} by default) use Horiba Manual methods to 
  calculate emissions (in g/s).

}

\references{
  
 \code{calcEmHoribaPitot} uses methods described in:

 The Horiba Operators Manual.  

}
\author{
  Karl Ropkins
}
\note{

  \code{calcEm...} constants can be set/modified in the calculation call, e.g. 
  \code{calcEm(..., delay = [new.value])}. If not supplied, these are first checked for 
  in the associated \code{pems} object (if supplied), or set to default values. See 
  References. If analyte-related constants are to be added to a \code{pems} object, 
  these should be named in the format '[type].[analyte]', e.g. \code{delay.co} for 
  the \code{delay} constant to be used for the analyte CO.   
  
  Unit handling in \code{pems.utils} is via \code{\link{checkUnits}}, \code{\link{getUnits}}, 
  \code{\link{setUnits}} and \code{\link{convertUnits}}. See \code{\link{common.calculations}} 
  for details.

  \code{hijack} is an in-development argument, supplied to allow code developers to run multiple 
  functions in different function environments. When developers 'mix and match' code from 
  several sources it can become unstable, especially if functions are run within functions within 
  functions, etc. \code{hijack = TRUE} and associated code makes a function local to 'side-step' 
  this issue. This works by assuming/expecting all inputs to be local, i.e. supplied directly by 
  the code user.          
 
}


\seealso{
  See \code{\link{common.calculations}} (and \code{\link{checkInput}}, \code{\link{checkUnits}} and 
  \code{\link{convertUnits}}) for details of data management.
}
\examples{

###########
##example 1 
###########

#basic usage

em.co <- calcEm(conc.co, data = pems.1)

#em.co pems.elements




}

\keyword{ methods }
