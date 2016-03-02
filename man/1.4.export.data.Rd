\name{1.4.export.data}
\alias{1.4.export.data}
\alias{export.data}
\alias{exportPEMSData}



\title{
  exporting PEMS data
}

\description{
  Some functions for exporting data from R and pems.utils.
}

\usage{

 
exportPEMSData(data, file="tempfile", ..., 
          sep="\t", file.writer = write.table,
          row.names = FALSE)

#exportPEMS2Excel 
#currently disabled

}



\arguments{

  \item{data}{
  (A required object) The object to export or export data from.   
} 

  \item{file}{
  (Character) The name of the file to create when exporting data. This can be 
  \code{'clipboard'}, to export to the clipboard assuming the clipboard buffers are not 
  exceeded.  
} 

  \item{\dots}{
  (Optional) Other arguments, handling varies. For \code{export...} functions, these are 
  currently ignored. Note: This and may be subject to change in future. 
}

  \item{sep, file.writer, row.names}{
  (Various arguments) \code{file.writer} is the R function used to create the export file. 
  \code{sep} and \code{row.names} are arguments passed to \code{file.writer}.     
}
    
}


\details{

  \code{exportPEMSData} exports the data component of a \code{pems} object.  
}


\value{

  By default, \code{exportPEMSData} generates a tab-delimited file using the supplied data. 
  If a file name is not set using the \code{file} argument, it is named \code{tempfile}.  
  

}

\references{
  References in preparation.
}
\author{
  Karl Ropkins
}
\note{

  \code{exportPEMS2Excel} is curently disabled.

  These are very crude functions in the most part because they are rarely used. Suggestions for helpful 
  improvements would be very welcome.
 
}

\section{Warning }{

  Currently, the \code{export...} functions overwrite without warnings. 

}

\seealso{
  See \code{\link{import2PEMS}}, etc. for importing data into \code{pems.utils}. 
}
\examples{

###########
##example 1 
###########

#making a tab-delimited copy of pems.1

##exportPEMSData(pems.1, "pems.example.txt")
##dir()

}

\keyword{ methods }
