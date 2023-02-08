# BadPrinter

Have you ever had that bad day when you needed to print a document but the home printer just won't print a color? 😡

BadPrinter⚡ is a simple bash script to change all colors in a pdf document to a single specified color.
It's particularly useful for documents where it doesn't matter what color it's printed in - as long as it gets printed. 

Note, that the output pdf file does not have texts, but images. This is due to how the ```convert``` utility processes pdfs. But this is generally fine for printing.

## Prerequisites
1. qpdf
2. Imagemagick

## Usage

```bash
# convert all colors to blue(default), saved as out.pdf
./badprinter -f infile.pdf

# convert all colors to red
./badprinter -f infile.pdf -c red

# convert all colors to a shade of magenta 
./badprinter -f infile.pdf -c "#FF00FF"

# save to myoutfile.pdf
./badprinter -f infile.pdf -o myoutfile.pdf
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
