
import os
import json
import argparse

from influxdb import InfluxDBClient

DBUSER=os.environ['DBUSER']
DBPASS=os.environ['DBPASS']
DBNAME=os.environ['DBNAME']
DBHOST=os.environ['DBHOST']
DBPORT=os.environ['DBPORT']


def main(host=DBHOST, port=8086, data=[]):
    client = InfluxDBClient(host, port, USER, PASSWORD, DBNAME)
    json_data = json.loads(data)

    #Write points
    client.write_points(json_data)


def parse_args():
    parser = argparse.ArgumentParser(
        description='example code to play with InfluxDB')

    parser.add_argument(
        '--host',
        type=str,
        required=False,
        default='200.10.1.45',
        help='hostname influxdb http API')

    parser.add_argument(
        '--port',
        type=int,
        required=False,
        default=8086,
        help='port influxdb http API')

    parser.add_argument(
        '--json',
        type=str,
        required=True,
        default=[],
        help='json data')

    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()
    main(host=args.host, port=args.port, data=args.json)
∫