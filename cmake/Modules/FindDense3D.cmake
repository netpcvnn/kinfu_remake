# - Check for the presence of DENSE3D for cross platform
#
# The following variables are set when DENSE3D is found:
#  HAVE_DENSE3D       = Set to true, if all components of DENSE3D
#                          have been found.
#  DENSE3D_INCLUDES   = Include path for the header files of DENSE3D
#  DENSE3D_LIBRARIES  = Link these to use DENSE3D

## -----------------------------------------------------------------------------
## Check for the header files

find_path (DENSE3D_INCLUDES <header file(s)>
  PATHS /usr/local/include /usr/include /sw/include
  PATH_SUFFIXES <optional path extension>
  )

## -----------------------------------------------------------------------------
## Check for the library

find_library (DENSE3D_LIBRARIES <package name>
  PATHS /usr/local/lib /usr/lib /lib /sw/lib
  )

## -----------------------------------------------------------------------------
## Actions taken when all components have been found

if (DENSE3D_INCLUDES AND DENSE3D_LIBRARIES)
  set (HAVE_DENSE3D TRUE)
else (DENSE3D_INCLUDES AND DENSE3D_LIBRARIES)
  if (NOT DENSE3D_FIND_QUIETLY)
    if (NOT DENSE3D_INCLUDES)
      message (STATUS "Unable to find DENSE3D header files!")
    endif (NOT DENSE3D_INCLUDES)
    if (NOT DENSE3D_LIBRARIES)
      message (STATUS "Unable to find DENSE3D library files!")
    endif (NOT DENSE3D_LIBRARIES)
  endif (NOT DENSE3D_FIND_QUIETLY)
endif (DENSE3D_INCLUDES AND DENSE3D_LIBRARIES)

if (HAVE_DENSE3D)
  if (NOT DENSE3D_FIND_QUIETLY)
    message (STATUS "Found components for DENSE3D")
    message (STATUS "DENSE3D_INCLUDES = ${DENSE3D_INCLUDES}")
    message (STATUS "DENSE3D_LIBRARIES     = ${DENSE3D_LIBRARIES}")
  endif (NOT DENSE3D_FIND_QUIETLY)
else (HAVE_DENSE3D)
  if (DENSE3D_FIND_REQUIRED)
    message (FATAL_ERROR "Could not find DENSE3D!")
  endif (DENSE3D_FIND_REQUIRED)
endif (HAVE_DENSE3D)

mark_as_advanced (
  HAVE_DENSE3D
  DENSE3D_LIBRARIES
  DENSE3D_INCLUDES
  )