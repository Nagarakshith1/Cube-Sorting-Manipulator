#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ms/Lynx/src/image_pipeline-indigo/camera_calibration"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ms/Lynx/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ms/Lynx/install/lib/python2.7/dist-packages:/home/ms/Lynx/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ms/Lynx/build" \
    "/usr/bin/python" \
    "/home/ms/Lynx/src/image_pipeline-indigo/camera_calibration/setup.py" \
    build --build-base "/home/ms/Lynx/build/image_pipeline-indigo/camera_calibration" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ms/Lynx/install" --install-scripts="/home/ms/Lynx/install/bin"
