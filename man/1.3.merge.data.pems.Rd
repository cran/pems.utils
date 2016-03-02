\name{1.3.merge.data.pems}
\alias{1.3.merge.data.pems}
\alias{merge.pems}
\alias{align}
\alias{cAlign}
\alias{tAlign}
\alias{findLinearOffset}

\title{
  Merging data and pems objects
}

\description{
  Various pems.utils functions to merge data of different types.
}

\usage{

  #basic alignment
  align(data1, data2, n = 0, ...)
 
  #alignment based on correlation
  cAlign(form, data1 = NULL, data2 = NULL, ...)

  #alignment based on time.stamp
  tAlign(form, data1, data2 = NULL, order=TRUE, ...)


  #historical
  findLinearOffset(x = NULL, y = NULL, offset.range = NULL)

}


\arguments{

    \item{data1, data2}{
   (\code{pems} or \code{data.frame}; optional for \code{cAlign}, required for other
    alignment functions) \code{pems} objects or \code{data.frame}s to be aligned. 
}

  \item{n}{
   (\code{numeric}; required) An offset to be applied to \code{data2} when aligning 
   \code{data1} and \code{data2}. The default, \code{n = 0}, applies no offset and directly 
   aligns the two supplied data sets, first row to first row.  
}

  \item{...}{
   (An other arguments) May be passed on but are typically ignored. See Notes.
}

  \item{form}{
   (\code{formula}; required) A formula identifying the elements in the supplied 
   data sets to be used as references for the alignment. This typically takes 
   the form, e.g. \code{cAlign(x~y, d1, d2)} where \code{d1$x} and \code{d2$y} 
   are the data series to be used to correlation align the two data sets. 
}

  \item{order}{
   (\code{logical}; optional) If \code{TRUE} the function orders the data. 
}

  \item{x, y}{
  (Required objects, various classes) For \code{bindPEMS}, two \code{pems}, 
  \code{data.frame}, \code{pems.elements} or \code{vectors} to be bound together. 
  For \code{findLinearOffset}, two \code{pems.elements} or \code{vectors} to be 
  aligned.
} 

  \item{offset.range}{
  (Numeric) For \code{findLinearOffset}, the 'lag window' to compare \code{x} 
  and \code{x} across. By default, the function applies the widest possible 
  window.  
} 
    
}


\details{

   The \code{align} function accepts two \code{pems} objects, 
   \code{data.frame}, etc, and returns a single dataset (as 
   a \code{pems} object) of the aligned data. An extra argument, 
   \code{n}, may be supplied to offset the starting row of the 
   second data set relative to the first. It is intended to be 
   used in the form:

   \code{aligned.data <- align(data1, data2)}    #aligned row 1-to-1

   \code{aligned.data <- align(data1, data2, 3)} #row 3-to-1, etc

   The \code{cAlign} function accepts a formula and up to two data 
   sets and returns a single data set (as a \code{pems} object) of 
   correlation aligned data. This uses the best fit linear offset 
   correlation for the elements identifed in the formula term. 

   It is intended to be used in the form:

   \code{aligned.data <- cAlign(name1~name2, data1, data2)}

   The \code{tAlign} function accepts a formula and two data sets 
   and returns a single data set (as a \code{pems} object) of the 
   time stamp aligned data. This is this done by matching entries 
   in the elements identifed in the formula term. 

   It is intended to be used in the form:

   \code{aligned.data <- tAlign(name1~name2, data1, data2)}

   Historical functions:

   \code{findLinearOffset} is historical code.  

}


\value{

   \code{align}, \code{cAlign}, \code{tAlign}, etc all return a 
   single object of \code{pem} class containing the aligned data 
   from \code{data1} and \code{data2}.

   \code{findLinearOffset} returns the best fit offset for \code{y} 
   relative to \code{x}. 

}

\references{

   \code{align} uses the \code{plyr} function \code{join}.         

   \code{cAlign} function uses the \code{stats} function \code{ccf}.         

   \code{tAlign} uses the \code{plyr} function \code{join}.         

}

\author{

  Karl Ropkins

}

\note{

  These functions are under revision and need to be handled 
  with care.

  \code{cAlign}: By default \code{cAlign} generates an alignment 
  plot and returns a \code{pems} object of aligned data. But it 
  also allows several hidden arguments to refine outputs, the 
  logicals \code{plot}, \code{offset} and \code{pems}, which turn 
  off/on plot, offset and pems reporting individually, and  
  code{output = c("plot", "offset", "pems")} or combinations thereof 
  also provides a single argument alternative.     

  \code{bindPEMS}: The historical function \code{bindPEMS} has 
  been superceded by \code{align}, \code{cAlign} options. 

  \code{findLinearOffset}: \code{findLinearOffset} is currently 
  retained but will most likely be removed from future versions of 
  \code{pems.utils}. 

  The call \code{cAlign(x, y, output = "offset")} is equivalent to 
  \code{findLinearOffset(x, y)}.
     
}

%\section{Warning }{
%  No warnings
%}

\seealso{
  See also: \code{\link{cbind}} for standard column binding in \code{R}; 
  \code{\link{plyr}} for \code{\link{join}}. 
}
\examples{

###########
##example 1 
###########

##data vector alignment

#make two offset ranges
temp <- rnorm(500)
x <- temp[25:300]
y <- temp[10:200]

#plot pre-alignment data
plot(x, type="l"); lines(y, col="blue", lty=2)

#estimated offset
findLinearOffset(x,y)
#[1] -15

#applying linear offset
ans <- align(x, y, findLinearOffset(x,y))
names(ans) <- c("x", "y")

#plot post-alignment data
plot(ans$x, type="l"); lines(ans$y, col="blue", lty=2)

#shortcut using cAlign
#plot(x, type="l"); lines(y, col="blue", lty=2)
#ans <- cAlign(x~y)
#plot(ans$x, type="l"); lines(ans$y, col="blue", lty=2)


###########
##example 2 
###########

##aligning and merging data sets
##(pems object example)

#make some offset data
p1 <- pems.1[101:200, 1:5]
p2 <- pems.1[103:350, 1:3]

#correlation alignment using ccf 
ans <- cAlign(~conc.co, p1, p2)

#this aligns by comparing p1$conc.co and p2$conc.co
#and aligning at point of best linear regression fit

#compare:

#cAlign(~conc.co, p2, p1)
#cAlign(conc.co2~conc.co, p1, p2)
#(aligns using p1$conc.co2 and p2$conc.co)
#cAlign(conc.co2~conc.co, p1)
#(realigns just conc.co within p1 based on best fit 
# with conc.co2 and returns as output ans)
 
#time stamp alignment using join 
#tAlign(~time.stamp, p1, p2)

#this aligns by pairing elements in p1$time.stamp 
#and p2$time.stamp
#(NOTE: if time stamps have different names, as in 
# tAlign(time1~time2, p1, p2), the time stamp name 
# from p1, would be retained when merging time1$p1 
# and time2$p2, generating ans$time1)  

}

\keyword{ methods }
