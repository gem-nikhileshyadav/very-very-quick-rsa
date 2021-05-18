# very-very-quick-rsa 

 `CTRL`+`ALT`+`r` brings RSA token directly to clipboard

# INSTALLATION ⚙️
```bash
git clone https://github.com/gem-nikhileshyadav/very-very-quick-rsa
cd very-very-quick-rsa
/bin/bash installer.sh <sdtfile> <optional! new passkey used by stoekn to encrypt tokens stored on disk>
```

# USAGE
## activation :loud_sound:
pressing `CTRL`+`ALT`+`r` will make RSA token available in clipboard, signals via high tone beep sound

## deactivation  :sound:
Any of the following events deactivates it , signals via low tone beep sound, also restores old clipboard
- after 10 seconds period
- expiry of token
- pressing `CTRL`+`ALT`+`r` 


# NOTE :warning:
- need token file (.sdtfile) in xmlformat which must not require device id
- tested on gnome only
- contribute to typeas.sh 
- tested on bash, might not work on zsh or others

# TODO 
- uninstallation script
