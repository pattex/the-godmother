# README

This README would normally document whatever steps are necessary to get the
application up and running.

I used docker-compose to easily build and run the container. If we want to add, say, PostgreSQL, it's easily added to the docker-compose.yaml
(lots of good info at: https://docs.docker.com/compose/rails/)
1. Clone this repo
1. docker-compose build
1. docker-compose up
1. In another window:
    1. docker-compose run web rake db:create
    1. docker-compose run web bin/rails db:migrate RAILS_ENV=development 
1. In order to get things working as an admin I needed to:
    1. Browse to the running service and create a new mentor
    1. Steal the verification link URL from the logs (i.e. http://localhost:3000/verify_email/vyVpSqHmS6cGbyJvw2bEVc7J ) and browse there
    1. Make your user an admin with password 'password'
        1. docker-compose run web sqlite3 /myapp/db/development.sqlite3 
        1. update people set role=3 where id=1;
        1. update people set password_digest='$2y$12$d8W0ST9bWsiNCs.m22v0GefVMFcCBLBL/5r8tj7zSjLH28I6rJli2' where id=1;
        1. update people set name='MyName' where id=1;
1. Browse to /people and login with your email address and password 'password'

    

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
