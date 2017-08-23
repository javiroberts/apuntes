import argparse

parser = argparse.ArgumentParser()

parser.add_argument('mu', type=int)
parser.add_argument('lambda', type=int)

args = parser.parse_args()

print args.mu
