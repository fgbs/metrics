#!/usr/bin/env python
import sys
import time
import getopt
import datetime


def print_date(ts, fmt):
    print(datetime.datetime.fromtimestamp(int(ts)).strftime(fmt))


def main(argv):
    timestamp = 0
    format = '%Y-%m-%d %H:%M:%S'

    try:
        opts, args = getopt.getopt(argv,"ht:f:",["timestamp=","format="])
    except getopt.GetoptError:
        print 'ts2date.py -t <timestamp> [-f <format>]'
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print 'ts2date.py -t <timestamp> [-f <format>]'
            sys.exit(1)
        elif opt in ("-t", "--timestamp"):
            timestamp = arg
        elif opt in ("-f", "--format"):
            format = arg

    print_date(timestamp, format)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'ts2date.py -t <timestamp> [-f <format>]'
        sys.exit(1)

    main(sys.argv[1:])
    sys.exit(0)
