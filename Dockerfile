FROM ubuntu:focal

ENV  DEBIAN_FRONTEND=noninteractive
COPY build/_helper.sh /root/
COPY build/_helper2.sh /root

# install OSMesa
COPY build/mesa.sh /root/
RUN  /root/_helper2.sh /root/mesa.sh

# install Embree
COPY build/embree.sh /root
RUN  /root/_helper2.sh /root/embree.sh

# install OSPRay
COPY build/ospray.sh /root/
RUN  /root/_helper2.sh /root/ospray.sh

# install ParaView
ARG paraview=5.8.1
ENV PARAVIEW_VERSION=${paraview}

COPY build/paraview.sh /root/
RUN  /root/_helper2.sh /root/paraview.sh

ENV PYTHONPATH=/usr/lib/python3.8/site-packages
EXPOSE 11111
# run pvserver by default
CMD /usr/bin/pvserver

# install Jupyter
COPY build/jupyter.sh /root/
RUN  /root/_helper2.sh /root/jupyter.sh
EXPOSE 8888

# install ZFP
COPY build/zfp.sh /root
RUN  /root/_helper2.sh /root/zfp.sh

# install Spectra
COPY build/spectra.sh /root
RUN  /root/_helper2.sh /root/spectra.sh

# install TTK
ARG ttk=dev
ENV TTK_VERSION=${ttk}

COPY build/ttk.sh /root/
RUN  /root/_helper2.sh /root/ttk.sh
