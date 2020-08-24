import json
import argparse


def make_arguments():

    parser = argparse.ArgumentParser(description='Load dotfile symlinks.')
    parser.add_argument(
        'config',
        metavar='CONFIG',
        help="Specify a config name given in ./config.json"
    )
    parser.add_argument('-d', '--dry', help="Dry run: don't write any symlinks.")

    return


def main():

    with open('./swapconfig.json', 'r') as f:
        config = json.load(f)
