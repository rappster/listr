#' @title
#' Get Raw Structure (generic)
#'
#' @description 
#' Retrieves the structural components of an object in a raw form.
#'   	
#' @param main \strong{Signature argument}.
#'    Object whose structure should be retrieved.
#' @template threedots
#' @example inst/examples/getRawStructure.r
#' @seealso \code{
#'   	\link[listr]{getRawStructure-list-method}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "getRawStructure",
  signature = c(
    "input"
  ),
  def = function(
    input,
    ...
  ) {
    standardGeneric("getRawStructure")       
  }
)

#' @title
#' Get Raw Structure (list)
#'
#' @section See generic: 
#' \code{\link[listr]{getRawStructure}}
#'      
#' @inheritParams getRawStructure
#' @param input \code{\link{list}}.
#' @return \code{\link[listr]{RawObjectStructure.S3}}. A \code{data.frame} like 
#'    representation of structural information with an additional class 
#'    attribute.
#' @example inst/examples/getRawStructure.r
#' @seealso \code{
#'    \link[listr]{getRawStructure}
#' }
#' @template author
#' @template references
#' @aliases getRawStructure-list-method
#' @import stringr
#' @export
setMethod(
  f = "getRawStructure", 
  signature = signature(
    input = "list"
  ), 
  definition = function(
    input,
    ...
  ) {
 
  if (FALSE) {
  struc <- capture.output(str(input, list.len = length(input)))
  struc <- unlist(strsplit(struc, split = "\n"))
  tops <- str_count(struc, "\\s\\$\\s")
  subs <- str_count(struc, "((\\.\\.)(\\s|\\$))")
  
  ## Clean //
  idx_out <- which(tops == 0 & subs == 0)
  if (length(idx_out)) {
    tops <- tops[-idx_out]
    subs <- subs[-idx_out]
    struc <- struc[-idx_out]
  }
  
  ## Types //
  types <- gsub(".*\\$(\\s*:|\\s*\\w+:)", "", struc)
  types <- gsub("(?<=\\w)\\s.*|\\:.*", "", types, perl = TRUE)
  types <- tolower(gsub("\\s|<|'", "", types))
  
  ## Names //
  idx_names <- str_detect(struc, "\\$\\s\\w+.*:\\s")
  nms <- if (length(idx_names)) {
#     gsub("\"", "", gsub(".*: chr \"", "", struc[idx_names]))
    gsub("\\$\\s", "", str_extract(struc, "\\$\\s\\w+"))
  } else {
    NA
  }

  ## Levels //
  subs_2 <- lapply(0:subs[which.max(subs)], function(ii) {
    out <- subs == ii
    out[out] <- 1
    out
  })
  names(subs_2) <- 1:length(subs_2)
  out <- data.frame(
    subs_2, 
    name = nms, 
    class = types, 
    str = struc, 
    stringsAsFactors = FALSE
  )
  listr::RawObjectStructure.S3(.x = out)
  }
    
  .getRawStructure <- function(x, level = 0) {
    level <- level + 1
    out <- lapply(seq(along = x), function(el) {
      name <- names(x[el])
      value <- x[[el]]
      cls <- class(value)
      .dim <- if (cls %in% c("data.frame", "matrix")) {
        paste(dim(value), collapse = " ")
      } else {
        length(value)
      }  
      out <- data.frame(
        level = level,
        name = if (is.null(name) || name == "") NA else name,
        class = cls,
        dim = .dim,
        stringsAsFactors = FALSE
      )
      if (cls == "list") {
        deep <- .getRawStructure(x = value, level = level)
        c(list(out), unlist(deep, recursive = FALSE))
      } else {
        list(out)
      }
    })  
  }
  tmp <- do.call("rbind", unlist(.getRawStructure(x = input), recursive = FALSE))
#   tmp$name[tmp$name == ""] <- NA
  subs <- tmp$level
  subs_2 <- lapply(1:subs[which.max(subs)], function(ii) {
    out <- subs == ii
    out[out] <- 1
    out
  })
  names(subs_2) <- 1:length(subs_2)
  listr::RawObjectStructure.S3(
    .x = data.frame(subs_2, tmp, stringsAsFactors = FALSE)
  )

  }
)

