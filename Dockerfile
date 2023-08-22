FROM ubuntu:23.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Europe/Prague

RUN apt update
RUN apt install -y sassc python3-venv

RUN mkdir /home/jovyan
RUN python3 -m venv /home/jovyan
RUN . /home/jovyan/bin/activate && pip3 install 'notebook<7' rise 
RUN . /home/jovyan/bin/activate && pip3 install jupyter_contrib_nbextensions
RUN . /home/jovyan/bin/activate && jupyter contrib nbextension install --user
RUN . /home/jovyan/bin/activate && jupyter nbextension enable rise

RUN . /home/jovyan/bin/activate && pip3 install numpy matchms

WORKDIR /tmp
COPY ljocha.scss patch-reveal-themes.sh /tmp/

RUN sassc -I  /home/jovyan/share/jupyter/nbextensions/rise/reveal.js/css/theme/source ljocha.scss ljocha.css && ./patch-reveal-themes.sh ljocha.css && cp ljocha.css /home/jovyan/share/jupyter/nbextensions/rise/reveal.js/css/theme/

ENV HOME=/work
WORKDIR /work

COPY start.sh /home/jovyan/
ENTRYPOINT [ "/home/jovyan/start.sh" ] 
