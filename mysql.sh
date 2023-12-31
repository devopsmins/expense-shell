log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} disable Mysql default version \e[0m"
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} copy Mysql repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} Install myqsl server \e[0m"
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} start mysql sever \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} set Mysql password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi


