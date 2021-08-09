#!/usr/bin/python3
#coding=utf8

"""

Arguments passes :
    - fichier image (image.fig ou image.svg)
    - -s fichier subfig (image.subfig)
    - -p chemin du script pour generer les sous-images (svgdepth.py ou figdepth.py)

Sortie standard :
    - makefile pour creer les sous-images (au format .fig ou .svg), et pour les supprimer

"""

from __future__ import print_function
from optparse import OptionParser
import os.path

def main():
    parser = OptionParser(usage='usage: %prog [options] svg file', description='Creates a\
Makefile generating subfigures using figdepth.py or svgdepth.py')
    parser.add_option("-s", "--subfig", dest="subfig", help="subfig file")
    parser.add_option("-p", "--depth", dest="depth", help="full path of depth script")
    (options, args) = parser.parse_args()
    if len(args) < 1:
        parser.error("incorrect number of arguments")
    if not options.subfig:
        parser.error("no subfig file specified")
    if not options.depth:
        parser.error("no depth script specified")

    (root, ext) = os.path.splitext(args[0])
    sf_name = options.subfig
    ds_name = options.depth
    varname = '%s_FIGS' % root.upper()

    subfigs = []
    for line in open(options.subfig, 'r'):
        t = line.find('#') # looking for comments
        if t > -1: line = line[0:t] # remove comments...
        line = line.strip() #remove blank chars
        if line == '': continue
        subfigs.append(line)

    count = 1
    for subfig in subfigs:
        print("%s_%d%s: %s%s %s" % (root, count, ext, root, ext, sf_name))
        print("\t%s %s" % (ds_name, subfig))
        print("")
        count += 1
    print("%s := $(foreach n, " % varname, end='')
    count = 1
    for subfig in subfigs:
        print('%d ' % count, end='')
        count += 1
    print(", %s_$(n)%s)" % (root, ext))
    print("FILES_TO_DISTCLEAN += $(%s)" % varname)
    print("FIGS2CREATE_LIST += $(%s)" % varname)
    print("$(TEMPORAIRE): $(%s)" % varname)

if __name__ == "__main__":
    main()
