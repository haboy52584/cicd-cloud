# Install PostgreSQL
package 'postgresql' do
  action :install
end

# Enable and start PostgreSQL service
service 'postgresql' do
  action [:enable, :start]
end

# Create a user for the application
execute 'create-app-user' do
  command "sudo -u postgres createuser -s appuser"
  not_if "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_roles WHERE rolname='appuser'\" | grep -q 1"
end

# Create a database for the application
execute 'create-app-db' do
  command "sudo -u postgres createdb -O appuser appdb"
  not_if "sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw appdb"
end

