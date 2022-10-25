# EchoServer

The boy of scout rule

## Requirements

I consider you already installed ruby, rails, postgres in your system

Please use `{ password: 'adminadmin', email: "admin@mail.com" }` data to login, app does not support registration process

## Installation

navigate to project root directory run below command:

    $ bin/setup_server

this script will install and resolve project dependencies and also connect to the postgres db

## ENV

system handles environments variables with [.dotenv](https://github.com/bkeepers/dotenv) library and we set env variables in .env file in root directory, so all variables is accesable through ENV.

Note. this is for development purposes

## Api Rule

Note. at the moment no extra attributes accepted from input, all data is restricted to specified data, you can add data only to headers and
body keys

## Application Modules

### Controllers
**ApplicationController:** we use this controller to rescue and format all our exception accures in our application, this include rails application errors and custom error `EchoError`.

under ```app/controllers/api/v1``` our controller file exists 

### Controllers V1

**EndpointsController:** we use this controller to create our mocks and save them in our postgres database.<br/>
**AuthenticationsController:** this controller provide login feature for users.<br/>
**BaseController:** we use our base controller to apply controller wide functionality and for now it handles requests authorization<br/>

### Models

**AuthToken:** we keep our authentication information jwt for now in this table and intention of separating is for safe logout after user jwt expired<br/>
**User:** this entity is for keeping our user data
**endpoints:** endpoint entity keep our mock data, response column is json and we created it for query purposes, so we keep mock headers and body in jsonb(raw data)
so all spaces and duplicate key is possible to these columns

### Services

Intention of creating service layer is clean up controller from business logic and model from some action specific validation.
each service attempted to be SRP and decoupled from other layers.

**ChopData:** this service in responsible for chop data primary keys as `data`, `attributes`, `response`. we use it in create and update service<br/>
**validate:** this service is validating input data, at the moment extra data only accepts inside of headers and body key, other keys is only whitelisted to specified ones, we use it in create and update service.<br/>
**Create:** this service is for creating our mock apis based on defined constraint in validate service.<br/>
**Update:** this service is for updating our mock apis based on defined constraint in validate service.<br/>
**Mock:** this service is for serve our created mocks and if saved data was valid json it return, if not raw data returned.<br/>
**SignIn:** this service handles login logic.<br/>

### Serializer

serialization of application is handling by `serializer` under serializer folder, used library is [active model serializer](https://github.com/rails-api/active_model_serializers)
it uses json api v1 specifications to format output json

**Note** there is some alternative handles serialization in a fast way, the reason behind using `active_model_serializer` is, its fully integrated
with rails and support serialization in OO way

### Controller Helper
    
app uses `Authenticable::JWT` to handle jwt encode and decode process and it exist under `controllers/concerns` folder

### Lib

**EchoError:** our custom error and message format in implemented in this module

## Technical Details

### Tests

#### Routes Test

routing Tests are exists in under the ```spec/routing``` folder

#### Requests Test

its under `spec/requests` directory and intended to test integration of functionality, some of mock apis test is exists there

#### Controllers Test

its under `spec/controllers/api/v1/` directory and it tests different aspects of functionality and input/output of api

#### Models Test

under `spec/models` directory our entities tests are exists

### JSON and JSONB
we add jsonb to save raw data, its able to save duplicate keys its for rendering also we add response json its combination of a headers and body and its for query purposes.<br/>
yes user save duplicate data but its trade-off for searching performance.<br/>
response column is reserved for searching purposes, we are not gonna show it.<br/>

### SimpleCov

test coverage exists under coverage directory its for development purposes so we put it in .gitignore 
file, to see result run `$ rspec` then run below command to open in your desired browser

in Mac

    $ open coverage/index.html

in Ubuntu

    $ xdg-open coverage/index.html

you can just simply open index.html in your browser

## Scenario Example

#### Step 1

<details>
  <summary>Login</summary>
  <markdown>

#### Request

    POST /login HTTP/1.1
    Content-Type: application/vnd.api+json
    Accept: application/vnd.api+json

    {
        "email": "admin@mail.com",
        "password": "adminpass"
    }

#### Example of Successful Response

    HTTP/1.1 201 Created
    Location: http://example.com/greeting
    Content-Type: application/vnd.api+json

    {
        "data": {
            "id": "2",
            "type": "users",
            "attributes": {
                "username": "admin",
                "email": "admin@mail.com",
                "authentication": {
                    "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJpYXQiOjE2NjY3MDAyNDIsImV4cCI6MTY2Njc4NjY0MiwiaXNzIjoidXNlciIsInN1YiI6ImVjaG9fdXNlciIsImF1ZCI6ImVjaG9fc3lzdGVtIn0.NFf9huTxxMh2dxlY1vpsWj7xPrrDHylQNjiKRZ1dCoM",
                    "exp": "2022-10-26T12:17:22.722Z"
                }
            }
          }
    }
  </markdown>
</details>

#### Step 2

<details>
  <summary>Create a Mock</summary>
  <markdown>

#### Create Request

    POST /api/v1/endpoints HTTP/1.1
    Content-Type: application/vnd.api+json
    Accept: application/vnd.api+json

    {
        "data": {
            "type": "endpoints",
            "attributes": {
                "verb": "GET",
                "path": "/greet",
                "response": {
                  "code": 200,
                  "headers": {},
                  "body": "{ \"message\": \"Hello, everyone\" }"
                }
            }
        }
    }

#### Example of Create Response

    HTTP/1.1 201 Created
    Location: http://example.com/greeting
    Content-Type: application/vnd.api+json

    {
        "data": {
            "id": "2",
            "type": "endpoints",
            "attributes": {
                "verb": "GET",
                "path": "/greet",
                "response": {
                    "code": "200",
                    "headers": {},
                    "body": "{ \"message\": \"Hello, everyone\" }"
                }
            }
        }
    }
  </markdown>
</details>

#### Step 3

<details>
  <summary>Call Created mock in specified Http method</summary>
  <markdown>

#### Create Request

    GET /greet HTTP/1.1
    Content-Type: application/vnd.api+json
    Accept: application/vnd.api+json

#### Example of Create Response

    HTTP/1.1 201 Created
    Location: http://example.com/greeting
    Content-Type: application/vnd.api+json

    {
    "message": "Hello, everyone"
    }

  </markdown>
</details>


## Potential Improvements

#### Decorator

if you have complicated presentation layer its possible to use decorator to clean up your models my suggest is [draper](https://github.com/drapergem/draper) library, its has nice integration with
rails

#### Error Handling Options

errors need to be parameterize to avoid some rails and database errors to shown in response

#### JSON Validator

also its possible to use json validator such [json-schema](https://github.com/voxpupuli/json-schema) for validate input structure, for this case its too much to use external lib for app

#### Test Options

there is some option to running and writing tests faster such as [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers) it wasn't
necessary to add additional library to this app.

#### Validation Per Method

you can validate mock api parameters per method, for ex: get can not have body params, this need to understand specification of these
http methods in detail, I saw in elastic search we can use get with body params.

#### Not Implemented Method

CONNECT: connect is intended only for use in requests to a proxy, so I'm not gonna implement it
OPTIONS: this is intended to communication options with server and respond server capabilities, its not or our case
TRACE : is not applicable to our mock server

## Middleware

is case of user concern its possible to add middleware to filter specific aspect of request.

## ActiveSupport JSON encode


## Logger


