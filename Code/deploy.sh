echo "Making the TCPIP"
make TCPIP_Demo 
echo "starting tftp to 192.168.97.60"
(echo -e "binary\rtrace\rverbose\r" ; cat) | tftp 192.168.97.60
