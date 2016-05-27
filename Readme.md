## Docker Image for Cups and ScanImage

# Components
based on ubuntu
S6-init 
cups 
Samsung Unified Driver
scanimage
tesseract
boxhandler (this little sh script uses a usb mouse to start scanning of a document)


#RUN this Image:
docker run --privileged -p 9100:9100 -p 5353:5353 -e CUPS_USER_ADMIN=cups -e CUPS_USER_PASSWORD=cups -p 631:631 '
-it -v /home/batzi:/srv/scanner -v /dev/bus/usb:/dev/bus/usb -v /var/run/dbus:/var/run/dbus imageName 



