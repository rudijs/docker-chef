###########################################################
# Create a 'user' user account if it does not already exist
###########################################################

# SSH user account name
USERNAME=user

# Get username entries
USER=`getent passwd $USERNAME`

if [ -z "$USER" ] ; then
  SSH_USERPASS=`pwgen -c -n -1 24`
  useradd -c 'Generic User Account' -d /home/$USERNAME -m -G sudo -s /bin/bash $USERNAME
  echo $USERNAME:$SSH_USERPASS | chpasswd
  echo "ssh $USERNAME password: $SSH_USERPASS"
else
  echo "Account '$USERNAME' exists"
fi