\name{5.2.pems.tidyverse.tools}
\alias{5.2.pems.tidyverse.tools}
\alias{pems.tidyverse}
\alias{select_.pems}
\alias{select.pems}
\alias{select}
\alias{rename_.pems}
\alias{rename.pems}
\alias{rename}
\alias{filter_.pems}
\alias{filter.pems}
\alias{filter}
\alias{arrange_.pems}
\alias{arrange.pems}
\alias{arrange}
\alias{slice_.pems}
\alias{slice.pems}
\alias{slice}
\alias{mutate_.pems}
\alias{mutate.pems}
\alias{mutate}
\alias{group_by.pems}
\alias{group_by_.pems}
\alias{group_by}
\alias{groups.pems}
\alias{groups}
\alias{ungroup.pems}
\alias{ungroup}
\alias{group_size.pems}
\alias{group_size}
\alias{n_groups.pems}
\alias{n_groups}
\alias{summarise_.pems}
\alias{summarise.pems}
\alias{summarise}
\alias{pull.pems}
\alias{pull}

\alias{left_join.pems}
\alias{left_join}
\alias{inner_join.pems}
\alias{inner_join}
\alias{right_join.pems}
\alias{right_join}
\alias{full_join.pems}
\alias{full_join}
\alias{semi_join.pems}
\alias{semi_join}
\alias{anti_join.pems}
\alias{anti_join}




\title{
Functions to use tidyverse code with pems.utils outputs  
}

\description{
Various codes and methods.
}

\usage{

#pems object methods

#dplyr (1) standard methods
\method{select}{pems}(.data, ...)
\method{rename}{pems}(.data, ...)
\method{filter}{pems}(.data, ...)
\method{arrange}{pems}(.data, ...)
\method{slice}{pems}(.data, ...)
\method{mutate}{pems}(.data, ..., units=NULL, warn=TRUE)
\method{group_by}{pems}(.data, ..., add=FALSE)
\method{groups}{pems}(x)
\method{ungroup}{pems}(x, ...)
\method{group_size}{pems}(x)
\method{n_groups}{pems}(x)
\method{summarise}{pems}(.data, ...)
\method{pull}{pems}(.data, ...)

#dplyr (2) related underscore methods
\method{select_}{pems}(.data, ..., warn=TRUE)
\method{rename_}{pems}(.data, ..., warn=TRUE)
\method{filter_}{pems}(.data, ..., warn=TRUE)
\method{arrange_}{pems}(.data, ..., warn=TRUE)
\method{slice_}{pems}(.data, ..., warn=TRUE)
\method{mutate_}{pems}(.data, ..., units=NULL, warn=TRUE)
\method{group_by_}{pems}(.data, ..., add=FALSE, warn=TRUE)             
\method{summarise_}{pems}(.data, ..., warn=TRUE)

#dplyr (3) joining methods
\method{inner_join}{pems}(x, y, by = NULL, copy = FALSE, ...)
\method{left_join}{pems}(x, y, by = NULL, copy = FALSE, ...)
\method{right_join}{pems}(x, y, by = NULL, copy = FALSE, ...)
\method{full_join}{pems}(x, y, by = NULL, copy = FALSE, ...)
\method{semi_join}{pems}(x, y, by = NULL, copy = FALSE, ...)
\method{anti_join}{pems}(x, y, by = NULL, copy = FALSE, ...)

}


\arguments{
  \item{.data}{
  (pems.object) The pems object to be used with, e.g. dplyr code. 
} 
  \item{\dots}{
  (Optional) Other arguments, currently all passed on to equivalent tridyverse function or method.
}
  \item{warn}{
  (Optional) Give warnings? For an underscore methods: a warning that an underscore method was used 
  (See Below). For mutate: if new elements are generated within unit assignments.
}
  \item{units}{
  (Character) In mutate, the units to assign to new elements created by call. See Below.
}
  \item{x}{
   (Various) For \code{group...} functions, an object of \code{grouped_df} class. For 
   \code{...join} functions, the first of two datasets, typically a \code{pems} object or 
   \code{data.frame}, to be joined together.
}
  \item{add}{
   (Optional) Argument used by group_by and related dplyr grouping functions. 
}
%  \item{var}{
%   (pems.element) For pull, the pems.element to extract from .data.
%}
  \item{y, by, copy}{
   (various) For \code{...join} functions, consistent with \code{dplyr}, \code{y} is the 
   second of two datasets, typically a \code{pems} object or \code{data.frame}, to be 
   joined together, the first being \code{x}, and \code{by} and \code{copy} are optional 
   arguments. See below.   
}

}

\details{

  The pems object methods \code{select}, \code{rename}, \code{filter}, 
  \code{arrange}, \code{slice}, \code{mutate}, \code{group_by} and  
  \code{summarise} are similar to \code{data.frame} methods of the same 
  names in \code{dplyr}, but (hopefully) they also track units, etc, like a pems object. Work 
  in progress. See below, especially Note.

  Equivalent underscore methods (\code{select_}, etc) are also provided, although 
  it should be noted that their future in dplyr itself is not certain.

  Data joining methods include \code{inner_join}, \code{left_join}, \code{right_join}, 
  \code{full_join}, \code{semi_join} and \code{anti_join}. Like above these are similar 
  \code{data.frame} equivalents in \code{dplyr}, but (hopefully) also track units, etc, 
  like a pems object. Same 'work in progress' caveat. See below.
   
}


\value{
  \code{select} returns the requested part of the supplied pems object, e.g.:
  \code{select(pems.1, velocity)} returns the velocity element of pems.1 as 
  a single column pems.object, consistent with the data.frame handling of 
  \code{select.data.frame}.

  \code{rename} returns the supplied pems object with the requested name change, 
  e.g.: \code{rename(pems.1, speed=velocity)} returns pems.1 with the velocity 
  column renamed speed.

  \code{filter} returns the supplied pems object after the requested filter 
  operation, e.g.: \code{filter(pems.1, velocity>0.5)} returns pems.1 after 
  excluding all rows where the velocity value was less than or equal to 0.5.

  \code{arrange} returns the supplied pems object reordered based on order 
  of values in an identified element, e.g.: \code{arrange(pems.1, velocity)} 
  returns pems.1 with its row reordered lowest to highest velocity entry.

  \code{slice} returns requested rows of the supplied pems object, e.g.: 
  \code{slice(pems.1, 1:10)} returns rows 1 to 10 of pems.1 as a new pems 
  object.

  \code{mutate} returns the supplied pems object with extra elements calculated 
  as requested, e.g.: \code{mutate(pems.1, new=velocity*2)} returns the pems object 
  with additional column, called new, which is twice the values in the velocity 
  column. The units of the new column can be set using the additional argument 
  units, e.g. \code{mutate(pems.1, new=velocity*2, units="ick")}.

  \code{group_by} returns a \code{grouped_df} object. [to document]

  \code{summarise} [to document]  

  The \code{..._join} joining methods, join to supplied datasets. The first, \code{x}, 
  must be a \code{pems} to employ \code{..._join.pems} by the second, \code{y} can be 
  e.g. a \code{data.frame}, etc. [rest to document... link to dplyr and vignette]

}
\references{
  Generics in general:

  H. Wickham. Advanced R. CRC Press, 2014.

  (Not yet fully implemented within this package.)

  ggplot2:

  H. Wickham. ggplot2: elegant graphics for data analysis. Springer New
  York, 2009.

  (See Chapter 9, section 9.3, pages 169-175, for discussion of fortify)
}

\author{
  Karl Ropkins
}
\note{
  Currently not sure what I think about tidyverse, but it is always 
  interesting, and ideas like fortify are really nice.  
}

\section{Warning }{
  This currently work in progress - handle with care.
}

%\seealso{
%  [to do] 
%}

%\examples{

%###########
%##example 1 
%###########

%}

\keyword{ methods }
