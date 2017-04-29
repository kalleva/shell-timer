#!/usr/bin/bash

# shell script that lets you track time you spent on tasks
# first command line argument is name of task you are working on
# if it's not supplied task has "default" value 

###### Functions

write_log_to_json() {
    head -n -1 $log_file > temp.log
    mv temp.log $log_file
    if [ $first_entry == "true" ] ; then
        printf "{\"begin_date\":\"$begin_date\", \"end_date\":\"$end_date\", \"task\":\"$task\"}\n]}" >> $log_file
    else
        printf ", {\"begin_date\":\"$begin_date\", \"end_date\":\"$end_date\", \"task\":\"$task\"}\n]}" >> $log_file
    fi
}

make_sound() {
(( speaker-test -t sine -f 1000 )& pid=$! ; sleep 0.5s ; kill -9 $pid ) \
>/dev/null
}

make_end_sound() {
(( speaker-test -t sine -f 200 )& pid=$! ; sleep 2s ; kill -9 $pid ) \
>/dev/null
}
###### Main

log_file="shell_timer.json"
first_entry="false"
task="default"


begin_date=$(date +%Y/%m/%d-%H:%M:%S)
echo "##########################"
echo "###### timer started #####"
echo $(date +%H:%M:%S)
echo "##########################"

if [[ $1 != "" ]] ; then 
    task=$1
fi

if [ ! -f "$log_file" ] ; then
    touch $log_file
    echo "{ \"chunks\": [" > $log_file
    echo "]}" >> $log_file
    first_entry="true"
fi

$(make_sound)
sleep 8m
$(make_sound)
sleep 8m
$(make_sound)
sleep 8m
$(make_sound)
sleep 8m
$(make_end_sound)

end_date=$(date +%Y/%m/%d-%H:%M:%S)
echo "##########################"
echo "###### timer ended #######"
echo "##########################"
$(write_log_to_json)
