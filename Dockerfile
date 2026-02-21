FROM alpine:3.19  
LABEL "language"="static"  
LABEL "framework"="vnc"  
RUN apk add --no-cache \  
    xvfb \  
    x11vnc \  
    novnc \  
    firefox \  
    supervisor \  
    bash \  
    dbus \  
    font-dejavu \  
    font-noto \  
    font-noto-cjk \  
    mesa-gl \  
    libxrender \  
    libxrandr \  
    libxi \  
    libxext \  
    libxdamage \  
    libxcomposite \  
    libxcursor \  
    libxtst \  
    libxinerama \  
    libxss \  
    libxkbcommon \  
    libxkbfile \  
    libxfixes \  
    libxfont2 \  
    pixman \  
    cairo \  
    pango \  
    glib \  
    gtk+3.0 \  
    adwaita-icon-theme \  
    hicolor-icon-theme \  
    shared-mime-info \  
    xauth \  
    xhost \  
    xset \  
    xrandr \  
    xmodmap \  
    setxkbmap \  
    xclip \  
    xsel \  
    curl \  
    wget \  
    git \  
    nano \  
    vim \  
    subversion  
WORKDIR /root  
RUN mkdir -p /var/run/dbus && \  
    mkdir -p /tmp/.X11-unix && \  
    chmod 1777 /tmp/.X11-unix && \  
    mkdir -p /var/log  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
EXPOSE 8080 5900  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]  
