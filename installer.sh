
# install dependencies
if ! type gsettings > /dev/null; then
    echo "error! this app won't work in your system, gnome is installed"
    exit '1'
fi
# sudo apt  update
if ! type xclip > /dev/null ;then
    sudo apt install -y xclip
fi
if ! type play > /dev/null ;then
    sudo apt install -y sox
fi
if ! type stoken > /dev/null ;then
    sudo apt install -y stoken
fi
sdtid="$1"
# dont use " in password"
passkey=${2:-' '} 
if ! [ -e "$sdtid" ]; then
    echo "$sdtid file does not exist exiting.."
    exit 1
fi
stoken import --file="$sdtid" --force --new-password=${passkey}
if  [ $? -ne 0 ];then
    echo "error in stoken installatin"
fi

echo "program began"
keys=`gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | grep -oE '[0-9]' | sort`
found='false'

for i in $keys ; do
    if [ "`gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ name`" = "'quick-rsa'" ] ;then
        #echo installation found at index $i
        found="true"
        break
    fi 
done

if [ "$found" = "false" ]; then 
        echo "adding new keyboard shortcut entry"
        i=$((${i:--1}+1))
        keys=`echo "${keys} $i" |xargs`
        if [ `echo $keys | grep -o ' ' | wc -l` -eq 0 ];then
            keyinterpol=$keys
        else 
            keyinterpol="{`echo $keys | tr ' ' ','`}"
        fi
        updatedKeys="['"$(eval "echo /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${keyinterpol}/"| sed "s/ /','/g")"']"
        # echo "cmd =>  $updatedKeys "
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$updatedKeys"
else 
    echo "installation found, will update"
fi

cat ./clipboardas.sh | sed "s/<PASPAPSPASPSAPSPADSDAS>/\"$passkey\"/" >"$HOME/.clipboardas.sh"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ name 'quick-rsa'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ binding '<Primary><Alt>r'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ command "/bin/bash $HOME/.clipboardas.sh"

echo "program finsihed"