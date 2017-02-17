cmake_minimum_required(VERSION 3.0)

# todo: design as a cmake module, not as cmake project
set(CWT_SITE_PROJECT "myCWT_Project" CACHE STRING "id of your web site project")
project(${CWT_SITE_PROJECT}-site)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(dirmap)


set(output_dir ${CMAKE_SOURCE_DIR}/out)
set(template_dir ${CMAKE_SOURCE_DIR}/templates/mustache)
set(source_dir ${CMAKE_SOURCE_DIR}/src)

set(output_file ${output_dir}/index.html)


message(${source_dir}/header.yaml)
message(${template_dir}/main.html.mustache)
message(${output_dir}/index.html)

# path to executables
set(RUBY_EXECUTABLE D:/programs/Ruby23/bin/ruby.exe CACHE STRING "ruby executable")
set(MUSTACHE_SCRIPT D:/programs/Ruby23/bin/mustache CACHE STRING "mustache ruby script")

# function that call mustache
function(apply_mustache data template result)
    execute_process(
        COMMAND ${RUBY_EXECUTABLE} -E UTF-8 ${MUSTACHE_SCRIPT} ${data} ${template}
        OUTPUT_VARIABLE result_t
        )
    set(${result} ${result_t} PARENT_SCOPE)
endfunction()

# convenience function read a template
function(read_template type name)
     string(TOUPPER ${type} up_type)
     string(TOLOWER ${type} low_type)
     file(READ ${CWT_${up_type}}/${name}.${low_type}.part name_t)
     set(${name} ${name_t} PARENT_SCOPE)
endfunction()


# convenience function apply_mustache
function(generate_part data template_name)
    apply_mustache(${CWT_INPUT}/${data}.yaml ${template_dir}/${template_name}.html.mustache data_t)
    set(${data} ${data_t} PARENT_SCOPE)
endfunction()

# lecture d'une feuille css
function(add_css_sheet collection name var)
    file(READ ${CWT_CSS}/${collection}/${name}.css stylesheet_t)
    STRING(APPEND  sout "${${var}}" "\n" "${stylesheet_t}")
    set(${var} ${sout} PARENT_SCOPE)
endfunction()


generate_part(header header)
generate_part(PSI2015 abstract)
generate_part(partenaires logo_footer)



read_template(html prologue)
read_template(html epilogue)

# build index.html
file(WRITE ${CWT_OUTPUT}/index.html "${prologue}\n${header}\n${epilogue}")

#file(WRITE ${CWT_OUTPUT}/index.html "${prologue}\n${header}\n${PSI2015}\n${partenaires}\n${epilogue}")



# get needed stylesheet
add_css_sheet(cidco reset stylesheet)
add_css_sheet(cidco logo_footer stylesheet)


# transfert stylesheet
file(WRITE ${CWT_OUTPUT}/style.css
    "${stylesheet}"
    )


# transfert des logos
file(GLOB logos
  "${CWT_INPUT}/*_logo.*"
)

file(COPY ${logos} DESTINATION ${CWT_OUTPUT})
