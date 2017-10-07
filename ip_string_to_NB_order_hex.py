import socket
import sys

ip = sys.argv[1];

ip = ip.split(".")

print "0x%02x%02x%02x%02x" % (int(ip[3]), int(ip[2]), int(ip[1]), int(ip[0]))


