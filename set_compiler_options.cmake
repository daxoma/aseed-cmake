# config file
file(WRITE "${PROJECT_CONFIG_FILE}" "#pragma once\n\n")
foreach(it ${PROJECT_CONFIG})
  file(APPEND "${PROJECT_CONFIG_FILE}" "${it}\n")
endforeach()


# compiler options
set(CMAKE_C_FLAGS "")
set(CMAKE_C_FLAGS_DUBUG "")
set(CMAKE_C_FLAGS_RELEASE "")
set(CMAKE_CXX_FLAGS "")
set(CMAKE_CXX_FLAGS_DUBUG "")
set(CMAKE_CXX_FLAGS_RELEASE "")

foreach(it ${PROJECT_COMPILER_OPTIONS})
  add_compile_options(${it})
endforeach()
