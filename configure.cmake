# default/used values
set(PROJECT_PLATFORM "")
set(PROJECT_COMPILER_OPTIONS "")
set(PROJECT_LINKER_OPTIONS "")
set(PROJECT_CONFIG "") #file content
set(PROJECT_CONFIG_FILE "${CMAKE_BINARY_DIR}/configuration.h")
set(PROJECT_LIBRARY_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(PROJECT_RUNTIME_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

if (UNIX)
  set(PROJECT_PLATFORM "UNIX")
elseif(WIN32)
  set(PROJECT_PLATFORM "WINDOWS")
else()
  message(FATAL_ERROR "Unsupported platform")
endif()

if (UNIX)
  list(APPEND PROJECT_COMPILER_OPTIONS -std=c++20 -Wall -Wextra -pedantic -Werror -fno-rtti)
  if (CMAKE_BUILD_TYPE MATCHES Debug)
    list(APPEND PROJECT_CONFIG "#define _DEBUG")
    list(APPEND PROJECT_COMPILER_OPTIONS -O0 -g)
  else()
    list(APPEND PROJECT_CONFIG "#define NDEBUG")
    list(APPEND PROJECT_COMPILER_OPTIONS -O3)
  endif()
  # linker thread library
  list(APPEND PROJECT_LINKER_OPTIONS -pthread)
elseif(WIN32)
  #reset all defaults flags
  set(CMAKE_C_FLAGS "")
  set(CMAKE_C_FLAGS_DUBUG "")
  set(CMAKE_C_FLAGS_RELEASE "")
  set(CMAKE_CXX_FLAGS "")
  set(CMAKE_CXX_FLAGS_DUBUG "")
  set(CMAKE_CXX_FLAGS_RELEASE "")
  list(APPEND PROJECT_COMPILER_OPTIONS /std:c++20 /EHa /JMC /permissive- /GS /W4 /Zc:inline /WX- /FC /Zi)
  list(APPEND PROJECT_CONFIG "#define _CONSOLE")
  list(APPEND PROJECT_CONFIG "#define _WINDOWS")
  if (CMAKE_BUILD_TYPE MATCHES Debug)
		#limit for ninja (by default ninja configure for all targets)
    set(CMAKE_CONFIGURATION_TYPES Debug)
    list(APPEND PROJECT_CONFIG "#ifndef _DEBUG \n#define _DEBUG \n#endif")
    #add_definitions(-D_DEBUG)
    list(APPEND PROJECT_COMPILER_OPTIONS /Od /MDd)
  else()
		set(CMAKE_CONFIGURATION_TYPES Release)
    list(APPEND PROJECT_CONFIG "#define NDEBUG")
    list(APPEND PROJECT_COMPILER_OPTIONS /O2 /GL /Gy /MT /Gd /Oi)
  endif()
endif()

