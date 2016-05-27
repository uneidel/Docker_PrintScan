FROM ubuntu:16.04
MAINTAINER uneidel@octonion.de

# in order to make cups work
#sudo apt-get install apparmor-utils
#sudo aa-complain cupsd

RUN apt-get update && apt-get -y dist-upgrade 
RUN apt-get install -y whois  sane tesseract-ocr tesseract-ocr-deu unpaper imagemagick gpm libxml2 cups
ADD http://downloadcenter.samsung.com/content/DR/201512/20151210091120064/uld_v1.00.37_00.99.tar.gz /install/uld.tar.gz
#ADD http://www.bchemnet.com/suldr/driver/UnifiedLinuxDriver-1.00.35.tar.gz /install/uld.tar.gz
RUN tar zxvf /install/uld.tar.gz
RUN /uld/noarch/package_install.sh printer-meta
RUN /uld/noarch/package_install.sh scanner-meta
COPY scripts/ /srv/scripts 

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.2/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /
RUN mkdir /srv/scanner
COPY /services /etc/s6/services/
ADD cups /etc/cups/
COPY s6init.sh /etc/cont-init.d/
#RUN rm -R /uld 
RUN apt-get -y autoremove && apt-get clean && rm -R /install && rm -rf /var/lib/apt/lists/*
EXPOSE 631
ENTRYPOINT ["/init"]
