from os import system as cmd,environ,path
from time import asctime,sleep
import re

__stoken_password = environ.get('passkey', '')
log_file = environ.get('logfile') if path.isfile(environ.get('logfile','')) else None

# stored commands
beepHigh = 'play -q -n synth 0.1 sin 900'
beepLow = 'play -q -n synth 0.1 sin 600'
getRSA = f'echo "{__stoken_password}"|stoken -s'
copyClipBoard = 'xclip -out -selection clipboard'
keyboard_type = 'xdotool key '
# util code
def log(text):
    log = f' {asctime()} : {text}'
    if not log_file:
        print(log)
    else:
        with open(log_file) as file:
            file.write(log)

if __name__ == '__main__':
    try:
        token=int(cmd(getRSA))
           
    except  ValueError as e:
        log(f'unable to get token for some reason, commands is {getRSA}')
    


   