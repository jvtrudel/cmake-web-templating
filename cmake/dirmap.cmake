# usefull path variables

# public
set(CWT_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/src CACHE PATH "Input directory containing your source data")
set(CWT_BUILD_DIR ${CMAKE_BINARY_DIR}/CWT-site CACHE PATH "Output directory for the build process")
set(CWT_INSTALL_DIR ${CMAKE_BINARY_DIR}/CWT-site CACHE PATH "Output directory for the install process")

# internal

## templates
set(CWT_CSS ${CMAKE_CURRENT_SOURCE_DIR}/templates/css)
set(CWT_MUSTACHE ${CMAKE_CURRENT_SOURCE_DIR}/templates/mustache)
set(CWT_HTML ${CMAKE_CURRENT_SOURCE_DIR}/templates/html)
