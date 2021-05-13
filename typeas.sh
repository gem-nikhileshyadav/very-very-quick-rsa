# not using
# there is an issue with this script
# modfiers keys will behave weirdly due to --clearmodifiers
# in search for solution
password=' '
token=`echo "$password"|stoken -s`
if  ! [ -z "$token" ]; then
    echo "$token" | grep -o . | paste -sd " " - | xargs xdotool key --clearmodifiers
    play -q -n synth 0.1 sin 900 
else 
   play -q -n synth 0.2 sin 600 
fi