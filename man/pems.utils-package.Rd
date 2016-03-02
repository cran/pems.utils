\name{pems.utils-package}
\alias{pems.utils-package}
\alias{pems.utils}
\docType{package}
\title{
  pems.utils 
}
\description{
  The R package pems.utils contains a range of functions for the routine handling 
  and analysis of data collected by portable emissions measurement systems (PEMS) 
  and other similar mobile monitoring systems.  
  
}
\details{
\tabular{ll}{
Package: \tab pems.utils\cr
Type: \tab Package\cr
Version: \tab 0.2.17.8\cr 
Date: \tab 2016-03-02\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}

The \code{pems.utils} functions have been arranged according to usage, as 
follows:

1. Getting data in and out of \code{pems.utils}.

1.1. Functions for making and importing datasets for use with \code{pems.utils}: \code{\link{makePEMS}}, 
\code{\link{import2PEMS}}, etc.

1.2. The pems object structure: \code{\link{pems.structure}}, \code{\link{pemsElement}}, etc. 

1.3. Merging pems objects: \code{\link{merge.pems}}, \code{\link{align}}, etc. 

1.4. Exporting data from pems objects and R: \code{\link{export.data}}.


2. Routine use

2.1. Generic pems handling

2.1.1. pems objects, \code{\link{pems.generics}}.

2.1.2. pems.element objects, \code{\link{pems.element.generics}}.

2.2. Unit handler functions: \code{\link{getUnits}}, \code{\link{setUnits}}, \code{\link{convertUnits}}, etc.

2.3. Calculations

2.3.1. Common calculations: \code{\link{common.calculations}}, \code{\link{calcDistance}}, \code{\link{calcAccel}}, etc.

2.3.2. VSP calculations: \code{\link{calcVSP}}, etc.

2.3.3. Emissions calculations: \code{\link{calcEm}}, etc.

2.4. Plots for pems objects: \code{\link{pems.plots}}, \code{\link{latticePlot}}, \code{\link{pemsPlot}}, etc.

2.5. Analysing data in pems objects: \code{\link{summary.reports}}

2.6. Conditioning pems objects: \code{\link{conditioning.pems.data}}, \code{\link{cutBy}}, etc.


3. Refernce datasets, examples, look-up tables, etc.

3.1. Example datasets: \code{\link{pems.1}}.

3.2. look-up tables: \code{\link{ref.unit.conversions}}, etc.


4. Developers tools

4.1. Common \code{\link{check...}} functions for the routine handling of function arguments/user 
inputs.


}
\author{
Karl Ropkins
Maintainer: Karl Ropkins <k.ropkins@its.leeds.ac.uk>
}
\references{
  Functions in \code{pems.utils} make extensive use of code developed by others. 
  In particular, I gratefully acknowledge the huge contributions of the R Core Team 
  and numerous contributors in developing and maintaining R:

  R Development Core Team (2011). R: A language and environment for
  statistical computing. R Foundation for Statistical Computing,
  Vienna, Austria. ISBN 3-900051-07-0, URL http://www.R-project.org/.

}

\keyword{ package }

\seealso{
  \code{\link{pems}}, \code{\link{import2PEMS}} 
}

%\examples{
%############
%#to do
%}

