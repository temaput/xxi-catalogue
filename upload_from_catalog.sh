xslt=xml/upload-from-catalog.xsl
result=result/from_catalog.xml
java -classpath ~/xml/saxon9he.jar net.sf.saxon.Transform $1 $xslt -o:$result
