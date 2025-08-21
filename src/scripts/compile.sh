set -e
bun node_modules/xslt3/xslt3.js -t -xsl:src/xsl/tree.xsl -export:src/web/xsl/tree.sef.json -nogo
