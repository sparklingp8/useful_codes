Here is a clean, ready-to-use **README.md** for your PowerShell script.
You can copy-paste it directly into a file named **README.md**.

---

# 📁 File Organizer Script (PowerShell – Windows 11)

This PowerShell script automatically organizes your photos, videos, PDFs, and other files into **year-based folders**.
It also auto-splits large photo folders into `photos`, `photos_2`, `photos_3`, … if a folder exceeds **500 files**.

---

## ✅ Features

* Automatically detects file type (photos, videos, PDF, others)
* Organizes files by **year** using the file’s last modified timestamp
* Auto-splits photo folders (ex: `photos`, `photos_2`, `photos_3`, …)
* Works recursively inside all subfolders
* Removes all empty folders after organizing
* Skips the script file itself

---

## 📂 Folder Structure Example

```
2020/
    photos/
    photos_2/
    videos/
    pdf/
    others/

2021/
    photos/
    videos/
    others/
```

---

## 🛠 Supported File Types

### Photos

`jpg, jpeg, png, gif, bmp, tiff, webp, heic, heif`

### Videos

`mp4, mov, mkv, avi, mpeg, mpg, m4v, webm`

### PDF

`pdf`

### Everything else → `others/`

---

## 📦 Installation

1. Save the script as:

```
organize.ps1
```

2. Place the script **in the folder you want to organize**.

---

## ▶️ How to Run

Open PowerShell in the folder and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Then run the script:

```powershell
.\organize.ps1
```

---

## ⚙️ How It Works (Internal Logic)

### 1. Detect base directory

The script runs inside the current folder.

### 2. Read all files recursively

`Get-ChildItem -Recurse -File`

### 3. Extract:

* File extension
* Year from timestamp
* Category (photo, video, pdf, others)

### 4. Create year folder

Example: `2022/`

### 5. If photos → use *Choose-Folder*

This keeps each photo directory below the configured limit (**500 files**).

### 6. Move file into correct directory

### 7. Cleanup

Delete all empty folders left behind.

---

## ⚠️ Notes / Warnings

* This script **moves** files (not copies)
* Removing empty folders is permanent
* Make a backup if organizing important data
* Requires PowerShell 5+ (default in Windows 10/11)

---

## ✔ Example Output

```
Moved: D:\Pics\IMG_001.jpg → D:\Pics\2020\photos\
Moved: D:\Videos\movie.mp4 → D:\Pics\2020\videos\
Moved: D:\Docs\file.pdf → D:\Pics\2020\pdf\
---------------------------------------
   ✔ Organizing complete!
   ✔ Empty folders removed.
---------------------------------------
```

---

