#!/usr/bin/env python

import sys
import time
import getopt
import socket
import platform

CARBON_SERVER = '200.10.1.145'
CARBON_PORT = 2003
METRIC = 'servers.%s.' % platform.node()


def send_metric(metric, value, timestamp):
	message = '%s%s %s %d\n' % (METRIC, metric, value, timestamp)

	sock = socket.socket()
	sock.connect((CARBON_SERVER, CARBON_PORT))
	sock.sendall(message)
	sock.close()

def main(argv):
    metric = ''
    value = ''
    timestamp = int(time.time())

    try:
    	opts, args = getopt.getopt(argv,"hm:v:t:",["metric=","value=","time="])
    except getopt.GetoptError:
    	print 'graph.py -m <metric> -v <value> -t <timestamp>'
    	sys.exit(2)

    for opt, arg in opts:
      	if opt == '-h':
            print 'graph.py -m <metric> -v <value> -t <timestamp>'
            sys.exit(1)
      	elif opt in ("-m", "--metric"):
            metric = arg
      	elif opt in ("-v", "--value"):
            value = arg
      	elif opt in ("-t", "--time"):
            timestamp = int(arg)
   	
    send_metric(metric, value, timestamp)


if __name__ == '__main__':
    if len(sys.argv) == 1:
    	print 'graph.py -m <metric> -v <value>'
        sys.exit(1)

    main(sys.argv[1:])
    sys.exit(0)
