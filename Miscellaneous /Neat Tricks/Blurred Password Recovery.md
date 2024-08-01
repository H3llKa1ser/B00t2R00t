# Password Recovery from Images

## Tool: https://github.com/spipm/Depix

### Image/File types: 

- .pdf

- .png

- .jpeg

- etc

### Pdf Image

 - 1) pdfimages -j FILE.pdf OUTPUT (Converts the PDF file to a .ppm file)
  
 - 2) python3 depix.py -p /path/to/OUTPUT-000.ppm -s ./images/searchimages/debruinseq_notepad_Windows10_closeAndSpaced.png -o /path/to/recovered.png (Recover the blurred password using the tool)
