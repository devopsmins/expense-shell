log_file="/tmp/expense.log"
color="\e [33m"


echo -e "${color} installing Nginx"
dnf install nginx -y>>log_file
echo $?


echo -e "${color} coy enpense config file"
cp expense.conf /etc/nginx/default.d/expense.conf>>log_file
echo $?

echo -e "${color} clean olg nginx file"
rm -rf /usr/share/nginx/html/*>>log_file
echo $?

echo -e "${color} download frontend application code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip>>log_file
echo $?

echo -e "${color} extract downloaded application contet"
cd /usr/share/nginx/html>>log_file
unzip /tmp/frontend.zip>>log_file
echo $?


echo -e "${color} starting nginx services"
systemctl enable nginx>>log_file
systemctl restart nginx>>log_file
echo $?