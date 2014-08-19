notsorted=xsl/catalog-to-notsorted.xsl
sorted=xsl/notsorted-sort.xsl
icml=xsl/sorted-to-icml.xsl
result=result/price_table.icml


java -classpath ~/xml/saxon9he.jar net.sf.saxon.Transform $1 $notsorted -o:result/notsorted.xml
java -classpath ~/xml/saxon9he.jar net.sf.saxon.Transform result/notsorted.xml $sorted -o:result/sorted.xml
java -classpath ~/xml/saxon9he.jar net.sf.saxon.Transform result/sorted.xml $icml -o:$result
