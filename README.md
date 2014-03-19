# Joshua Toyota's Care Cloud Assignment

## Responses

With the exception of the List action, the API response with JSON in the following format:

    {
      "status": "(success|error)",
      "message": "<success_message|error_messages>"
    }

Successful messages have a Response Code of 200.

Error messages have a response code of 400 (Bad Request).

## API Endpoints

* __OPERATION__: Show/List  
  __METHOD__: GET  
  __ENDPOINT__: /appointments  
  __ENDPOINT__: /appointments/list  
  __PARAMS__:  
    (_optional_) start\_time (format: YYYY-mm-dd HH:MM[:SS])  
    (_optional_) end\_time (format: YYYY-mm-dd HH:MM[:SS])  

* __OPERATION__: Create  
  __METHOD__: POST  
  __ENDPOINT__: /appointments  
  __PARAMS__:  
    start\_time __datetime__ (format: YYYY-mm-dd HH:MM[:SS])  
    end\_time __datetime__ (format: YYYY-mm-dd HH:MM[:SS])  
    first\_name __string__  
    last\_name __string__  

* __OPERATION__: Update  
  __METHOD__: PUT  
  __ENDPOINT__: /appointments/:id  
  __PARAMS__:  
    start\_time __datetime__ (format: YYYY-mm-dd HH:MM[:SS])  
    end\_time __datetime__ (format: YYYY-mm-dd HH:MM[:SS])    
    first\_name __string__  
    last\_name __string__  

* __OPERATION__: Destroy/Delete  
  __METHOD__: DELETE  
  __ENDPOINT__: /appointments/:id  


## Worth Mentioning

In the sample dataset, some of the start and end times overlap.  As a result,
when loading the seed data incrementally, any subsequent appointments with
overlapping times were not created as per the conditions.

## Web Framework: Rails

I chose Rails for this assignment only because of time constraints.  Under
normal circumstances, I would have chosen Sinatra for implementing a (JSON)
REST API.  For such a small project, the robustness of Rails isn't necessary.
Due to the robustness, Rails also adds unnecessary overhead increasing
loadtimes.


## Testing Framework: Minitest

I have used RSpec for many years now.  However, because Minitest is the new
standard for Rails 4 and the DSL is almost identical to RSpec's, it wasn't a
problem making the transition.

Also, the test written were integration/functional tests.  Because the
underlying business logic was sparce and implementing the rules were best done
by utilizing Rails' features, I avoided extracting the rules into separate libs
and concerns.  For a larger app, I generally follow an 80/20 unit/integration
test percentage.

