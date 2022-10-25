# EchoServer

## Installation

navigate to root directory and ruby below command:

    $ bin/setup_server
## V1
### Endpoints Controllers 
under ```app/controllers/api/v1``` our controller file exists and we use this controller to create our mocks
and save them in our postgres database

## Technical Details
### Tests

#### Routes Tests
routing Tests are exists in under the ```spec/routing``` folder

#### Request tests
its under request directory and intended to test integration of fuctionality, mock apis test is exists there

#### Controller test
its under controller directory and it test different aspects of fuctionality and input/output of api


### JSON and JSONB
we add jsonb to save raw data, its able to save duplicate keys its for rendering
also we add respose json is cobination of aheaders and attributes for query porpuses

you save duplicate data but its trade-off for searching performace

response column is reserved for searching purposes, we are not gonna show it


### Service layer
application uses service layer to decouple business logic from controller and each service is
single responsible


### Serializer 
serialization of application is handling in serializer folder using active model serializer project uses are using json api v1 specifications

**Note** there is some alternative handles serialization in as fast way, the reason behind using `active_model_serializer` is, its fully integrated
with rails and support serialization in OO way

### Potential Improvements
#### Decorator 
if you have complicated presentation layer its possible to use decorator to clean up your models my suggest is `draper` library, its has nice integration with
rails
### SimpleCov
test coverage exists under coverage directory its for development purposes so we put it in .gitignore 
file, to see result run `$ rspec` then run below command to open in your desired browser

in Mac

    $ open coverage/index.html

in Ubuntu

    $ xdg-open coverage/index.html

you can just simply open index.html in your browser

### ENV
environment variables defined in .env file and we use them for development purposes, it add env vars to ENV in rails

## JSON Validator

also its possible to use json validator for validate input structure, for this case its too much to use external lib for app
https://github.com/voxpupuli/json-schema

## Validation Per Method

you can validate mock api parameters per method, for ex: get can not have body params, this need to understand specification of these
parameters in details, I saw in elastic search we can use get with body params.

## Not Implemented Method
CONNECT: connect is intended only for use in requests to a proxy, so I'm not gonna implement it
OPTIONS: this is intented to commnucation options with server and respond server capablities, its not or our case
TRACE : is not applicable to our mock server 

## Error Handling
errors need to be parameterize to avoid some rails and database errors to shown in response


## Api Rule
there is no other keys allowed in main structure of api, you can add your data to data->attributes->response->body for what ever you want

## ActiveSupport JSON encode

## Logger
