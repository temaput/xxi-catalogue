#! /bin/env python3
# set encoding=utf-8

""" Runs the xslt transformation scripts to prepare data for catalog layout:
    xml/catalog-to-notsorted.xsl
    xml/notsorted-sort.xsl
    xml/sorted-to-icml.xsl

    Creates 2 xml to be imported to indesign:
    result/price.icml - price table
    result/top.xml - top positions with annotation and cover

    Invocation: run_scripts.py catalog.xml topselection.xml

    catalog.xml should contain raw data for catalog as defined in
    AT-catalog.xsd

    topselection.xml should contain only positions to be printed in the
    top part of catalog. Only SKUs needed, like:

    <Каталог>
        <издание>
            <код>2308</код>
        </издание>
        <издание>
            <код>6808</код>
        </издание>
    </Каталог> """

from lxml import etree


def run(filename, topfile):
    plainSource = etree.parse(filename)  # first arg
    toNotSorted = etree.XSLT(etree.parse('xml/catalog-to-notsorted.xsl'))
    toSorted = etree.XSLT(etree.parse('xml/notsorted-sort.xsl'))
    toICML = etree.XSLT(etree.parse('xml/sorted-to-icml.xsl'))

    # this one we handle differently
    # need to insert topselect.xml inside
    toTop = etree.parse('xml/notsorted-to-top.xsl')
    xsl = r'http://www.w3.org/1999/XSL/Transform'
    topSelVar = toTop.xpath(
            "//xsl:variable[@name='topSelection']", namespaces={'xsl': xsl}
            )[0]  # we need to redefine this var inside xsl
    # it points now to the inside xml
    topSelVar.attrib['select'] = r"document('')/*/data:topselection/Каталог"

    datans = r'http://classica21.ru/catalogue'
    data = r'{http://classica21.ru/catalogue}'
    nsmap = {'data': datans}
    topSelElement = etree.SubElement(toTop.getroot(),
                '%stopselection' % data, nsmap=nsmap)
    topSelSource = etree.parse(topfile).getroot()
    from copy import deepcopy
    # here we insert the data from seconf arg into xsl
    topSelElement.append(deepcopy(topSelSource))
    toTop = etree.XSLT(toTop)

    # now everything is ready
    notSorted = toNotSorted(plainSource)
    icml = toICML(toSorted(notSorted))
    top = toTop(notSorted)

    from os import makedirs
    makedirs('result', exist_ok=True)
    with open('result/top.xml', 'wb') as topfile, \
            open('result/price.icml', 'wb') as icmlfile:
                icml.write(icmlfile, xml_declaration=True,
                           pretty_print=True, encoding='utf-8')
                from os.path import abspath
                print("Price table generated in {}".format(
                    abspath(icmlfile.name)))
                top.write(topfile, xml_declaration=True,
                        pretty_print=True, encoding='utf-8')
                print("Top data generated in {}".format(
                    abspath(topfile.name)))

if __name__ == '__main__':
    import sys
    if len(sys.argv) < 3:
        print (__doc__)
    run(sys.argv[1], sys.argv[2])
