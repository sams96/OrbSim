(ql:quickload 'qt)
(use-package :qt)
(named-readtables:in-readtable :qt)

(defclass menu ()
  ((pos-x :accessor epos-x)
   (pos-y :accessor epos-y)
   (vel-x :accessor evel-x)
   (vel-y :accessor evel-y)
   (submit :accessor submit))
  (:metaclass qt-class)
  (:qt-superclass "QWidget")
  (:slots ("submit()" submit)))

(defmethod initialize-instance :after
    ((instance menu) &key)
  (new instance)
  (init-ui instance))

(defmethod init-ui ((instance menu))
  (#_setGeometry instance 200 200 300 300)
  (#_setWindowTitle instance "hello")
  (setf (epos-x instance) (#_new QLineEdit "X Pos" instance)
	(epos-y instance) (#_new QLineEdit "Y Pos" instance)
	(evel-x instance) (#_new QLineEdit "X Vel" instance)
	(evel-y instance) (#_new QLineEdit "Y Vel" instance)
	(submit instance) (#_new QPushButton "Submit" instance))
  (#_move (#_new QLabel "Hello" instance) 10 10)
  (#_move (epos-x instance) 10 40)
  (#_move (epos-y instance) 10 70)
  (#_move (evel-x instance) 10 100)
  (#_move (evel-y instance) 10 130)
  (#_move (submit instance) 10 160)
  (#_setMinimumWidth (epos-x instance) 270)
  (#_setMinimumWidth (epos-y instance) 270)
  (#_setMinimumWidth (evel-x instance) 270)
  (#_setMinimumWidth (evel-y instance) 270)
  (connect (submit instance) "clicked()" instance "submit()"))

(defmethod submit ((instance menu))
  (add-body (#_number (epos-x instance))
	    (#_number (epos-y instance))
	    (#_number (evel-x instance))
	    (#_number (evel-y instance))
	    10 3 sdl:*white*))

(defun init ()
  (make-qapplication)
  (with-main-window (window (make-instance 'menu))))