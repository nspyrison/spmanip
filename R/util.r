#' Creates and returns an identity basis
#'
#' Creates a [p, d=2] dim identity basis; identity matrix followed by rows 0s.
#'
#' @param p number of dimensions of the data. p must be equal to or greater than d.
#' @param d number of dimensions of the basis. Defaults to 2.
#' @return A [p, d=2] dim identity matrix followed by rows of 0s.
#' 
#' @examples 
#' create_identity_basis(6)
#' @export
create_identity_basis <- function(p, d = 2){
  stopifnot(class(as.integer(p) == "integer"))
  stopifnot(class(as.integer(d) == "integer"))
  stopifnot(length(p) == 1)
  stopifnot(length(d) == 1)
  stopifnot(p >= d)
  
  basis <- matrix(0, nrow = p, ncol = d)
  diag(basis) <- 1
  
  stopifnot(dim(basis) == c(p,d))
  return(basis)
}

#' Plot projection frame and return the axes table.
#' 
#' Uses base graphics to plot the circle with axes representing
#' the projection frame. Returns the corrisponding table.
#' 
#' @param basis A [p, d=2] basis, xy contributions of each dimension (numeric variable). 
#' @param data Optional, of [n, p] dim, applies colnames to the rows of the basis.
#' 
#' @examples 
#' create_identity_basis(6) -> ThisBasis
#' view_basis(ThisBasis)
#' @export
view_basis <- function(basis, data = NULL) {
  stopifnot(class(basis) %in% c("matrix", "data.frame"))
  
  tmp <- basis
  tmp <- cbind(tmp, sqrt(tmp[,1]^2 + tmp[,2]^2), atan(tmp[,2]/tmp[,1]))
  colnames(tmp) <- c("X", "Y", "norm_xy", "theta")
  axes <- tibble::as_tibble(tmp)
  
  lab = NULL
  if (!is.null(data)) {
    rownames(tmp) <- colnames(data)
    this_label = colnames(data)
    }
  
  plot(0,type='n',axes=FALSE,ann=FALSE,xlim=c(-1, 1), ylim=c(-1, 1),asp=1)
  segments(0,0, basis[, 1], basis[, 2], col="grey50")
  theta <- seq(0, 2 * pi, length = 50)
  lines(cos(theta), sin(theta), col = "grey50")
  text(basis[, 1], basis[, 2], label = this_label, col = "grey50")
  
  stopifnot(class(axes) == "tibble")
  stopifnot(dim(axes) == (dim(basis) + c(0,2)) )
  return(axes)
}