# ROOTING GUIDE: REVVL4+ MODEL 5062W (T-MOBILE)

### 1. PREPARATIONS

**IMPORTANT: BEFORE STARTING, BACKUP ANYTHING ON YOUR PHONE YOU DON'T WANT TO LOSE!!!**
  
**ANDROID**:    

  1. Enable Developer Mode:
    - Open Settings -> About Phone
    - Tap "Build number" 7 times
    - Navigate to Settings -> System -> Advanced -> Developer options
  2. Enable USB Debugging
  3. Enable OEM Unlocking

**WINDOWS**:

  1. Download and install each of the following programs:
    
   - [MediaTek USB Drivers](https://androidfilehost.com/?fid=14943124697586345377)    
   - [UsbDk](https://github.com/daynix/UsbDk/releases/download/v1.00-22/UsbDk_1.0.22_x64.msi)
   - [Microsoft C++ Build Tools](https://aka.ms/vs/17/release/vs_BuildTools.exe)
   - [OpenSSL](https://slproweb.com/download/Win64OpenSSL-3_4_0.exe)
   - [Python 3.10](https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe)     
        ***Note: Ensure the box next to "Add Python to PATH" is checked before install!***
   
   - [Android SDK Platform-Tools for Windows](https://dl.google.com/android/repository/platform-tools-latest-windows.zip)

  2. Download [MTK Client](https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip) and extract 'mtkclient-main' to C:
  3. Open the Start Menu, type 'cmd' and choose 'Run as administrator' to open an elevated command terminal. Then, execute the following commands:
     
```
cd C:\mtkclient-main
python -m pip install -r requirements.txt

```



