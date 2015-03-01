read -p 'puts application classname here (e.g. CarDetailing): ' classname
echo
read -p 'puts application database name here (e.g. car_detailing): ' db_name
echo

sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" Rakefile > tmpfile; mv -v tmpfile Rakefile
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" app/views/layouts/application.html.haml > tmpfile; mv -v tmpfile app/views/layouts/application.html.haml
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/application.rb > tmpfile; mv -v tmpfile config/application.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/environment.rb > tmpfile; mv -v tmpfile config/environment.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/environments/development.rb > tmpfile; mv -v tmpfile config/environments/development.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/environments/production.rb > tmpfile; mv -v tmpfile config/environments/production.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/environments/test.rb > tmpfile; mv -v tmpfile config/environments/test.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/initializers/secret_token.rb > tmpfile; mv -v tmpfile config/initializers/secret_token.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/initializers/session_store.rb > tmpfile; mv -v tmpfile config/initializers/session_store.rb
sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/routes.rb > tmpfile; mv -v tmpfile config/routes.rb

sed "s/GenericApplication/$classname/g;s/generic_application/$db_name/g" config/database.example.yml > tmpfile; mv -v tmpfile config/database.example.yml
cp -v config/database{.example,}.yml

bundle install

rake db:create:all

rails g devise:install
rails g devise User

rake db:migrate

git add --all; git commit -m "setup new $classname rails application"

function sleep_then_load_page() {
  sleep 5
  open http://localhost:9999
}

sleep_then_load_page &

rails server -p 9999

