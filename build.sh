pandoc plan.md --to=latex | cat head.tex - foot.tex > plan.tex
pandoc plan.md --to=html > plan.html
latexmk plan.tex -quiet
rm *.log
rm *.bbl
rm *.aux
rm *.fls
rm *.blg
rm *.bcf
rm *.out
rm *.run.xml
rm *.fdb_latemk
