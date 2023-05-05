# VMFirst

[![Telegram Badge](https://img.shields.io/badge/-HurbSquad-2ca5e0?style=flat&logo=telegram&logoColor=white&link=https://www.t.me/al1almasi)](https://www.t.me/HurbSquad)

VMFirst is a small stupid batchfile script created out of pure frustration over day to day need of configuring new made VMs. this script is designed around requiring almost zero user input to save time and confusion, they focus of the script is to get rid of the unnecessary windows bloatware and features that are not needed in a VM environment.

![VMFirst Screenshot](https://i.imgur.com/7iYThss.png)

## Why use it

The main advantage of VMFirst is ease of use and the time you can save with it. It is designed to let you focus on real important stuff while it gets the vm ready for you, which makes it great for **Mass VM installing** or **Repeated VM installation**.

I made this script for myself and my friends, but I decided to upload it here. I hope you find it useful as well.

## Usage
### Note: Run the script as administrator

1. Download the [latest release](https://github.com/ferixy/vmfirst/releases/)
2. Again, please run the script as administrator
3. enjoy!

## VMFirst Features


| Argument                  | Description                                                                              |
| ------------------------- | -----------------------------------------------------------------------                  |
| `Disable News and interest`     | Disables News and interests and widget.               |
| `Disable Advertising ID`                      | Disables and resets the microsoft advertising ID |
| `Disable Automatic Windows Updates`   | Disables Windows Automatic updates                                       |
| `Disable BingSearch` | Disables windows search with bing                                |
| `Disable Cortana`                 | Disables Cortana                                                             |
| `Disable MeetNow`     | Disables MeetNow button and adverting                                                                 |
| `Disable Mouse acceleration`       | Disables Mouse acceleration                                                              |
| `Disable SearchBar` | Disables the big ol search windows search bar on taskbar                                                         |
| `Disable Automatic download of promoted apps` | Disables the big ol windows search bar on taskbar                                                         | 
| `Disable telemetry` | Disables the nasty microsoft phone home thingy                                                        |
| `Disable Windows Defender` | Disables Windows Defender and its services to reduce cpu and disk usage                                                        |
| `Show file extensions ` | Makes explorer show file extension.                                                        |
| `Show hidden files` | Makes explorer show hidden files.                                                        |
| `Uninstall OneDrive` | Uninstalls OneDrive                                                        |
| `ReEnable Defender` | Incase if you want to reactivate windows defender, there is the option to reset windows defender and its services                                                        |


## Things to consider

- This script applies the changes in user(HKEY_CURRENT_USER) registry, it is recommended to run it on every user account on your VM.
- this script is intended to be used on a windows 10 VMs but you can try it on Windows 11 if you are feeling brave.
- you can run and use VMFirst as soon as you install windows, but it is recommended to run VMFirst after you install VMware/VirtualBox drivers on your OS.