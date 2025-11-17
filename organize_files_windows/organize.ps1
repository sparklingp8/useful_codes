# Base directory = folder where script is run
$BASE_DIR = Get-Location

# File extensions
$PHOTO_EXT = "jpg","jpeg","png","gif","bmp","tiff","webp","heic","heif"
$VIDEO_EXT = "mp4","mov","mkv","avi","mpeg","mpg","m4v","webm"
$PDF_EXT = "pdf"

$MAX_FILES = 500

function Choose-Folder {
    param(
        [string]$baseDir,
        [string]$type
    )

    $number = 1

    while ($true) {
        if ($number -eq 1) {
            $folder = Join-Path $baseDir $type
        } else {
            $folder = Join-Path $baseDir "$type`_$number"
        }

        if (!(Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder | Out-Null
        }

        $count = (Get-ChildItem -Path $folder -File | Measure-Object).Count

        if ($count -lt $MAX_FILES) {
            return $folder
        }

        $number++
    }
}

# Main loop for all files
Get-ChildItem -Path $BASE_DIR -Recurse -File | ForEach-Object {

    $FILE = $_.FullName

    # Skip this script itself
    if ($FILE -eq $PSCommandPath) { return }

    # Year from file timestamp
    $YEAR = $_.LastWriteTime.Year

    # Extension (lowercase)
    $EXT = $_.Extension.TrimStart('.').ToLower()

    $TYPE = "others"

    if ($PHOTO_EXT -contains $EXT) {
        $TYPE = "photos"
    }
    elseif ($VIDEO_EXT -contains $EXT) {
        $TYPE = "videos"
    }
    elseif ($EXT -eq "pdf") {
        $TYPE = "pdf"
    }

    # Create YEAR directory
    $YEAR_DIR = Join-Path $BASE_DIR $YEAR
    if (!(Test-Path $YEAR_DIR)) {
        New-Item -ItemType Directory -Path $YEAR_DIR | Out-Null
    }

    # Folder logic
    if ($TYPE -eq "photos") {
        $TARGET = Choose-Folder -baseDir $YEAR_DIR -type $TYPE
    } else {
        $TARGET = Join-Path $YEAR_DIR $TYPE
        if (!(Test-Path $TARGET)) {
            New-Item -ItemType Directory -Path $TARGET | Out-Null
        }
    }

    Move-Item -Path $FILE -Destination $TARGET -Force
    Write-Host "Moved: $FILE → $TARGET/"
}

# Cleanup empty folders
Get-ChildItem -Path $BASE_DIR -Recurse -Directory | `
    Where-Object { (Get-ChildItem -Path $_.FullName -Recurse | Measure-Object).Count -eq 0 } | `
    Remove-Item -Recurse -Force

Write-Host "---------------------------------------"
Write-Host "   ✔ Organizing complete!"
Write-Host "   ✔ Empty folders removed."
Write-Host "---------------------------------------"
