The following is how James customizes a fresh installation of Xubuntu (Xubuntu
is Ubuntu - Gnome + Xfce).

| What               | Xubuntu equivalent |
| ------------------ | -------------------|
| notepad.exe        | mousepad           |
| Mac 'open' command | thunar             |
| File manager       | thunar             |
| Terminal           | xfce4-terminal     |
| Web browser        | firefox            |

#### 1. Fix the desktop and terminal UIs.

* Right-click the desktop.  Click "Desktop Settings...".  In the Background tab, select the Style dropdown and set it to None.  In the Icons tab, unselect the default icons.

* Go back to the desktop.  Click the top left button on the screen, then Accessories, then Terminal Emulator.  In the terminal window, click Edit > Preferences.  Under the General tab, increase the scrollback.  Under the Colors tab, fix the background.  Under the Appearance tab, fix the font.

#### 2. On the desktop, fix the top bar UI.

* Right-cick the top bar > Panel > Add Items...
* Add multiple workspaces.
* Add CPU/RAM/load monitoring.
* Etc.

#### 3.  Make the function keys of an apple keyboard work (on startup).

* To do this, modify /etc/rc.local to add this line before "exit 0" is called:

```
echo 0 > /sys/module/hid_apple/parameters/fnmode
```

#### 4. Add scripts that spawn shells.

* Create i/scripts/spawn_one_shell.sh with this text:

```
#!/bin/sh
xfce4-terminal --maximize &
```

* Create i/scripts/spawn_three_shells.sh with this text (this is only an example, as correct dimensions vary depending on the screen resolution and font):

```
#!/bin/sh
xfce4-terminal --geometry 102x90+0+0 &
xfce4-terminal --geometry 102x90+645+0 &
xfce4-terminal --geometry 102x90+1290+0 &
```

#### 5. Get bash and vi right.

* Set your .bashrc.
* sudo apt-get install vim
* Set any custom vim color files (~/.vim/colors/).
* Set your .vimrc.

#### 6. Configure git.

* Install git.

```
sudo apt-get install git gitk
```

* Create your ~/.gitconfig, for example

```
[user]
    email = iamknighton@example.com
    name = James Knighton
[core]
    editor = vim
[push]
    default = simple
```

#### 7. Use firefox to download and install chrome and opera.

#### 8. Keyboard shortcuts.

* From the desktop, click the top-left button, go to Settings > Keyboard.  In the Application Shortcuts tab, assign shortcuts, for example:

  * F1 = google-chrome
  * F2 = firefox
  * F3 = ~/i/scripts/spawn_one_shell.sh
  * F4 = ~/i/scripts/spawn_three_shells.sh
  * F5 = opera

#### 9. Configure SSH.

* Allow inbound SSH.

```
sudo apt-get install ssh
```

* Set your motd.

* Possibly muck with what port to listen on, timeout, etc. in /etc/ssh/sshd_config.

#### 10. Misc.

```
sudo apt-get install curl
```
