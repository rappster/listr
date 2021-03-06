% Generated by roxygen2 (4.0.2): do not edit by hand
\name{getStructure}
\alias{getStructure}
\title{Get Structure (generic)}
\usage{
getStructure(input, extended = TRUE, ...)
}
\arguments{
\item{input}{\strong{Signature argument}.
Object whose structure should be retrieved.}

\item{extended}{\code{\link{logica.}}.
\code{TRUE}: extended structure;
\code{FALSE}: updated raw structure.}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\description{
Retrieves the structural components of an object.
}
\examples{
\dontrun{

##------------------------------------------------------------------------------  
## List
##------------------------------------------------------------------------------  

input <- list(
  x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
  x2 = list(x21 = "x21"),
  x3 = list("x31"),
  x4 = "x4",
  x5 = list(1:3),
  list(list(1, 2), list(3, 4)),
  list(1:3),
  "char 1",
  "char 2",
  letters[1:3],
  c(1,3,5),
  TRUE,
  new.env(),
  data.frame(x = 1:3, y = 1:3)
)

## Default: extended 
getStructure(input)
## Regular
getStructure(input, extended = FALSE)

##------------------------------------------------------------------------------  
## RawObjectStructure.S3
##------------------------------------------------------------------------------  

input <- list(
  x1 = list(x11 = list(x111 = 1, x112 = 1), x12 = list(x121 = 1, x122 = 1)),
  x2 = list(x21 = "x21"),
  x3 = list("x31"),
  x4 = "x4",
  x5 = list(1:3),
  list(list(1, 2), list(3, 4)),
  list(1:3),
  "char 1",
  "char 2",
  letters[1:3],
  c(1,3,5),
  TRUE,
  new.env(),
  data.frame(x = 1:3, y = 1:3)
)
input <- getRawStructure(input)

## Default: extended 
getStructure(input)
## Regular
getStructure(input, extended = FALSE)

}
}
\author{
Janko Thyson \email{janko.thyson@rappster.de}
}
\references{
\url{http://github.com/rappster/listr}
}
\seealso{
\code{
  	\link[listr]{getStructure-list-method},
    \link[listr]{getRawStructure}
}
}

