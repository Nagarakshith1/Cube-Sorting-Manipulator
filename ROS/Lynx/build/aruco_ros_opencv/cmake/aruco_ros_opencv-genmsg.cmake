# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "aruco_ros_opencv: 1 messages, 0 services")

set(MSG_I_FLAGS "-Iaruco_ros_opencv:/home/ms/Lynx/src/aruco_ros_opencv/msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(aruco_ros_opencv_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg" NAME_WE)
add_custom_target(_aruco_ros_opencv_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aruco_ros_opencv" "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(aruco_ros_opencv
  "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aruco_ros_opencv
)

### Generating Services

### Generating Module File
_generate_module_cpp(aruco_ros_opencv
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aruco_ros_opencv
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(aruco_ros_opencv_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(aruco_ros_opencv_generate_messages aruco_ros_opencv_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg" NAME_WE)
add_dependencies(aruco_ros_opencv_generate_messages_cpp _aruco_ros_opencv_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aruco_ros_opencv_gencpp)
add_dependencies(aruco_ros_opencv_gencpp aruco_ros_opencv_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aruco_ros_opencv_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(aruco_ros_opencv
  "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aruco_ros_opencv
)

### Generating Services

### Generating Module File
_generate_module_lisp(aruco_ros_opencv
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aruco_ros_opencv
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(aruco_ros_opencv_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(aruco_ros_opencv_generate_messages aruco_ros_opencv_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg" NAME_WE)
add_dependencies(aruco_ros_opencv_generate_messages_lisp _aruco_ros_opencv_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aruco_ros_opencv_genlisp)
add_dependencies(aruco_ros_opencv_genlisp aruco_ros_opencv_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aruco_ros_opencv_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(aruco_ros_opencv
  "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aruco_ros_opencv
)

### Generating Services

### Generating Module File
_generate_module_py(aruco_ros_opencv
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aruco_ros_opencv
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(aruco_ros_opencv_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(aruco_ros_opencv_generate_messages aruco_ros_opencv_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ms/Lynx/src/aruco_ros_opencv/msg/aruco_info_msg.msg" NAME_WE)
add_dependencies(aruco_ros_opencv_generate_messages_py _aruco_ros_opencv_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aruco_ros_opencv_genpy)
add_dependencies(aruco_ros_opencv_genpy aruco_ros_opencv_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aruco_ros_opencv_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aruco_ros_opencv)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aruco_ros_opencv
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(aruco_ros_opencv_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aruco_ros_opencv)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aruco_ros_opencv
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(aruco_ros_opencv_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aruco_ros_opencv)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aruco_ros_opencv\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aruco_ros_opencv
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(aruco_ros_opencv_generate_messages_py geometry_msgs_generate_messages_py)
endif()
