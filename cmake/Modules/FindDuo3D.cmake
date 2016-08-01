# - Check for the presence of DUO3D for cross platform
#
# The following variables are set when DUO3D is found:
#  HAVE_DUO3D       = Set to true, if all components of DUO3D
#                          have been found.
#  DUO3D_INCLUDES   = Include path for the header files of DUO3D
#  DUO3D_LIBRARIES  = Link these to use DUO3D

## -----------------------------------------------------------------------------
## Check for the header files

find_path (DUO3D_INCLUDES <header file(s)>
  PATHS /usr/local/include /usr/include /sw/include
  PATH_SUFFIXES <optional path extension>
  )

## -----------------------------------------------------------------------------
## Check for the library

find_library (DUO3D_LIBRARIES <package name>
  PATHS /usr/local/lib /usr/lib /lib /sw/lib
  )

## -----------------------------------------------------------------------------
## Actions taken when all components have been found

if (DUO3D_INCLUDES AND DUO3D_LIBRARIES)
  set (HAVE_DUO3D TRUE)
else (DUO3D_INCLUDES AND DUO3D_LIBRARIES)
  if (NOT DUO3D_FIND_QUIETLY)
    if (NOT DUO3D_INCLUDES)
      message (STATUS "Unable to find DUO3D header files!")
    endif (NOT DUO3D_INCLUDES)
    if (NOT DUO3D_LIBRARIES)
      message (STATUS "Unable to find DUO3D library files!")
    endif (NOT DUO3D_LIBRARIES)
  endif (NOT DUO3D_FIND_QUIETLY)
endif (DUO3D_INCLUDES AND DUO3D_LIBRARIES)

if (HAVE_DUO3D)
  if (NOT DUO3D_FIND_QUIETLY)
    message (STATUS "Found components for DUO3D")
    message (STATUS "DUO3D_INCLUDES = ${DUO3D_INCLUDES}")
    message (STATUS "DUO3D_LIBRARIES     = ${DUO3D_LIBRARIES}")
  endif (NOT DUO3D_FIND_QUIETLY)
else (HAVE_DUO3D)
  if (DUO3D_FIND_REQUIRED)
    message (FATAL_ERROR "Could not find DUO3D!")
  endif (DUO3D_FIND_REQUIRED)
endif (HAVE_DUO3D)

mark_as_advanced (
  HAVE_DUO3D
  DUO3D_LIBRARIES
  DUO3D_INCLUDES
  )