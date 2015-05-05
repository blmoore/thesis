pandoc intro.md --to=latex | cat head.tex - foot.tex > intro.tex
pandoc intro.md --to=html > intro.html
latexmk intro.tex -quiet

# tidy up
rm *.log
rm *.bbl
rm *.aux
rm *.fls
rm *.blg
#rm *.bcf
#rm *.run.xml
rm *.fdb_latexmk
rm *.out
