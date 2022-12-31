map(
    {
        "key": .tag_name | ltrimstr("cli/"),
        "value": .assets
            | map({
                "key": .name | ltrimstr("rome-"),
                # We'll replace the url with the shasum of that referenced file in a later processing step
                "value": .browser_download_url
            })
            | from_entries
    }
) | from_entries