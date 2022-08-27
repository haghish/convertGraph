
<a href="https://github.com/haghish/convertGraph"><img src='man/figures/logo.PNG' align="right" height="200" /></a>

# `convertGraph` : An R package for converting graphical files to one another


[![CRAN version](http://www.r-pkg.org/badges/version/convertGraph?color=258076)](https://cran.r-project.org/package=convertGraph)  [![](https://cranlogs.r-pkg.org/badges/grand-total/convertGraph?color=e8a0c6)](https://cran.r-project.org/package=convertGraph) [![](https://raw.githubusercontent.com/haghish/mlim/main/man/figures/manual.svg)](https://cran.r-project.org/web/packages/convertGraph/convertGraph.pdf)

There are plenty of widgets available for R that produce and export graphical files, often in SVG format. 
There is a clear demand for a package to **dynamicaly** convert these file formats to one another, with a high quality. 
For example, to export SVG file to PNG, PDF, JPEG, or GIF with a customized resolution. Or export a PNG file to PDF or 
JPEG, etc. 

The `convertGraph` package provides a solution for that. It **does not require RStudio** and is fully functional within R. 
In addition, it allows you to adjust the resolution of exported file to any size and quality. 

`convertGraph` is hosted on CRAN and can be installed by :

> `install.packages("convertGraph")`

The package relies on [PhantomJS](http://phantomjs.org/) binaries. simply download and unzip the binaries and provide the path to `convertGraph` function. 
