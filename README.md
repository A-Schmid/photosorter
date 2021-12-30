# Photosorter

Little script to crawl a directory (and subdirs) for raw photos and copy them into another directory sorted by date.

Uses mediainfo to extract date from EXIF metadata.
As is, the script will only work with Canon raw files with the *.CR2* extension, but it should be quite easy to modify it to work with other formats.

## Usage

```sh photosorter.sh INPUT_DIR OUTPUT_DIR```

## Example

### Input

```
photos_unsorted/
│ 
├─ some_dir/
│  │ 
│  ├─ image-01.cr2      # created 2020-08-19
│  ├─ image-01.cr2.xmp
│  └─ image-02.cr2      # created 2020-09-05
│
└─ another_dir/
   │ 
   ├─ image-03.cr2      # created 2020-08-19
   └─ image-04.cr2      # created 2020-08-21
```

### Output

```
photos_sorted/
│ 
├─ 2020-08-19/
│  │ 
│  ├─ image-01.cr2
│  ├─ image-01.cr2.xmp
│  └─ image-03.cr2
│
├─ 2020-08-21/
│  │ 
│  └─ image-04.cr2
│
└─ 2020-09-05/
   │ 
   └─ image-02.cr2
```
