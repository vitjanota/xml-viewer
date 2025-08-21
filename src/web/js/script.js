document.addEventListener("DOMContentLoaded",() => {
    document.getElementById('xmlcode').addEventListener('keyup', checkXML);
});

// try to parse and if errors found, set as invalid; display tree otherwise
checkXML = () => {
    const elem = document.forms['editor'].elements['xmlcode'];      
    const parser = new DOMParser();
    const parsererrorNS = parser
        .parseFromString('INVALID', 'application/xml')
        .getElementsByTagName('parsererror')[0].namespaceURI;
    const dom = parser.parseFromString(elem.value, 'application/xml');
    if (dom.getElementsByTagNameNS(parsererrorNS, 'parsererror').length > 0) {
        elem.style.color = 'red';
    } else {
        elem.style.color = 'black';
        displayTree(elem.value);
    } 
}

// display xml tree in fancy mode
displayTree = async (xml) =>{
    const xslfile = await fetch(`${window.origin}/xsl/tree.sef.json`);
    const xsl = JSON.parse(await xslfile.text());
    SaxonJS.transform(
        {
            stylesheetInternal: xsl,
            sourceText: xml,
            destination: 'serialized',
        },
        'async',
    ).then((output) => {
        document.getElementById('treearea').innerHTML = output.principalResult.toString().trim();
    });
}
