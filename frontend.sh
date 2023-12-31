log_file="/tmp/expense.log"
color="\e[33m"


echo -e "${color} installing Nginx \e[0m"
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi


echo -e "${color} coy enpense config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} clean olg nginx file \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} download frontend application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi

echo -e "${color} extract downloaded application contet \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi


echo -e "${color} starting nginx services \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
if [ $? -eq 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi
