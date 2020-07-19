
(cl:in-package :asdf)

(defsystem "aruco_ros_opencv-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "aruco_info_msg" :depends-on ("_package_aruco_info_msg"))
    (:file "_package_aruco_info_msg" :depends-on ("_package"))
  ))