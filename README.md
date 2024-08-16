<h1 align="center">Readme & Documentation</h1>

This Ruby on Rails application helps users find the most relevant recipes that they can prepare with the ingredients that they have at home.

Hosted on fly.io <a href="https://cassandra-pennylane.fly.dev/">https://cassandra-pennylane.fly.dev/</a>

## Environment Setup

This application is using:
* Ruby 3.1.2
* Rails 7.1.3.4

In your terminal, run the following to clone the project onto your local machine:
```
git clone git@github.com:casscalescu/cassandra-pennylane.git
```

For the final setup for the packages, gems, remotes, prepping databases, and seed file, run the following:
```
bin/setup
```

Launch server
```
rails s
```


## User Stories
* As a user, I can input all the ingredients I have on hand
* As a user, I can see 10 results with recipes that each include all the ingredients I have (ordered by minimum extra ingredients needed)
* As a user, if my ingredients match less than 10 recipes, I see an additional bonus 10 recipes, all including at least 1 ingredient I have
* As a user, if I don't input any ingredients, I can browse through 10 random recipes

## DB Schema

<img width="412" alt="Screenshot 2024-08-15 at 4 02 41 pm" src="https://github.com/user-attachments/assets/ed6108bc-ea53-4f88-97dc-cb47d143272a">


## Testing
To run the test suite run:
```
bundle exec rspec
```
