!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(echo &0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log


if[ $USERID -ne 0 ]
then
    echo "you are not a super user"
    exit 1
else 
    echo "you are a super user, please proceed"
fi


dnf install $1 &>>$LOGFILE
validate $? "installing $1"

validate(){
    if [ $1 -ne 0 ]
    then 
        echo "$2 is failing..."
        exit 1
    else
        echo "$2 is success"
    fi        



}