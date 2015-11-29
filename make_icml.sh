source=../source.xml
stripped=../stripped.xml
notsorted=../notsorted.xml
sorted=../sorted.xml
result=../result.icml

strip=xsl/strip-whitespace.xsl
parse=xsl/catalog-to-notsorted.xsl
sort=xsl/notsorted-sort.xsl
icml=xsl/sorted-to-icml.xsl

xsltproc -o $stripped $strip $source
xsltproc --stringparam structure_doc structure.xml -o $notsorted $parse $stripped
xsltproc -o $sorted $sort $notsorted
xsltproc -o $result $icml $sorted
