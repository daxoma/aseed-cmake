# linker options
foreach(it ${PROJECT_LINKER_OPTIONS})
  target_link_libraries(${PROJECT_NAME} ${it})
endforeach()
