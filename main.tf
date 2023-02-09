

resource "aws_instance" "terra-ec2" {
  ami                    = "ami-0f4feb99425e13b50"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.key-tf4.key_name
 # vpc_security_group_ids = [aws_security_group.sg1.id]
  #user_data = file("${path.module}/script.sh")
  user_data = <<-EOF
    #!/bin/bash 
      sudo apt-get update -y
      sudo apt-get install nginx -y
      sudo apt-get install wget -y
      sudo apt install -y certbot python3-certbot-nginx -y
      sudo apt install curl
      sudo curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
      source ~/.bashrc
      sudo apt-get install wget -y
      sudo git clone --single-branch --branch main https://github.com/mosajjid/TestingDA /var/www/html/test --recursive
      cd ~
      curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
      sudo bash nodesource_setup.sh
      sudo apt install nodejs -y
      sudo apt install npm -y
      sudo npm install -g npm@9.2.0
      sudo npm install -g node-sass
      sleep 1
      sudo cp /tmp/.envfrontend /var/www/html/test/
      sudo cp /tmp/_variable-frontend.scss /var/www/html/test/src/components/components-css/
      sudo mv /var/www/html/test/.envfrontend /var/www/html/test/.env 
      sudo mv /var/www/html/test/_variable-frontend.scss /var/www/html/test/src/components/components-css/_variable.scss 
      cd /var/www/html/test/src/components/components-css/
      sudo node-sass App.scss index.css
      cd /var/www/html/test/
      export NODE_OPTIONS=--openssl-legacy-provider
      npm i --force
      sudo npm install jquery --force
      npm install react-loader-spinner --force
      npm run build
      cd /var/www/html/test/admin
      sudo cp /tmp/.env /var/www/html/test/admin
      sudo cp /tmp/_variable.scss /var/www/html/test/admin/src
      cd /var/www/html/test/admin/src 
      sudo node-sass App.scss index.css
      cd /var/www/html/admin
      export NODE_OPTIONS=--openssl-legacy-provider
      npm i --force
      sudo npm install jquery --force
      npm install react-loader-spinner --force
      npm run build
      sudo certbot
      sudo rm -f /etc/nginx/sites-enabled/default
      sudo cp /tmp/default /etc/nginx/sites-enabled/
      sudo cp /tmp/backend.conf /etc/nginx/sites-enabled/
      sudo ln -s /etc/nginx/sites-enabled/admin /etc/nginx/sites-available/
      sudo systemctl reload nginx 
      EOF
  tags = {
    Name = "Testing-DA-5"
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa") 
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "_variable.scss"
    destination = "/tmp/_variable.scss"
  }

  provisioner "file" {
    source      = "_variable-frontend.scss"
    destination = "/tmp/_variable-frontend.scss"
  }

  provisioner "file" {
    source      = ".env"
    destination = "/tmp/.env"
  }

  provisioner "file" {
    source      = ".envfrontend"
    destination = "/tmp/.envfrontend"
  }

  provisioner "file" {
    source      = "default"
    destination = "/tmp/default"
  }

  provisioner "file" {
    source      = "backend.conf"
    destination = "/tmp/backend.conf"
  }

}
