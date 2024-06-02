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
	rm -f template-latex-polytech-dijon.zip
	mkdir build

	cp report-polytech-dijon.cls main.tex LICENSE README.md .gitignore .gitattributes .latexmkrc Makefile build/
	cp -r src Graphismes-polytech-dijon-Dijon build/

	cd build && zip -r ../template-latex-polytech-dijon.zip * .latexmkrc

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
