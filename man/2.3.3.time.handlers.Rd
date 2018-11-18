\name{2.3.3.time.handlers}
\alias{2.3.3.time.handlers}
\alias{time.handlers}
\alias{regularize}
\alias{repairLocalTime}

\title{
  pems Data Time Handlers
}

\description{
  Time handlers are subset of \code{pems.utils} functions that 
  work on or with time records (\code{time.stamp} and 
  \code{local.time}).  
}

\usage{

regularize(data, Hz=1, ...)

repairLocalTime(data, local.time, ref, ..., reset.count = TRUE,
      fun.name = "repairLocalTime")

}


\arguments{

  \item{data}{
   (Required, typically \code{pems}) The dataset to be worked with. 
   For \code{regularize}, the dataset to regularize (see below). 
   }

  \item{Hz}{
   (For \code{regularize}) (Required numeric) The time resolution to 
   regularize the data to in Hertz. So, the default, \code{Hz=1} is 
   one measurement (or row of data) per second.  
   }

  \item{\dots}{
   (Optional) Other arguments, typically passed on. 
   }
   
   \item{local.time}{
   (For \code{repairLocalTime}) (Required pems.element) The 
   \code{local.time} \code{pems.element} to work been repaired. 
   }
   
   \item{ref, reset.count}{
   (For \code{repairLocalTime}) (Other arguments) \code{ref} is 
   a second source that local.time can be inferred from in cases 
   where \code{local.time} records are missing. If \code{TRUE}, 
   \code{reset.count} resets \code{local.time} so it starts at 0. 
   }
   
   \item{fun.name}{
   (\code{character}) (\code{pems} handler) argument used by 
   \code{pems.utils}. These can typically be ignored. 
   }

}

\details{
  \code{regularize} attempts to extrapolate a regular series, generated at the 
  time resolution requested, from the supplied \code{data}. It can be useful 
  for the regularization of irregularly time-logged data and 
  for hole-filling missing records but should not be used aggressively, 
  to convert 1Hz to 10Hz data.  
  
  \code{repairLocalTime} attempts to repair an incomplete \code{local.time} 
  record. For example, if you merge two datasets with overlapping but 
  different time ranges, one may not track the time range of the other and 
  this can generate incomplete time records. This function attempts to 
  hole-fill such cases.

}


\value{
   \code{regularize} returns the supplied dataset (\code{data}) with time-series 
   (\code{time.stamp} and \code{local.time}) are regularized at the 
   requestion time resolution, based on \code{Hz} value. It uses 
   \code{approx} the estimate associated changes for other data-series.
   
   \code{repairLocalTime} returns a repaired \code{local.time} 
   \code{pem.element}, typically the supplied \code{local.time} with 
   any holes (\code{NAs}) it can fill filled. 

}

\references{

  \code{regularize} uses \code{approx}:

  Base R Stats package function based on Becker, R. A., Chambers, 
  J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & 
  Brooks/Cole.  

  A lot of leg-work testing \code{regularize} was done by then Leeds 
  MSc Student Adrian Felipe Ortega Calle.  

}

\author{
  Karl Ropkins
}

\note{
  All time handlers should be used with care.  
}

%\section{Warning }{
%  No warnings
%}

\seealso{
  \code{\link{approx}} regarding data regularization methods.
}

%\examples{
%
%###########
%##example  
%###########
%
%}

\keyword{ methods }
