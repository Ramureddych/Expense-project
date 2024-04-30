#!/bin/bash

USERID=$(id -u)

SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
echo "please enter the db password"
read -s my_root_password


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

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# validate $? "sets root password dor mysqlservice"

#this below code is for code to be idempotent in nature


mysql -h db.chilaka.fun -uroot -p${my_root_password} -e 'show databases;' &>>LOGFILE
if [ $? -ne 0 ]
then 
    echo "mysql_secure_installation --set-root-pass ${my_root_passsword} &>>LOGFILE"
    validate $? "mysql root password setup"
else 
    echo "root password already setup"
fi






