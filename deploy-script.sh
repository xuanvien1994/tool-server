#!/bin/bash

# Function to display messages in green color
print_green() {
  echo -e "\e[32m$1\e[0m"
}

# Install Node.js and npm
print_green "Installing Node.js and npm..."
sudo apt update
sudo apt install -y nodejs npm

# Install Nginx
print_green "Installing Nginx..."
sudo apt install -y nginx

# Start Nginx
print_green "Starting Nginx..."
sudo service nginx start

# Set up your Node.js Project
print_green "Setting up your Node.js Project..."
read -p "Enter the absolute path for your Node.js project directory: " project_path

if [ ! -d "$project_path" ]; then
  echo "Directory not found: $project_path"
  exit 1
fi

cd "$project_path" || exit 1
npm init
npm install express  # Add other dependencies as needed

# Configure Nginx
print_green "Configuring Nginx..."
read -p "Enter your domain name (e.g., example.com): " domain_name

config_file="/etc/nginx/sites-available/$domain_name"
sudo touch "$config_file"
sudo cat > "$config_file" <<EOF
server {
    listen 80;
    server_name $domain_name www.$domain_name;

    location / {
        proxy_pass http://127.0.0.1:3000;  # Assuming your Node.js app is running on port 3000
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable the Nginx Configuration
sudo ln -s "$config_file" "/etc/nginx/sites-enabled/"
sudo nginx -t
sudo service nginx reload

# Run Your Node.js Project
print_green "Starting your Node.js Project..."
npm start  # Adjust this command if you use a process manager like pm2

print_green "Deployment completed successfully!"
