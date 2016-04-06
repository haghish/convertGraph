#' @title Convert Graphical Files Format
#' @keywords graphics plot diagram literate visualization SVG PDF PNG JPEG BMP GIF
#' @usage convertGraph(from, to, size = 1.0, path = NULL)
#' @return Converts the given graphical file to the specified file format.
#'
#' @description The \code{convertGraphic} package converts graphical file formats (SVG, PNG, JPEG, BMP, GIF, PDF, etc) to one another. The exceptions are the \code{SVG} file format that can only be converted to other formats and in contrast, \code{PDF} format, which can be created from others graphical formats. The package provides a solution for converting SVG file format to PNG which is often needed for exporting graphical files produced by R widgets.
#'
#' @param from The graphical source file
#' @param to The file name and extension of the converted file
#' @param size Enlarge the converted graphical file by magnifying its resolution with the given number
#' @param path Path to executable 'phantomJS' binary, downloadble from \url{http://phantomjs.org/download.html}
#'
#' @author E. F. Haghish \cr
#' Medical Informatics and Biostatistics (IMBI) \cr
#' University of Freiburg, Germany \cr
#' \email{haghish@imbi.uni-freiburg.de} \cr
#' \cr
#' Department of Mathematics and Computer Science \cr
#' University of Southern Denmark \cr
#' \email{haghish@imada.sdu.dk}
#'
#'
#' @examples
#' \dontrun{
#' #convert SVG to PNG
#' convertGraph("./example.svg", "./example.png", path = "path to executable phantomJS" )
#'
#' #convert PNG to JPEG
#' convertGraph("./example.png", "./example.jpeg", path = "path to executable phantomJS" )
#'
#' #convert JPEG to PDF
#' convertGraph("./example.jpeg", "./example.pdf", path = "path to executable phantomJS" )
#' }
#'
#' @export
#' @importFrom tools file_path_as_absolute
#' @importFrom tools file_ext


convertGraph <- function(from, to, size = 1.0, path = NULL) {
    #, setup = FALSE
    #, width = 600, height = 450  #removed arguments


    if (!is.null(path)) {
        if (file.exists(path)) {
            memory <- system.file("PATHMEMORY", package = "convertGraph")
            write(path, file=memory, append=TRUE)
        }
    }
    else {
        #check the memory file and return a 'Note'
        memory <- system.file("PATHMEMORY", package = "convertGraph")
        read <- readLines(memory)
        if (length(read) > 0) {
            path <- read[length(read)]
            warnings(paste('the path to phantomJS was retreived from your ',
            'latest defined path which is:\n', path))
            file.exists(path)
        }

        #get the path or return an install request
    }

    command <- system.file("lib/command.js", package = "convertGraph")
    phantomJS <- paste("'", file_path_as_absolute(path), "'", sep = "")
    file_ext(phantomJS)
    file_ext(command)

    #if (width != 600 | height != 450) {
    #    src <- system.file("lib/command.js", package = "convertGraph")
    #    command <- tempfile(pattern = "command", tmpdir = tempdir(), fileext = ".js")
    #    file.copy(src, command)
    #    write(paste("page.viewportSize = { width: ", width, ", height:", height,
    #        "};"), file=command, append=TRUE)
    #}

    if (size > 1.0) {
        from <- file_path_as_absolute(from)
        #html <- file.path(getwd(), "_temp_by_convertGraph.html")
        html <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".html")
        #file.create(html)
        content <- paste('<!doctype html>\n<head>\n<style type="text/css">\n
            body {zoom: ', size,';}\n</style>\n</head>\n<body>\n
            <img src="', from, '" />\n</body>\n</html>\n', sep = "")
        write(content, file=html, append=TRUE)
        phantomScript <- paste(phantomJS, command, html, to, sep = " ")
    }
    else {
        phantomScript <- paste(phantomJS, command, from, to, sep = " ")
    }

    #print(phantomScript)
    system(phantomScript)
    #system(phantomJS)

}
