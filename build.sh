pandoc plan.md --to=latex | cat head.tex - foot.tex > plan.tex
latexmk plan.tex -quiet
rm *.log
rm *.bbl
rm *.aux
rm *.fls
rm *.blg
rm *.bcf
rm *.run.xml
rm *.fdb_latemk
