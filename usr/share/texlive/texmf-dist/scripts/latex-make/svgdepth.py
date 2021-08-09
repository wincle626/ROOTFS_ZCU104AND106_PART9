#!/usr/bin/python3
#coding=utf8

import sys
import xml.parsers.expat

layers = []
for arg in sys.argv:
  layers.append(arg)

parser = xml.parsers.expat.ParserCreate()
class XmlParser(object):
    def __init__(self, layers):
        self.state_stack = [True]
        self.last_state = True
        self.layers = layers
    def XmlDeclHandler(self, version, encoding, standalone):
        sys.stdout.write("<?xml version='%s' encoding='%s'?>\n" % (version, encoding))
    def StartDoctypeDeclHandler(self, doctypeName, systemId, publicId, has_internal_subset):
        if publicId != None: sys.stdout.write("<!DOCTYPE %s PUBLIC \"%s\" \"%s\">\n" %\
            (doctypeName, publicId, systemId))
        else: sys.stdout.write("<!DOCTYPE %s \"%s\">\n" % (doctypeName, systemId))
    def StartElementHandler(self, name, attributes):
        if name.lower() == 'g':
            r = self.last_state and ('id' not in attributes or \
                attributes['id'] in self.layers)
            self.last_state = r
            self.state_stack.append(r)
        if not self.last_state: return
        s = ""
        for k, v in attributes.items(): s += ' %s="%s"' % (k, v)
        sys.stdout.write("<%s%s>" % (name, s))
    def EndElementHandler(self, name):
        r = self.last_state
        if name.lower() == 'g':
            self.state_stack = self.state_stack[0:-1]
            self.last_state = self.state_stack[-1]
        if not r: return
        sys.stdout.write("</%s>" % (name))
    def CharacterDataHandler(self, data):
        if not self.last_state: return
        sys.stdout.write(data)

my_parser = XmlParser(layers)

parser.XmlDeclHandler = my_parser.XmlDeclHandler
parser.StartDoctypeDeclHandler = my_parser.StartDoctypeDeclHandler
parser.StartElementHandler = my_parser.StartElementHandler
parser.EndElementHandler = my_parser.EndElementHandler
parser.CharacterDataHandler = my_parser.CharacterDataHandler

for line in sys.stdin:
    parser.Parse(line, False)
parser.Parse('', True)

