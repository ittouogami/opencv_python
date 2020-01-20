docker run -it --rm \
    --net host \
    -e LOCAL_UID=$(id -u $USER) \
    -e LOCAL_GID=$(id -g $USER) \
    -e USER=$USER \
    -e DISPLAY=$DISPLAY \
    -e "QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/docker/userhome:$HOME \
    --privileged \
    -w $HOME \
    opencv
