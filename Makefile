#
# Build usable documents
#

ASCIIDOCTOR = asciidoctor
ASCIIDOCTOR_PDF = $(ASCIIDOCTOR)-pdf
DITAA = ditaa
TARGETS = riscv-aclint.pdf
TARGETS += riscv-aclint.html

.PHONY: all
all: $(IMAGES) $(TARGETS)

%.png: %.ditaa
	rm -f $@
	$(DITAA) $<

%.html: %.adoc $(IMAGES)
	$(ASCIIDOCTOR) -d book -b html $<

%.pdf: %.adoc $(IMAGES) docs-resources/themes/riscv-pdf.yml
	$(ASCIIDOCTOR_PDF) \
	-a toc \
	-a compress \
	-a pdf-style=docs-resources/themes/riscv-pdf.yml \
	-a pdf-fontsdir=docs-resources/fonts \
	-o $@ $<

.PHONY: clean
clean:
	rm -f $(TARGETS)

.PHONY: install-debs
install-debs:
	sudo apt-get install pandoc asciidoctor ditaa ruby-asciidoctor-pdf

.PHONY: install-rpms
install-rpms:
	sudo dnf install ditaa pandoc rubygem-asciidoctor rubygem-asciidoctor-pdf
