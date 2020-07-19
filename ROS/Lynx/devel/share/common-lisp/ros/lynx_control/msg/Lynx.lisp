; Auto-generated. Do not edit!


(cl:in-package lynx_control-msg)


;//! \htmlinclude Lynx.msg.html

(cl:defclass <Lynx> (roslisp-msg-protocol:ros-message)
  ((states
    :reader states
    :initarg :states
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass Lynx (<Lynx>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Lynx>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Lynx)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lynx_control-msg:<Lynx> is deprecated: use lynx_control-msg:Lynx instead.")))

(cl:ensure-generic-function 'states-val :lambda-list '(m))
(cl:defmethod states-val ((m <Lynx>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lynx_control-msg:states-val is deprecated.  Use lynx_control-msg:states instead.")
  (states m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Lynx>) ostream)
  "Serializes a message object of type '<Lynx>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'states))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Lynx>) istream)
  "Deserializes a message object of type '<Lynx>"
  (cl:setf (cl:slot-value msg 'states) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'states)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Lynx>)))
  "Returns string type for a message object of type '<Lynx>"
  "lynx_control/Lynx")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Lynx)))
  "Returns string type for a message object of type 'Lynx"
  "lynx_control/Lynx")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Lynx>)))
  "Returns md5sum for a message object of type '<Lynx>"
  "cc004a42f08deecb6cd1bf0d3e91d0cd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Lynx)))
  "Returns md5sum for a message object of type 'Lynx"
  "cc004a42f08deecb6cd1bf0d3e91d0cd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Lynx>)))
  "Returns full string definition for message of type '<Lynx>"
  (cl:format cl:nil "float32[6] states~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Lynx)))
  "Returns full string definition for message of type 'Lynx"
  (cl:format cl:nil "float32[6] states~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Lynx>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'states) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Lynx>))
  "Converts a ROS message object to a list"
  (cl:list 'Lynx
    (cl:cons ':states (states msg))
))
