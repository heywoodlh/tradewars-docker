FROM ubuntu:latest
LABEL maintainer="heywoodlh"

RUN dpkg --add-architecture i386 &&\
	apt-get update &&\
	apt-get install -y wine-development wine32-development

RUN useradd -ms /bin/bash twgs
RUN chown -R twgs:twgs /opt/
RUN passwd -l root
RUN passwd -l twgs

COPY wine /home/twgs/.wine
RUN chown -R twgs:twgs /home/twgs/.wine

USER twgs
WORKDIR /home/twgs/
ENV WINEARCH=win32

ENTRYPOINT /usr/bin/wine /home/twgs/.wine/drive_c/Program\ Files/EIS/TWGS/twgs.exe
