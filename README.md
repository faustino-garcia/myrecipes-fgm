# MyRecipes sample application

Based on the "Professional Ruby on Rails Developer with Rails 5" course on Udemy.

## Getting started

First of all, do you have ruby v2.75 and rails v6.1.5 installed?

- Windows 10: https://gorails.com/setup/windows/10
- macOS: https://gorails.com/setup/osx/12-monterey

Also, if you don't have node, install that too: https://heynode.com/tutorial/install-nodejs-locally-nvm/

To get started with the app, clone the repo and `cd` into the directory:

```
$ git clone https://github.com/coderdave/myrecipes.git
$ cd myrecipes
```

Then install the needed gems:

```
$ bundle install
```

Install JavaScript dependencies:

```
$ npm install
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

Open up your favorite browser (it better be Chrome) and go to:

```
http://localhost:3000/
```
