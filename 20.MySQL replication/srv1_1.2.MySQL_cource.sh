#####################################################
# On MySQL Source
#####################################################

# Creating a user for a replica in MySQL
mysql -e "CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';" && \

# Replication rights for the "repl" user
mysql -e "GRANT REPLICATION SLAVE ON *.* TO repl@'%';" && clear && \

# Checking the user "repl"
mysql -e "SELECT User, Host FROM mysql.user;" && sleep 5 && \

# Master status
mysql -e "SHOW MASTER STATUS;"

