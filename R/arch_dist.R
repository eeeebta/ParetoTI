##' Compute distance to archetypes
##' @rdname arch_dist
##' @name arch_dist
##' @author Vitalii Kleshchevnikov
##' @description \code{arch_dist()} calculates Euclidean distance from every point to every archetype give matrices that contain this data.
##' @param data matrix of dim(variables/dimentions, examples)
##' @param archetypes matrix of dim(variables/dimentions, archetypes)
##' @param dist_metric distance metric, currently only "euclidean" implemented
##' @return matrix of distances to archetypes of dim(examples, archetypes)
##' @export arch_dist
##' @seealso \code{\link[ParetoTI]{fit_pch}}, \code{\link[ParetoTI]{generate_arc}}, \code{\link[ParetoTI]{generate_data}}
##' @examples
##' # Triangle with sides of 3,4,5 units length
##' arch_dist(matrix(c(0,0),1,2), matrix(c(3,4),1,2))
##' # Random data that fits into the triangle
##' set.seed(4355)
##' archetypes = generate_arc(arc_coord = list(c(5, 0), c(-10, 15), c(-30, -20)),
##'                           mean = 0, sd = 1, N_dim = 2)
##' data = generate_data(archetypes, N_examples = 1e4, jiiter = 0.04, size = 0.9)
##' # Find Euclidean distance between data points and archetypes
##' distance = arch_dist(data, archetypes)
##' # Find Euclidean distance between archetypes
##' arc_distance = arch_dist(archetypes, archetypes)
arch_dist = function(data, archetypes, dist_metric = "euclidean"){
  if(dist_metric == "euclidean"){
    archetype_list = lapply(seq_len(ncol(archetypes)), function(i) archetypes[, i])
    distances = vapply(archetype_list, function(arc, data){
      diff = arc - data
      sqrt(colSums(diff^2))
    }, FUN.VALUE = numeric(ncol(data)), data)
    # if archetypes are not named => rename
    if(is.null(colnames(archetypes))){
      colnames(distances) = paste0("archetype_", seq_len(ncol(distances)))
    } else colnames(distances) = colnames(archetypes)

  }
  distances
}
