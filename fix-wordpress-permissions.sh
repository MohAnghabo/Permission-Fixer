#!/bin/bash

# Wordpress Owner
wordpress_owner=www-data

# Wordpress Group
wordpress_group=www-data # <-- wordpress group

# WordPress Engine Directory: first parameter after the run command
wordpress_dir=$1

# Webserver Group
server_group=www-data

# reset to safe defaults
find ${wordpress_dir} -exec chown ${wordpress_owner}:${wordpress_group} {} \;
find ${wordpress_dir} -type d -exec chmod 755 {} \;
find ${wordpress_dir} -type f -exec chmod 644 {} \;

# allow wordpress to manage wp-config.php (but prevent world access)
chgrp ${server_group} ${wordpress_dir}/wp-config.php
chmod 660 ${wordpress_dir}/wp-config.php

# allow wordpress to manage wp-content
find ${wordpress_dir}/wp-content -exec chgrp ${server_group} {} \;
find ${wordpress_dir}/wp-content -type d -exec chmod 775 {} \;
find ${wordpress_dir}/wp-content -type f -exec chmod 664 {} \;