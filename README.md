# EchoServer

Welcome to the EchoServer

## What is EchoServer?

EchoServer is a web service which provides creating and managing mock apis with desired details.

## Installation
first run: 

    $ sudo chmod +x bin/setup.sh

then:

    $ bin/setup.sh app

`setup.sh` will automatically set env var for database credentials, if you face error in console or running `$ rspec`:

Note. please set your postgres database config in the .env file in root directory if you have any database connection problem. (also its possible to set variables in your shell env)

     DATABASE_HOST=<your db host>
     DATABASE_PORT=<your db port>
     DATABASE_USERNAME=<your db username>
     DATABASE_PASSWORD=<your db password>

Note. if your config is ok and you face peer connection error, check your postgres [configuration](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html)

## Requirements

I consider you already installed `ruby`, `rails`, `postgres` in your system

Please use this data to login, app does not support registration process

```js
    { 
        "password" : 'adminadmin',
        "email" : "admin@mail.com"
    }
```

## ENV

system handles environments variables with [.dotenv](https://github.com/bkeepers/dotenv) library and we set env variables in .env file in root directory, so all variables is accesable through ENV.

Note. this is for development purposes

## API Collection in Postman

Api list is available in the Postman, to use please click [EchoServer](https://www.postman.com/uamin-abbasi/workspace/my-workspace/request/22877222-437b9b0c-c964-44a7-afee-d80a14cd8343?ctx=documentation)
please set url variable in postman to your remote url

in case of using online collection:
1. Please select DEV environment
2. token variable automatically will set after login

{{url}} : you need to set url to your local url or ngrok remote url if you use online collection

{{token}} : user token to work with token endpoints

### Request via Postman online collection to local 

*if you want to run postman locally and test apis in local skip this section*

#### Connect To Remote Collection

**Step 1**

In ubuntu: 
        
    $ sudo snap install ngrok

In mac:

    $ brew install ngrok/ngrok/ngrok

if you need more data about ngrok visit [ngrok docs](https://ngrok.com/docs/getting-started)

**step 2**

you need to add your ngrok key to ngrok.yml file, use mine

    ngrok config add-authtoken 1n0mFSVOTlDkEVPfZLOK75BY9TR_3APBxDQcaNwi1RYHkHd5k

**step 3**

port: for rails default its 3000

    ngrok http <port>

**step 4**

Note. Use -b <host> -p <port> in running rails server

then add your ngrok host to your application.rb

    config.hosts << "<your random ngrok host>.ngrok.io"

## Api Rule

Note. at the moment no extra attributes accepted from input, all data is restricted to specified data, you can add data only to headers and
body keys

## Test
using this command you can run application tests

    $ rspec

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

### Step 1

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

### Step 2

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

### Step 3

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

The Boy Scout Rule:
> “Always leave the campground cleaner than you found it.”

### Decorator

if you have complicated presentation layer its possible to use decorator to clean up your models my suggest is [draper](https://github.com/drapergem/draper) library, its has nice integration with
rails

### Error Handling Options

errors need to be parameterize to avoid some rails and database errors to shown in response

### JSON Validator

also its possible to use json validator such [json-schema](https://github.com/voxpupuli/json-schema) for validate input structure, for this case its too much to use external lib for app

### Test Options

there is some option to running and writing tests faster such as [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers) it wasn't
necessary to add additional library to this app.

### Validation Per Method

you can validate mock api parameters per method, for ex: get can not have body params, this need to understand specification of these
http methods in detail, I saw in elastic search we can use get with body params.

### Not Implemented Method

CONNECT: connect is intended only for use in requests to a proxy, so I'm not gonna implement it
OPTIONS: this is intended to communication options with server and respond server capabilities, its not or our case
TRACE : is not applicable to our mock server

### Middleware
there is some idea for log all incoming request using custom middleware check out [request logger](https://gist.github.com/jugyo/300e93d6624375fe4ed8674451df4fe0) if you are interested

also is case of user concern its possible to add middleware to filter specific aspect of request.

### Logger
its good idea to log database some important transaction, its good for trace some user trails
