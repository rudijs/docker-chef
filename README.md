sudo docker build -t rudijs/docker-chef .

sudo docker run -d -p 2222:22 -name chef rudijs/docker-chef

ssh-keygen -f ~/.ssh/known_hosts -R '[localhost]:2222'

ssh -v -p 2222 user@localhost