##################
# SSH User Account
##################
/root/ssh_user_account.sh

##############
# Run services
##############

# run in the foreground with -n
supervisord -n
