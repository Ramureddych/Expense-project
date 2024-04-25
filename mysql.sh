#!/bin/bash

USERID=$(id -u)


LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%F-%H-%M-%S)
echo "LOGFILES: $LOGFILE"

validate(){

    if [ $1 -ne 0 ]
    then 
        echo "$2 is failing..."
        exit 1
    else
        echo "$2 is success"
    fi        
}





if [ $USERID -ne 0 ]
then
    echo "you are not a super user"
    exit 1
else 
    echo "you are a super user, please proceed"
fi


dnf install mysql-server -y  &>>$LOGFILE
validate $? "installing mysql-server"


systemctl enable mysqld &>>$LOGFILE
validate $? "enabled mysqld service"


systemctl start mysqld &>>$LOGFILE
validate $? "started mysqld service"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
validate $? "sets root password dor mysqlservice"




