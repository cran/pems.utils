\name{7.4.speed.em.code}
\alias{7.4.speed.em.code}
\alias{speed.em.code}
\alias{speed.em}
\alias{fitSpeedEm}
\alias{speedEmPlot}

\title{
  Speed Emissions related code
}

\description{
  Functions associated with Speed/Emissions terms.
}

\usage{

#calculations

fitSpeedEm(em, time, speed, engine.on = NULL,
           data = NULL, method = 1, min.speed = 5,
           bin.size = NULL, ..., 
           fun.name="fitEmSpeed")
                       
#speed/emissions Plots

speedEmPlot(speed, em = NULL, time = NULL, 
         ..., data = NULL, engine.on = NULL,
         min.speed = 5, bin.size = NULL,  
         plot.type = 1, method = 1,
         fun.name="speedEmPlot")

}

\arguments{

  \item{em, time, speed}{
  (Typically pems.element vectors) \code{em} is the (g/s) 
  emissions data-series; \code{speed} and \code{time} are 
  the associated speed profile and time-series. 
} 
  \item{engine.on}{
  (Optimal, single Numeric) The time the emission source, e.g. 
  monitored vehicle engine, was started. If not supplied, this 
  is assumed to be start of the supplied \code{em} and 
  \code{time} data-series. See also Notes.
}

  \item{data}{
  (Optional, typically \code{pems}) The data source for 
  \code{em}, \code{speed} and \code{time}.
} 

  \item{method}{
  (Optinal, Numeric) The method to use when calculating 
  and binning data: method \code{1} calculate g/km emissions 
  and bin by row. See also \code{bin.size}, Notes and 
  References.
}  

  \item{min.speed}{
  (Optinal, Numeric) measurements when speeds were less than 
  this value are exluded, default value \code{5}. See also 
  Notes.
}  

  \item{bin.size}{
  (Optinal, Numeric) The data binning scale to use. For 
  \code{method 1}, this is the number of rows of 
  measurements to merge. 
}  

  \item{\dots}{
  (Optional) Other arguments, currently passed on as supplied 
  to associated calculation or plotting function, or back to 
  pemsPlot.
}

  \item{fun.name}{
  (Optional character) The name of the parent function, to be 
  used in error messaging.
}

  \item{plot.type}{
  (Optional numeric) For \code{speedEmPlot}, the type of 
  speed/emission plot to generate: 1 a conventional 
  scatter plot; or 2 a box-and-whisker plot. If not supplied, 
  plot type 1 is 
  selected by default. 
}

}


\details{

  \code{fitSpeedEm} builds a speed and g/km emissions 
  data sets for the supplied emissions, speed and 
  time-series data. 
  
  \code{speedEmPlot} generates a plot of one or more 
  data set generated by \code{fitSpeedEm}. 
  
}


\value{

  \code{fitSpeedEm} generates a speed/emissions contribution 
  report as a \code{pems} dataset. 

  \code{speedEmPlot} generates a speed/emissions contribution 
  report as a \code{lattice} plot. 

}

\note{
  
  Regarding \code{engine.on}: This is specifically the time 
  the engine is turned on rather than the row of data set 
  where this happens. In some cases, they are same, e.g. when 
  the data is logged at a regular 1-Hz and data capture is 
  complete. 
  
  Regarding \code{method}: Method 1 [Doc further]. 
  
  [Doc further] 
  
  (See References.) 

}

\seealso{

  See \code{\link{common.calculations}} (and 
  \code{\link{checkUnits}} and 
  \code{\link{convertUnits}}) for details of data management.
}

\author{
  Karl Ropkins
}

\references{
  
 \code{fitColdStart} uses methods described in:
 
 [COPERT on speed/emission terms]
 
 [Ropkins speed/emissions]

}


\examples{

###########
##example 1 
###########

#basic usage

#to do/maybe not run... time to compile...

}

\keyword{ methods }
