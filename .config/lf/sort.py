#!/usr/bin/env python

import os
import sys


def categorize_and_sort(directory: str) -> list[str]:
    try:
        entries = os.listdir(directory)
    except (PermissionError, FileNotFoundError):
        return []

    folders: list[str] = []
    files: list[str] = []
    dotfolders: list[str] = []
    dotfiles: list[str] = []

    for entry in entries:
        full_path = os.path.join(directory, entry)
        is_hidden = entry.startswith(".")
        is_dir = os.path.isdir(full_path)

        if not is_hidden and is_dir:
            folders.append(entry)
        elif not is_hidden and not is_dir:
            files.append(entry)
        elif is_hidden and is_dir:
            dotfolders.append(entry)
        else:
            dotfiles.append(entry)

    folders.sort(key=str.lower)
    files.sort(key=str.lower)
    dotfolders.sort(key=str.lower)
    dotfiles.sort(key=str.lower)

    return folders + files + dotfolders + dotfiles


def main() -> None:
    if len(sys.argv) < 2:
        directory = os.getcwd()
    else:
        directory = sys.argv[1]

    sorted_entries = categorize_and_sort(directory)

    for entry in sorted_entries:
        print(entry)


if __name__ == "__main__":
    main()
