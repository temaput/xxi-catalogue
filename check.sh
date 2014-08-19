result=result/check.html
check=xsl/check.xsl


java -classpath ~/xml/saxon9he.jar net.sf.saxon.Transform $1 $check -o:$result
