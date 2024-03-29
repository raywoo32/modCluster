% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/makeCommunities.R
\name{makeCommunities}
\alias{makeCommunities}
\title{Change igraph object properties (communities, membership) a list of combined modules}
\usage{
makeCommunities(graph, chosen)
}
\arguments{
\item{graph}{a valid igraph object}

\item{chosen}{df with chosen combined modules (columns $MODULE, $SUBGRAPH, $DENSITY)}
}
\value{
list containing communities, communities list, and igraph membership
}
\description{
Change igraph object properties (communities, membership) a list of combined modules
}
