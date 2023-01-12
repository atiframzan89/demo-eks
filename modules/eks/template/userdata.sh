#!/bin/bash
set -x
sudo yum install nginx -y
sudo touch /etc/nginx/conf.d/dsprest.conf /etc/nginx/conf.d/dspweb.conf /etc/nginx/conf.d/mirth.conf /etc/nginx/conf.d/keycloak.conf

cat <<EOT >> /etc/nginx/conf.d/dsprest.conf
server {
        listen 443;
        server_name $DSP_REST.stella-apps.com;
        ssl on;
        ssl_certificate /etc/nginx/ssl/certificates/star.stella-apps.com-2022-2023.crt;
        ssl_certificate_key /etc/nginx/ssl/certificates/star.stella-apps.com.key;
        client_max_body_size 200M;
    #    add_header "Access-Control-Allow-Origin"  *;
     #   add_header "Access-Control-Allow-Methods" "GET, POST, OPTIONS, HEAD";
      #  add_header "Access-Control-Allow-Headers" "Authorization, Origin, X-Requested-With, Content-Type, Accept";

        location / {
           proxy_pass              https://localhost:30910;
           proxy_set_header        X-Real-IP $remote_addr;
           proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header        Host $http_host;
           #add_header "Access-Control-Allow-Origin"  *;
           #add_header "Access-Control-Allow-Methods" "GET, POST, OPTIONS, HEAD";
           #add_header "Access-Control-Allow-Headers" "Authorization, Origin, X-Requested-With, Content-Type, Accept";
           add_header X-XSS-Protection "1";
           add_header X-Frame-Options "SAMEORIGIN";
           add_header X-Content-Type-Options nosniff;
  
}
}

EOT