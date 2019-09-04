FROM archlinux/base

LABEL maintainer="heywoodlh"

COPY pacman.conf /etc/pacman.conf

RUN pacman -Sy wine wget xorg-server-xvfb x11vnc xdotool net-tools git fluxbox tar supervisor binutils sudo fakeroot --noconfirm

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /opt/twgs
RUN wget 'http://wiki.classictw.com/filearchive/apps/TWGS220B.EXE' -O /opt/twgs/TWGS220B.EXE

RUN useradd -m twgs
RUN echo "twgs ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R twgs:twgs /opt/

USER twgs

RUN git clone https://aur.archlinux.org/novnc.git /opt/novnc && \
	cd /opt/novnc && \
	makepkg -si --noconfirm

USER root

ENV DISPLAY :0
ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

WORKDIR /root

CMD ["/usr/bin/supervisord"]
