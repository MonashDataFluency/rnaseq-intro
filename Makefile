
.PHONY : all pdf html clean

all : pdf html 

pdf :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::pdf_book')"

html :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::gitbook')"
	cp -R book/figures docs

clean :
	rm -rf docs/*
