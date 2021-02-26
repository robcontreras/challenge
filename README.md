## Getting Started

###Using Docker:
If you have docker installed you can either run the project or the specs.

Before running the service you'll need to provide the Google Search API and Bing Search API."

1. Copy the contents of `docker/.env.sample`
2. Create an env file `docker/.env` and paste the contents of the sample
3. Run the project/specs:

```
# running the server
docker-compose up

# running the specs
docker-compose run bundle exec rspec
```

###Not Using Docker:
You will need to have the following software installed:

1. Ruby (2.7.2)
2. The `bundler` gem (>=2.1.4)
3. Navigate to the project dir
4. Install gems: `bundle install`
5. Set the env variables in `doker/.env.sample` in your system
5. Run the tests: `bundle exec rake spec`
6. Run the project `rails server`
