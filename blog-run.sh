#!/bin/bash

# Check if a file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE=$1

# Get the file extension
EXT="${FILE##*.}"

case $EXT in
    md)
        # Convert Markdown to HTML and open in browser
        HTML_FILE="${FILE%.*}.html"
        pandoc "$FILE" -o "$HTML_FILE"
        if [ $? -eq 0 ]; then
            echo "Opening $HTML_FILE in the browser..."
            xdg-open "$HTML_FILE" 2> /dev/null || open "$HTML_FILE" || start "$HTML_FILE"
        else
            echo "Failed to convert $FILE to HTML."
        fi
        ;;
    html)
        # Open HTML file in the browser
        echo "Opening $FILE in the browser..."
        xdg-open "$FILE" 2> /dev/null || open "$FILE" || start "$FILE"
        ;;
    css)
        # Open CSS file in the default editor or browser
        echo "Opening $FILE in the default editor..."
        xdg-open "$FILE" 2> /dev/null || open "$FILE" || start "$FILE"
        ;;
    *)
        echo "Unsupported file type: $EXT"
        exit 1
        ;;
esac
chmod +x blog-run.sh
./blog-run.sh brains.workbook

