pandoc methods.md --to=latex | cat head.tex - foot.tex > methods.tex
#pandoc plan.md --to=html > plan.html
latexmk methods.tex -quiet
rm *.log
rm *.bbl
rm *.aux
rm *.fls
rm *.blg
rm *.bcf
rm *.run.xml
rm *.fdb_latemk
