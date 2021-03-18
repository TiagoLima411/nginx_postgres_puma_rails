# Digital Cash

Simple application for transferring values between application users

## Installation
To run the application it is assumed that you have installed Ruby Version Manager, with version 2.6.5 as default, and Mysql 5.7 to store the data. Below are links to official documentation.

[Ruby Version Manager](https://rvm.io/rvm/install).
After instalation run 'rvm install ruby-2.6.5'.

[MySql](https://dev.mysql.com/doc/refman/5.7/en/installing.html).
Make sure the service is running. And that the username and password is the same as that configured in the database.yml file.

Clone repository `git clone git@github.com:TiagoLima411/digital_cash.git`.
Enter the `digital_cash` folder.

### Set up Digital Cash app

First, install the gems required by the application:

    gem install bundle
    bundle install
    
Next, execute the database commands:

    rails db:create
    rails db:migrate
    rails db:seed

### Start the app

Start the Rails app to see the In-Context-Editor added to the To-Do application. You're ready to localize your app:

    rails s -b 0.0.0.0

You can find your app now by pointing your browser to http://localhost:3000.

LOGIN  
username: elon  
password: 123456   

## More information

To set environment variables, use the command below:

    EDITOR=nano rails credentials:edit

### Environment variables used so far.  
devise_key: <you_devise_key>  
email: <you_email_pagseguro>  
pag_seguro_test_token: <you_pagseguro_token>  
app_id: <you_pagseguro_app_id_>  
app_key: <you_pagseguro_app_key>  

To check your keys run the commands below:
    
    rails c
    Rails.application.credentials[Rails.env.to_sym][:you_key]

To run the tests:

    bin/rspec

This project is not yet in the production environment, any contribution or constructive criticism is welcome.
Any questions send email to `tiagolima.0411@gmail.com` or create issue.
Success to all.
