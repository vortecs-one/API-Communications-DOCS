bundle exec middleman build
sudo rm -r /var/www/html/test/
sudo cp -r build /var/www/html/test
sudo systemctl restart nginx
