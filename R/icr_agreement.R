### Internal functions ###

## Compute Holsti's reliability estimate
##
## Computes Holsti's reliability estimate (mean pairwise agreement).
##
## @param ucm Units-coders matrix
##
## @family intercoder reliability
##
## @keywords internal
icr_holstis_CR <- function(ucm) {

  if (any(is.na(ucm))) {
    return(NA)
  }

  if (is.null(colnames(ucm))) {
    colnames(ucm) <- 1:ncol(ucm)
  }

  pair_agrees <- c()

  for (cols in combn(colnames(ucm), 2, simplify = FALSE)) {
    pair_agrees <- c(pair_agrees, icr_agreement(ucm[, cols]))
  }

  mean(pair_agrees)
}

## Compute simple percent agreement
##
## Computes simple percent agreement for a units-coders matrix
##
## @param ucm Units-coders matrix
##
## @family intercoder reliability
##
## @keywords internal
icr_agreement <- function(ucm) {

  if (any(is.na(ucm))) {
    return(NA)
  }

  sum(apply(ucm, 1, check_equal)) / dim(ucm)[1]
}

## Check if all values in a vector are the same
##
## Checks if all values in a vector are the same
##
## @param x A vector
## @param tol A numeric indicating the tolerance of the check
##
## @keywords internal
check_equal <- function(x, tol = NULL) {

  if (missing(tol)) {
    tol <- 0
  }

  if (is.numeric(x)) {
    abs(max(x) - min(x)) <= tol + 1e-12
  } else {
    length(x) - 1 == sum(duplicated(x))
  }
}
