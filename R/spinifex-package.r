#' spinifex
#'
#' spinifex is a package that is compatiable and extends the package `tourr`. 
#' It builds the functionality for manual tours, and adds the ability for any 
#' tour to be rendered as `plotly` or `gganimate` objects. Touring is a class 
#' of dimensionality reducetion that orthagonally projects data from `p` down 
#' to `d` dimensions, take a small change in `p`-space and interpolates again. 
#' Manual tours manipulate a selected variable to explore the local structure,
#' particaularly effective after finding a interesting tour, perhaps via a 
#' guided tour.
#'
#' It's main functions are:
#' \itemize{
#'   \item [manual_tour()]
#'   \item [create_slides()]
#'   \item [render_plotly()]
#'   \item [render_gganimate()]
#'   \item [spinifex()], A wrapper function for the above.
#'   \item [play_tour()], A wrapper function which tourr tour paths can be used.
#' }
#'
#' GitHub repo: \url{https://github.com/nspyrison/spinifex}
#' @seealso tourr (package)
#' @name spinifex
#' @docType package
"_PACKAGE"

globalVariables(c("cat_var",
                  "disp_type",
                  "phi_min",
                  "phi_max",
                  "manip_col",
                  "manip_type",
                  "n_slides",
                  "slide",
                  "theta"
))

### Jenny Bryan's solution: 
### https://github.com/STAT545-UBC/Discussion/issues/451#issuecomment-264598618
## quiets concerns of R CMD check re: the .'s that appear in pipelines
# if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))