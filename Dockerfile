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
RUN cat > /etc/supervisor/conf.d/supervisord.conf << 'EOF'  
[supervisord]  
nodaemon=true  
logfile=/var/log/supervisord.log  
pidfile=/var/run/supervisord.pid  
[program:xvfb]  
command=/usr/bin/Xvfb :99 -screen 0 1280x1024x24  
autostart=true  
autorestart=true  
stderr_logfile=/var/log/xvfb.err.log  
stdout_logfile=/var/log/xvfb.out.log  
[program:x11vnc]  
command=/usr/bin/x11vnc -display :99 -forever -nopw -listen localhost  
autostart=true  
autorestart=true  
stderr_logfile=/var/log/x11vnc.err.log  
stdout_logfile=/var/log/x11vnc.out.log  
[program:novnc]  
command=/usr/bin/novnc --vnc localhost:5900 --listen 8080  
autostart=true  
autorestart=true  
stderr_logfile=/var/log/novnc.err.log  
stdout_logfile=/var/log/novnc.out.log  
[program:firefox]  
command=/usr/bin/firefox --display=:99  
autostart=true  
autorestart=true  
stderr_logfile=/var/log/firefox.err.log  
stdout_logfile=/var/log/firefox.out.log  
EOF  
EXPOSE 8080 5900  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]  
