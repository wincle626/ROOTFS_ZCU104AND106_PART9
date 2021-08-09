#!/usr/bin/python3
#coding=utf8

"""

stdin : the original xfig file
stdout : the output xfig file
args : all depths we want to keep

"""

from __future__ import print_function
import optparse
import os.path
import sys

def main():
    parser = optparse.OptionParser()
    (options, args) = parser.parse_args()

    depths_to_keep = set()
    for arg in args:
        depths_to_keep.add(arg)

    comment = ''
    display = True
    def show(depth, line):
        if depth in depths_to_keep:
            print(comment+line, end='')
            return True
        else:
            return False
    for line in sys.stdin:
        if line[0] == '#':
            comment += line
            continue
        if line[0] in "\t ":
            if display:
                print(line, end='')
        else:
            Fld = line.split(' ', 9999)
            if not Fld[0] or Fld[0] not in ('1', '2', '3', '4', '5'):
                print(comment+line, end='')
                display = True
            elif Fld[0] == '4':
                display = show(Fld[3], line)
            else:
                display = show(Fld[6], line)
            comment = ''

if __name__ == "__main__":
    main()
