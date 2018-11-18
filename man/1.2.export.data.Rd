\name{1.2.export.data}
\alias{1.2.export.data}
\alias{export.data}
\alias{exportPEMSData}
\alias{exportPEMS2CSV}


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

exportPEMS2CSV(pems, file="tempfile", ...)

#exportPEMS2Excel 
#currently disabled

}



\arguments{

  \item{data, pems}{
  (A required object) The object to export from R, typically a \code{data.frame} or 
  \code{pems} object.   
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

  Both \code{exportPEMSData} and \code{exportPEMS2CSV} export the data component of a supplied 
  \code{pems} object. \code{exportPEMSData} saves it as a tab-delimited \code{.txt} file. 
  \code{exportPEMS2CSV} saves it as a comma-delimited \code{.csv} file. See below.
 
}


\value{

  By default, \code{exportPEMSData} and \code{exportPEMS2CSV}, respectively, generate tab-delimited and 
  comma-delimited file copies of the data element of the supplied data. 

  If a file name is not set using the \code{file} argument, the is named \code{tempfile}.  
  
  \code{exportPEMS2CSV} modified the data as part of export as follows: It adds the time-series units to 
  the time.series name in form \code{[name]_[units]}.  

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

\dontrun{
exportPEMSData(pems.1, "pems.example.txt")
dir()
}

}

\keyword{ methods }
