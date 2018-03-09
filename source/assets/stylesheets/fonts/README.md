# Naming convention

`[version]-[lowercase-md5-hash]-[type]-[weight].[extension]`

* Version: current version of the font (e.g. v1, v2)
* Hash: md5 hash of the file truncated to 10 chars
* Type: type of character set (e.g. tabular)
* Weight: weight of the specific font file (e.g bold)
* Extension: file extension

Shell script written to generate the filenames when required:
`sh filename-generator.sh <font filename>`