# - Check for the presence of Realsense for cross platform
#
# The following variables are set when REALSENSE is found:
#  HAVE_REALSENSE       = Set to true, if all components of REALSENSE
#                          have been found.
#  REALSENSE_INCLUDES   = Include path for the header files of REALSENSE
#  REALSENSE_LIBRARIES  = Link these to use REALSENSE

## -----------------------------------------------------------------------------
## Check for the header files

find_path (REALSENSE_INCLUDES <header file(s)>
  PATHS /usr/local/include /usr/include /sw/include
  PATH_SUFFIXES <optional path extension>
  )

## -----------------------------------------------------------------------------
## Check for the library

find_library (REALSENSE_LIBRARIES <package name>
  PATHS /usr/local/lib /usr/lib /lib /sw/lib
  )

## -----------------------------------------------------------------------------
## Actions taken when all components have been found

if (REALSENSE_INCLUDES AND REALSENSE_LIBRARIES)
  set (HAVE_REALSENSE TRUE)
else (REALSENSE_INCLUDES AND REALSENSE_LIBRARIES)
  if (NOT REALSENSE_FIND_QUIETLY)
    if (NOT REALSENSE_INCLUDES)
      message (STATUS "Unable to find REALSENSE header files!")
    endif (NOT REALSENSE_INCLUDES)
    if (NOT REALSENSE_LIBRARIES)
      message (STATUS "Unable to find REALSENSE library files!")
    endif (NOT REALSENSE_LIBRARIES)
  endif (NOT REALSENSE_FIND_QUIETLY)
endif (REALSENSE_INCLUDES AND REALSENSE_LIBRARIES)

if (HAVE_REALSENSE)
  if (NOT REALSENSE_FIND_QUIETLY)
    message (STATUS "Found components for REALSENSE")
    message (STATUS "REALSENSE_INCLUDES = ${REALSENSE_INCLUDES}")
    message (STATUS "REALSENSE_LIBRARIES     = ${REALSENSE_LIBRARIES}")
  endif (NOT REALSENSE_FIND_QUIETLY)
else (HAVE_REALSENSE)
  if (REALSENSE_FIND_REQUIRED)
    message (FATAL_ERROR "Could not find REALSENSE!")
  endif (REALSENSE_FIND_REQUIRED)
endif (HAVE_REALSENSE)

mark_as_advanced (
  HAVE_REALSENSE
  REALSENSE_LIBRARIES
  REALSENSE_INCLUDES
  )