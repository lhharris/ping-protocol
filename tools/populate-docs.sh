#!/usr/bin/env bash

for filename in src/definitions/*.json; do
    echo "Checking file: ${filename}"
    python3 -m json.tool ${filename} > /tmp/temporary_test_file.json;
    if ! comm -2 -3 ${filename} /tmp/temporary_test_file.json; then
        echo "Json file does not follow style. Try python3 -m json.tool."
        exit 1
    fi
done

src/generate-markdown.py --output-directory=docs

mkdocs build

htmlproofer --allow-hash-href --ignore-empty-alt --ignore-files "./ping-protocol/404.html" --ignore-urls "https://fonts.gstatic.com" || exit 1
