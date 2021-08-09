#!/usr/bin/python3
#coding=utf8

from optparse import OptionParser
import shutil
import subprocess

svg2eps = 'inkscape %s -z -C --export-eps=%s --export-latex'
svg2pdf = 'inkscape %s -z -C --export-pdf=%s --export-latex'

def create_image(input_filename, output_filename, mode):
    subprocess.Popen(mode % (input_filename, output_filename),
        stdout=subprocess.PIPE, shell=True).communicate()[0]
    n1 = output_filename + '_tex'
    n2 = output_filename + '_t'
    shutil.move(n1, n2)

def main():
    parser = OptionParser()
    parser.add_option("-L", "--format", dest="outputFormat",
        metavar="FORMAT", help="output format", default="spstex")
    parser.add_option("-p", "--portrait", dest="portrait", help="dummy arg")
    (options, args) = parser.parse_args()
    if len(args) != 2: return
    (input_filename, output_filename) = args
    fmt = options.outputFormat
    portrait = options.portrait

    if fmt == 'eps':
        create_image(input_filename, output_filename, svg2eps)
    elif fmt == 'spstex' or fmt == 'pstex':
        create_image(input_filename, output_filename, svg2eps)
    elif fmt == 'spstex_t' or fmt == 'pstex_t':
        pass
    elif fmt == 'spdftex' or fmt == 'pdftex':
        create_image(input_filename, output_filename, svg2pdf)
    elif fmt == 'spdftex_t' or fmt == 'pdftex_t':
        pass

if __name__ == "__main__":
    main()

