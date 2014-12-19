
import os
import json
import argparse

from influxdb import InfluxDBClient
from config import Config

cfg = Config()

def main(host=cfg.influxdb.DBHOST, port=cfg.influxdb.DBPORT, data=[]):
    client = InfluxDBClient(host, port, cfg.influxdb.DBUSER, cfg.influxdb.DBPASS, cfg.influxdb.DBNAME)
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
        default=cfg.influxdb.DBHOST,
        help='hostname influxdb http API')

    parser.add_argument(
        '--port',
        type=int,
        required=False,
        default=cfg.influxdb.DBPORT,
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
