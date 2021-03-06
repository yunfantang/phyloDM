% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tailprob.R
\name{tailprob}
\alias{tailprob}
\title{Bounding the phyloDM p-value}
\usage{
tailprob(pstrct, w, nthread, verbose = TRUE, gridInc = 0.001,
  reltol = 0.001, btol = 1e-06)
}
\arguments{
\item{pstrct}{An object returned from function \code{phylostructure}.}

\item{w}{Observed maximum triplet statistic. This is included in the return 
object of function \code{nodetest}.}

\item{nthread}{Number of parallel thread.}

\item{verbose}{Should the progress output be printed? Default is TRUE.}

\item{gridInc}{Increment of sucessive grid points on which the cumulative 
distribution function is calculated. Default is \code{1e-3}.}

\item{reltol}{Relative error of numerical integration. Default is \code{1e-3}.}

\item{btol}{Relative error of cumulative distribution function on the grid. 
Default is \code{1e-6}. Recommend not to change.}
}
\value{
A list with the following components:
\item{\code{Pu}}{Upper bound of p-value}
\item{\code{Pl}}{Lower bound of p-value}
}
\description{
\code{tailprob} returns the upper and lower bound of the p-value of phyloDM 
maximum triplet statistic.
}
\details{
This function calculates the upper and lower bound of the p-value of
phyloDM maximum triplet statistic using the method in the reference paper. 
There are two stages in total, both of which are computationally intensive. 
Parallel processing is strongly recommended. Total computation time scales up 
with \code{w} and size of phylogenetic tree.
}
\examples{
library(ape)
set.seed(10)

pstrct <- phylostructure(rtree(8))
tailprob(pstrct, 2, nthread = 2, gridInc = 0.02, reltol = 0.02)

## This example should take about a minute
\dontrun{
set.seed(10)
  
pstrct <- phylostructure(rtree(10))
p1 <- c(rep(0.12, 3), rep(0.08, 3), rep(0.1, 4))
p2 <- p1 + 0.001 * c(c(1,-1), rep(0,8))
n <- 1000 #Number of sequences in each sample
m <- 200 #Number of samples in each group
group.data <- list(x1 = t(rmultinom(m, n, p1)), x2 = t(rmultinom(m, n, p2)))
nt <- nodetest(pstrct, group.data) #Generate triplet statistics
tailprob(pstrct, nt$w, nthread = 2, gridInc = 0.01, reltol = 0.01)
} 
}
\author{
Yunfan Tang
}
\references{
Tang, Y., Ma, Li. and Nicolae, D. L. (2016). Phylogenetic 
Dirichlet-multinomial model for microbiome data. 
\href{https://arxiv.org/abs/1610.08974}{arXiv:1610.08974} [stat.AP].
}

