\name{2.3.2.vsp.calculations}
\alias{2.3.2.vsp.calculations}
\alias{vsp.calculations}
\alias{vsp}
\alias{calcVSP}
\alias{calcVSPJimenezPalaciosCMEM}


\title{
  Vehicle Specific Power (VSP) calculations
}

\description{
  Functions associated with VSP calculations.
}

\usage{

calcVSP(speed = NULL, accel = NULL, slope = NULL, 
          time = NULL, distance = NULL, data = NULL,
          calc.method = calcVSPJimenezPalaciosCMEM,
          ..., fun.name = "calcVSP", this.call = NULL, 
          hijack= FALSE)

calcVSPJimenezPalaciosCMEM(speed = NULL, accel = NULL, 
          slope = NULL, m = NULL, a = NULL, b = NULL, 
          c = NULL, g = NULL, ..., data = NULL,  
          fun.name = "calcVSPJimenezPalaciosCMEM", 
          this.call = NULL, hijack= FALSE)

}




\arguments{

  \item{speed, accel, slope, time, distance}{
  (Data series, typically vectors) The inputs to use when doing a calculation. See 
  Note about \code{calcVSP} usage and \code{calc.method}.
} 

  \item{data}{
  (Optional \code{data.frame} or \code{pems} object) The data source if either a 
  \code{data.frame} or \code{pems} object is being used.
} 

  \item{calc.method}{
  (Required function) The function to use to calculate VSP. (default 
  \code{calcVSPJimenezPalaciosCMEM}). See Note about \code{calcVSP} usage and 
  \code{calc.method}.
}

  \item{\dots}{
  (Optional) Other arguments, currently passed on to function provided as 
  \code{calc.method} (default \code{calcVSPJimenezPalaciosCMEM}) and appropriate 
  \code{\link{check...}} functions.
}

  \item{fun.name}{
  (Optional character) The name of the parent function, to be used in error messaging.
}

  \item{this.call}{
  (Optional) Initial call, should generally be ignored. See code{\link{common.calculations}} 
  for further details.
}

  \item{hijack}{
  (Logical) Is this function being locally 'hijacked' by a user/function developer? See Note on 
  \code{hijack} below.
}

  \item{m, a, b, c, g}{
  (Numerics) VSP constants. If not supplied or preset in the associated \code{pems} object, defaults 
  are applied. See Below.
}

    
}


\details{

  \code{calcVSP...} functions calculate VSP using.

  \code{calcVSP} is a wrapper function which allows users to supply different combinations 
  of inputs. VSP calculations typically require speed, acceleration and slope inputs. This 
  wrapper allows different input combinations, e.g.:

  time and distance (time and distance -> speed, time and speed -> accel)
 
  time and speed (time and speed -> accel)

  speed and accel

  ... and passes on speed and accel to the method defined by \code{calc.method}. (This means 
  all VSP functions run via \code{calcVSP(..., calc.method = function)} share this option 
  without needed dedicated code and only required speed and accel as inputs.)

  \code{calcVSPJimenezPalaciosCMEM} calculates VSP according to Jimenez Palacios and CMEM methods. 
  See References and Note below.
 
}


\value{

  \code{calcVSPJimenezPalaciosCMEM} and \code{calcVSP} by default use Jimenez Palacios and CMEM 
  methods to calculate VSP (in kW/metric ton).

}


\section{Warning }{
  \code{calcVSPJimenezPalaciosCMEM} does not currently have special case for buses as of 
  Giannelli et al (2005). (Please let me know if you need to use them.)  
}

\note{

  \code{calcVSP...} constants can be set/modified in the calculation call, e.g. 
  \code{calcVSP(..., a = [new.value])}. If not supplied these are first checked for 
  in the associated \code{pems} object (if supplied), or set to default values. See 
  References. If VSP constants are to be added to a \code{pems} object, these should 
  have the prefix 'vsp.', so for, e.g., \code{a} is stored in pems constants are 
  \code{vsp.a}. This is because the common VSP designations (\code{a}, \code{b}, \code{c}, 
  etc.) can be very easily wrongly assigned. 
  
  Unit handling in \code{pems.utils} is via \code{\link{checkUnits}}, \code{\link{getUnits}}, 
  \code{\link{setUnits}} and \code{\link{convertUnits}}. See \code{\link{common.calculations}} 
  for details.

  \code{hijack} is an in-development argument, supplied to allow code developers to run multiple 
  functions in different function environments. When developers 'mix and match' code from 
  several sources it can become unstable, especially if functions are run within functions within 
  functions, etc. \code{hijack = TRUE} and associated code makes a function local to 'side-step' 
  this issue. This work by assuming/expecting all inputs to be local, i.e. supplied directly by 
  the code user.          
 
}



\seealso{
  See \code{\link{common.calculations}} (and \code{\link{checkInput}}, \code{\link{checkUnits}} and 
  \code{\link{convertUnits}}) for details of data management.
}

\author{
  Karl Ropkins
}

\references{
  
 \code{calcVSPJimenezPalaciosCMEM} uses methods described in:

 Jimenez-Palacios, J.L. (1999) Understanding and Quantifying Motor Vehicle Emissions with 
 Vehicle Specific Power and TILDAS Remote Sensing. PhD Thesis, Massachusetts Institute of 
 Technology, Cambridge, MA.

 Giannelli, R.A., Nam, E.K., Helmer, K., Younglove, T., Scora, G., and Barth, M. (2005) 
 Heavy-Duty Diesel Vehicle Fuel Consumption Modelling Based on Road Load and Power Train 
 Parameters. SAE Technical Papers, No, 05CV-3.

 \code{m} is the vehicle mass (in metric tons), and \code{a}, \code{b}, \code{c} and \code{g} 
 are the calculations constants for:

 \code{vsp = speed * (a * accel + (g * slope) + b) + (c * speed^3)}

 For vehicles < 3.855 metric tons; a = 1.1, and c = 0.000302 (as of Jimenez-Palacios, 1999).

 For vehicles 3.855 to 6.350 metric tone; a = 0.0996m/2204.6, c = 1.47 + 5.22e-5m/2205 (as of 
 Giannelli et al, 2005).

 For vehicles 6.350 to 14.968 metric tone; a = 0.0875m/2204.6, c = 1.93 + 5.90e-5m/2205 (as of 
 Giannelli et al, 2005).

 For vehicles > 14.968 metric tone; a = 0.0661m/2204.6, c = 2.89 + 4.21e-5m/2205 (as of 
 Giannelli et al, 2005).

 In all cases, by default b = 0.132, g = 9.81, and if not supplied \code{slope} is assumed to be 
 zero and \code{m} is assumed to 1.5 metric tons.

}


\examples{

###########
##example 1 
###########

#basic usage

vsp <- calcVSP(velocity, time = local.time, data = pems.1)

#where vsp, the returned object, is supplied as a pems.element

}

\keyword{ methods }
