\name{1.2.pems.structure}
\alias{1.2.pems.structure}
\alias{pems.structure}
\alias{pemsElement}
\alias{pemsData}
\alias{pemsConstants}
\alias{pemsHistory}



\title{
  'pems' object structure
}

\description{
  This pages provides a brief outview description of the 'pems' object structure. It also 
  lists some associated functions
}

\usage{

pemsElement(element, pems=NULL, ..., 
          fun.name = "pemsElement", if.missing = "stop",
          element.name = deparse(substitute(element)))

pemsData(pems=NULL, ..., 
          fun.name = "pemsData", if.missing = "stop",
          pems.name = deparse(substitute(pems)))

pemsConstants(pems=NULL, ..., 
          fun.name = "pemsConstants", if.missing = "stop",
          pems.name = deparse(substitute(pems)))

pemsHistory(pems=NULL, ..., 
         fun.name = "pemsHistory", if.missing = "stop",
         pems.name = deparse(substitute(pems)))

}



\arguments{

  \item{element}{
  (A required pems element) For \code{pemsElement}, the required data element (data series 
  in data).
}

  \item{pems}{
  (pems object) If supplied, the \code{pems} object to search for \code{element} before 
  checking the parent environments and R workspace.
}

  \item{\dots}{
  (Optional) Other Arguments, currently ignored.
}

  \item{fun.name, if.missing, element.name, pems.name}{
  (Various) Other options using for \code{pems.utils} house-keeping. See \code{\link{check...}} for 
  definitions, although generally these can be ignored by users. See Note below.  
} 
    
}


\details{

  The \code{pems} object is a managed \code{data.frame}. It has five main components: \code{data}, 
  \code{units}, \code{constants}, \code{history} and \code{tags}. \code{data} is the main 
  \code{data.frame}. Each element (named \code{data.frame} column) is a data-series of the original 
  PEMS data. \code{units} are the associated unit definitions. \code{constants} is a list of associated 
  constants that are to be used with the \code{pems} object. (The preference order is arguments given in a 
  call then \code{constants} declared in the \code{pems} object then \code{constant} defaults held by the 
  \code{pems.utils} package.) \code{history} is a log of \code{pems} object modifications. \code{tags} are 
  any other components that the user wishes to add to a \code{pems} object as identifiers.

  \code{pemsElement} gets a requested data element. 

  \code{pemsData} gets the data component of a supplied \code{pems} object.

  \code{pemsConstants} gets all constants locally defined for the the supplied \code{pems} object. 

  \code{pemsHistory} gets the history of supplied \code{pems} object.

}


\value{

  \code{pemsElement} returns the requested element of a supplied \code{pems} object as a managed vector or 
  \code{pems.element}, if available. (If missing, error handling is managed by \code{if.missing}. See 
  \code{\link{check...}} for more details.) 

  \code{pemsData} returns the data component of a supplied \code{pems} object as a \code{data.frame}. 

  \code{pemsConstants} returns the constants component of a supplied \code{pems} object as a \code{list}. 

  \code{pemsHistory} returns the history component of a supplied \code{pems} object as a \code{list}.

}

\references{
  References in preparation.
}
\author{
  Karl Ropkins
}

\note{

  \code{pems...} functions are in development \code{pems} object handlers. They are intended for 
  convenient 'front of house' use. As part of this role, their structure will evolve over time, 
  so arguments and operations may change based on user feedback. Those wishing to develop 
  future-proof third party functions should also consider \code{check...} functions when developing 
  their code. See \code{\link{common.calculations}} for some Examples.      
 
}

\seealso{
  See Also: \code{\link{check...}} for \code{check...} function equivalents; \code{\link{pems.generics}} 
  for \code{pems} object class generic functions.
}

\examples{

###########
##example 1 
###########

#basic usage

#using example data pems.1
#(supplied as part of pems.utils pacakage)

#pems structure
pems.1

#the pems.1 element velocity
pemsElement(velocity, pems.1)

#check... equivalent
#checkInput(velocity, pems.1)

#generic equivalents
#pems.1$velocity
#pems.1["velocity"]
#etc

}
\keyword{ methods }
