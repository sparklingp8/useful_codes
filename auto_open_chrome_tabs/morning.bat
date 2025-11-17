@echo off
echo Good morning...

:: Start Outlook

:: start outlook.exe

:: Wait for 2 seconds to allow Outlook to start
timeout /t 2 /nobreak > nul

:: Start Chrome with multiple URLs
echo Opening Chrome with specified URLs...

:: Wait a bit between URLs to prevent overwhelming the system
timeout /t 1 /nobreak > nul
start chrome.exe "https://www.prajwalkadiyavar.com/5am"
timeout /t 1 /nobreak > nul
start chrome.exe "https://1drv.ms/o/c/7c13fcf4dee4e9eb/Euvp5N70_BMggHwNAQAAAAABLDzhsmuplEUyQjagEqPcOQ?e=TUfD5o"
timeout /t 1 /nobreak > nul
start chrome.exe "https://1drv.ms/o/c/7c13fcf4dee4e9eb/Euvp5N70_BMggHx0AAAAAAABvtFKKzzQFnu86EVUkklBqQ"
timeout /t 1 /nobreak > nul
start chrome.exe  "https://mynewnokiap8.pythonanywhere.com/time/countdowns/ptk"
timeout /t 1 /nobreak > nul
start chrome.exe  "https://mynewnokiap8.pythonanywhere.com/time/countdowns/python"
timeout /t 1 /nobreak > nul
start chrome.exe  "https://mynewnokiap8.pythonanywhere.com/time/countdowns/ms"
timeout /t 1 /nobreak > nul
