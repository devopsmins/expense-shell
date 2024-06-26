log_file="/tmp/expense.log"
color="\e[33m"

MYSQL_ROOT_PASSWORD=$1

status_check()
{
  if [ $? -eq 0 ];then
    echo SUCCESS
    else
      echo FAILURE
  fi

}

echo -e "${color} disable NodeJs default version \e[0m"
dnf module disable nodejs -y &>>$log_file
status_check()

echo -e "${color} enable NodeJs 18 version\e[0m"
dnf module enable nodejs:18 -y &>>$log_file
status_check()


echo -e "${color} install nodejs \e[0m"
dnf install nodejs -y &>>$log_file
status_check()

echo -e "${color} coy backend service fie\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>$log_file
status_check()


echo -e "${color} add application user\e[0m"
id expense&>>$log_file
useradd expense &>>$log_file
if [ $? -nq 0 ];then
  useradd expense &>>$log_file
  else
    echo FAILURE
fi
status_check()


echo -e "${color} create application directory \e[0m"
mkdir /app &>>$log_file
status_check()


echo -e "${color} delete old alication content \e[0m"
rm -rf /app/* &>>$log_file
status_check()


echo -e "${color} download application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
status_check()


echo -e "${color} extract application content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
status_check()

echo -e "${color} download NodeJs dependecies\e[0m"
npm install &>>$log_file
status_check()

echo -e "${color} Install Mysql client to Load schema \e[0m"
dnf install mysql -y &>>$log_file
status_check()

echo -e "${color} load schema \e[0m"
mysql -h mysql-dev.devopsmins.online -uroot -p${¨MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>$log_file
status_check()

echo -e "${color} starting backend services\e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check()


