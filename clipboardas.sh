password=<PASPAPSPASPSAPSPADSDAS>
        if ! [ -e ~/.clipboard_pre_rsa ]; then
                #backup clipboard, activation
                old_data=`xclip -out -selection clipboard`
                valid_for=$[ 59 - `date +%S` ]
                token=`echo "$password"|stoken -s`
                
                echo  "$old_data" > ~/.clipboard_pre_rsa
                echo $$ >> ~/.clipboard_pre_rsa
                printf $token| xclip -selection clipboard
                play -q -n synth 0.1 sin 900 ;
                sleep $[ $valid_for > 10 ? 10 : $valid_for  ];
                if [ -e ~/.clipboard_pre_rsa ];then

                        # deactivation
                        rm -rf  ~/.clipboard_pre_rsa;
                        play -q -n synth 0.1 sin 600;
                        printf "$old_data" | xclip -selection clipboard;
                fi
        else
                # deactivation
                head -n -1 ~/.clipboard_pre_rsa | xclip -selection clipboard
                kill -9  `tail -n 1 ~/.clipboard_pre_rsa`
                rm -rf ~/.clipboard_pre_rsa;
                play -q -n synth 0.1 sin 600;

        fi
