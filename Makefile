.PHONY: default

# Generate PDF
default: clean
	@echo "Generating PDF..."
	mkdir out
	latexmk -pdf main.tex -output-directory=out

# Generate PNG from pdf
preview: default
	@echo "Generating PNG..."
	magick convert -density 150 out/main.pdf -quality 90 -background white -alpha remove -alpha off out/main.png

# Prepare archive to be used on Overleaf
archive:
	@echo "Preparing archive..."
	rm -rf build
	mkdir build

	cp report-ESIREM.cls main.tex LICENSE README.md .gitignore .gitattributes .latexmkrc Makefile build/
	cp -r src Graphismes-ESIREM build/

	cd build && zip -r ../template-latex-ESIREM.zip *

# Export the pdf and the png to the overveleaf folder
prepare_deploy: preview archive
	rm -rf overview
	mkdir overview

	cp out/main.pdf out/main-0.png out/main-1.png overview/

# Remove all temporary files
clean:
	@echo "Cleaning..."
	latexmk -C
	rm -rf out build
