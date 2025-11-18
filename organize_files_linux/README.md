Here’s a clean, professional **README.md** for your script:

---

# 📂 Files Organizer Script (Linux)

A simple yet powerful Bash script to automatically organize your photos, videos, and PDFs into **year-based folders**, with photos further split into numbered subfolders (e.g., `photos`, `photos_2`, `photos_3`, …) once a folder exceeds a configurable limit.

---

## ✨ Features

* Organizes files by **year** based on file modification time

  * Example: `2023/photos/`, `2024/videos/`, `2022/pdf/`
* Automatically classifies files into:

  * **Photos:** jpg, jpeg, png, gif, bmp, tiff, webp, heic, heif
  * **Videos:** mp4, mov, mkv, avi, mpeg, mpg, m4v, webm
  * **PDFs:** pdf
  * All other files go into `others/`
* Auto-splits photo folders after reaching **MAX_FILES** (default: 500)
  → creates `photos`, `photos_2`, `photos_3`, etc.
* Deletes all empty folders after organizing.
* Safe: Skips moving the script itself.

---

## 🛠️ How It Works

1. Takes the **directory where the script is run** as `BASE_DIR`.
2. Scans recursively for all files.
3. Detects the file type based on extension.
4. Extracts the file’s **YEAR** using:

   ```bash
   date -r "$FILE" +"%Y"
   ```
5. Moves the file into:

   ```
   BASE_DIR/YEAR/<photos|videos|pdf|others>
   ```
6. Photo folders auto-grow:

   * If `photos` has ≥500 files → use/create `photos_2`
   * If `photos_2` has ≥500 → use/create `photos_3`
   * And so on.

---

## ▶️ Usage

### 1. Save the script

Save the script as `organize.sh`.

### 2. Make it executable

```bash
chmod +x organize.sh
```

### 3. Run it in the folder that contains your files

```bash
./organize.sh
```

That's it! The folder will now be neatly organized.

---

## ⚙️ Configuration

### Change max photos per folder

Modify this line:

```bash
MAX_FILES=500
```

### Supported file types

You can edit the extension lists:

```bash
PHOTO_EXT="jpg jpeg png gif bmp tiff webp heic heif"
VIDEO_EXT="mp4 mov mkv avi mpeg mpg m4v webm"
PDF_EXT="pdf"
```

---

## 🧹 What Happens After Execution?

* Files neatly moved into structured directories.
* All empty folders anywhere under `BASE_DIR` are removed.
* A summary prints as files are moved.

---

## 📌 Notes

* The script uses **modification time**, not EXIF metadata.
* Works on macOS & Linux (BSD/GNU `find`, `date`, `tr` compatible).
* Does not overwrite existing files—mv will prompt or fail if conflicts occur.

---

## ✔️ Example Output

```
Moved: IMG_0012.jpg → 2023/photos/
Moved: IMG_0013.jpg → 2023/photos/
Moved: vacation.mp4 → 2022/videos/
🧹 Cleaning up empty folders...
🗑️ All empty folders removed.
```

---

