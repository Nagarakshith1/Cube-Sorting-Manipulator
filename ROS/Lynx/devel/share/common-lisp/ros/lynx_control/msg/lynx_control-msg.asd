
(cl:in-package :asdf)

(defsystem "lynx_control-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Lynx" :depends-on ("_package_Lynx"))
    (:file "_package_Lynx" :depends-on ("_package"))
  ))