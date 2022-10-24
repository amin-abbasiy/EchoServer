# EchoServer

## Installation

navigate to root directory and ruby below command:

    $ bin/setup_server
## V1
### Endpoints Controllers 
under ```app/controllers/api/v1``` our controller file exists and we use this controller to create our mocks
and save them in our postgres database

### Tests
routing Tests are exists in under the ```spec/routing``` folder

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

### ENV
environment variables defined in .env file and we use them for development purposes, it add env vars to ENV in rails