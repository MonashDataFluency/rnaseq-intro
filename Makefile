
.PHONY : all pdf html clean deploy

all : pdf html 

pdf :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::pdf_book')"

html :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::gitbook')"
	cp -R book/figures docs
	
deploy :
	git subtree push --prefix docs origin gh-pages

clean :
	rm -rf docs/*
