nsLib()

mat <- matrix(1:12, ncol=2, byrow = F)/10
colnames(mat) <- c("x", "y")
foo <- data.frame(`Manip type` = c("type A", "type C"), 
                  `Manip var` = c("head","tars1"), 
                  check.names = FALSE)
foo2 <- data.frame(id=seq.int(nrow(foo)), foo, 
                   basis = I(replicate(nrow(foo), mat, simplify=FALSE)),
                   check.names = FALSE)
str(foo2)
### SETUP DONE
df <- foo2

dat <- flea[, 1:6]

n <- nrow(df)
p <- ncol(dat)
dat_colnames <- colnames(dat)
id <- 1:n
angle <- seq(0, 2 * pi, length = 12*n)
circ <- data.frame(x = cos(angle), y = sin(angle))
circ 

df$manip_var_num <- NULL
for (i in 1:n){
  df$manip_var_num[i] <- which(dat_colnames == df$`Manip var`[i])
}
df

col_text <- NULL
var_lab <- NULL
type_lab <- NULL
for (i in 1:n){
  col_chunk <- rep("grey40", p)
  col_chunk[df$`manip_var_num`[i]] <- "blue"
  col_text <- c(col_text, col_chunk)
  lab_chunk <- rep("", p)
  lab_chunk[df$`manip_var_num`[i]] <- as.character(df$`Manip var`[i])
  var_lab <- c(var_lab, lab_chunk)
  type_chunk <- rep("", p)
  type_chunk[df$`manip_var_num`[i]] <- as.character(df$`Manip type`[i])
  type_lab <- c(type_lab, type_chunk)
}
col_text
var_lab
type_lab

df_gg <- NULL # unlist basis
for (i in 1:nrow(df)){
  rows <- data.frame(id = df$id[i], 
                     df$basis[[i]])
  df_gg <- rbind(df_gg, rows)
}
str(df_gg)


ggplot2::ggplot(data = df_gg) +
  ggplot2::scale_color_brewer(palette = "Dark2") +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "none") +
  ggplot2::coord_fixed() +
  ## Cirle path
  ggplot2::geom_path(data = circ,
                     mapping = ggplot2::aes(x = x, y = y),
                     color = "grey80", size = .3, inherit.aes = F) +
  ## Basis axes line segments
  ggplot2::geom_segment(mapping = ggplot2::aes(x = x , y = y, 
                                               xend = 0, yend = 0)
                        , col = col_text) +
  ## Basis variable text labels
  ggplot2::geom_text(mapping = ggplot2::aes(x = 1.5 * x,
                                            y = 1.5 * y,
                                            label = var_lab),
                     size = 4, hjust = 0, vjust = 0, col = "blue") +
  ## manip_type label
  ggplot2::geom_text(mapping = ggplot2::aes(x = -1, y = -1, label = type_lab),
                     size = 4, hjust = 0, vjust = 0) +
  ## Facet
  ggplot2::facet_grid(rows = df_gg$id) +
  ggplot2::theme(strip.background = ggplot2::element_blank(),
                 strip.text.y     = ggplot2::element_blank())

