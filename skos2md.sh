# TODO: Integrate with github actions

# Fetch libraries
if [ ! -d "scripts/external-libs" ]; then
  mkdir -v scripts/external-libs
fi
if [ ! -f "scripts/external-libs/rdf2xml.jar" ]; then
  curl -L -k https://github.com/architolk/rdf2xml/releases/download/v1.2.1/rdf2xml.jar -o scripts/external-libs/rdf2xml.jar
fi
if [ ! -f "scripts/external-libs/skos2md.xsl" ]; then
  curl -L -k https://raw.githubusercontent.com/architolk/rdf2xml/refs/heads/main/skos2md.xsl -o scripts/external-libs/skos2md.xsl
fi
if [ ! -f "scripts/external-libs/skos2md-lijst.xsl" ]; then
  curl -L -k https://raw.githubusercontent.com/architolk/rdf2xml/refs/heads/main/skos2md-lijst.xsl -o scripts/external-libs/skos2md-lijst.xsl
fi
if [ ! -f "scripts/external-libs/skos2graphml.xsl" ]; then
  curl -L -k https://raw.githubusercontent.com/architolk/rdf2xml/refs/heads/main/skos2graphml.xsl -o scripts/external-libs/skos2graphml.xsl
fi
if [ ! -f "scripts/external-libs/skos2xmi.xsl" ]; then
  curl -L -k https://raw.githubusercontent.com/architolk/rdf2xml/refs/heads/main/skos2xmi.xsl -o scripts/external-libs/skos2xmi.xsl
fi

# Make markdown from skos
java -jar scripts/external-libs/rdf2xml.jar modellen/begrippen.ttl metamodel-begrippen.md scripts/external-libs/skos2md.xsl
java -jar scripts/external-libs/rdf2xml.jar modellen/begrippen.ttl metamodel-begrippenlijst.md scripts/external-libs/skos2md-lijst.xsl

# Create diagram
java -jar scripts/external-libs/rdf2xml.jar modellen/begrippen.ttl modellen/begrippen.graphml scripts/external-libs/skos2graphml.xsl ext modellen/begrippen-edited.graphml

# Create XMI export
java -jar scripts/external-libs/rdf2xml.jar modellen/begrippen.ttl modellen/begrippen.xmi scripts/external-libs/skos2xmi.xsl
