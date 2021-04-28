
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#rest-endpoints">ReST Endpoints</a></li>

  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

This repository serves as a backend api for for a hypothetical site. The site can retrieve weather for a given place, photos from that place, allows people to register and recieve and API key to authenticate for requests, and plan road trips; giving you the eta and weather upon arrival.

### Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)

<!-- GETTING STARTED -->
## Getting Started

1. Clone this repo
2. Install gem packages: `bundle install`
4. Create and Migrate DB
```
$rails db:{create,migrate}
```
5. Install needed Figaro config
```
$bundle exec figaro install
```
6. Add environemnt variables to `config/application.yml`
> Sample config
```
open_weather_api_key: "open weather api key"
mapquest_api_key: "mapquest api key"
flickr_api_key: "flickr api key"

development:
  API_URL: 'http://localhost:3001'
test:
  API_URL: 'http://localhost:3001'
```
7. Start your server!

```
$ rails s
```
### Prerequisites

* Ruby 2.5.3
* Rails 5.2.5
* Deployed microservice and backend repo

<!-- USAGE EXAMPLES -->

<details open>
<summary>ReST Endpoints</summary>
<br>

    
### GET Forecast
* Create a profile
> Required Parameters: `:location`
```
POST   /api/v1/forecast?location=denver,co
```

<details open>
<summary>Sample Response</summary>
<br>
  
```
{
  'data': 'profile created successfully'
}

```

</details>

### GET Background photo
* Returns the background photo for a location
> Required Parameters: `:location` 
```
GET    /api/v1/backgrounds?location=denver,co
```

<details closed>
<summary>Sample Response</summary>
<br>
  
  ```
{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "image": {
        "location": "denver,co",
        "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
        "credit": {
          "source": "pixabay.com",
          "author": "quinntheislander",
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}

```

</details>

### POST Create User
* Creates a post for the given profile
> Required Parameters: `:user_id` `:content`
```
POST   /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
<details open>
<summary>Sample Response</summary>
<br>

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}

```

</details>

### Post Login
* Returns the recent posts of a given profile's circle
> Required Parameters: `:email, :password` 
```
GET    /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}

```

<details closed>
<summary>Sample Response</summary>
<br>
  
  ```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}

```

</details>


### POST Roadtrip
* Returns a given profile
> Required Parameters: `:api_key, :` 
```
GET    /api/v1/road_trip 
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

<details closed>
<summary>Sample Response</summary>
<br>

```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

</details>
