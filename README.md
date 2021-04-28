
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
CLIENT_ID: 'your google oauth client id'
CLIENT_SECRET: 'your google oauth client secret'
development:
  API_URL: 'http://localhost:3001'
production:
  API_URL: "your microservice heroku link"
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
> Required Parameters: `:user_id` `:zipcode`
```
POST   /api/v1/profiles
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
* Returns the circle of a given profile
> Required Parameters: `:user_id` 
```
GET    /api/v1/profiles/:id/circle
```

<details closed>
<summary>Sample Response</summary>
<br>
  
  ```
{
    "data": [
        {
            "id": "2",
            "type": "profile",
            "attributes": {
                "zipcode": "80305",
                "user_id": 2,
                "profile_picture": "http://www.google.com",
                "username": "korn"
            }
        },
        {
            "id": "3",
            "type": "profile",
            "attributes": {
                "zipcode": "80304",
                "user_id": 3,
                "profile_picture": "http://www.google.com",
                "username": "slipknot"
            }
        },
        {
            "id": "4",
            "type": "profile",
            "attributes": {
                "zipcode": "80303",
                "user_id": 4,
                "profile_picture": "http://www.google.com",
                "username": "photos by jim"
            }
        },
        {
            "id": "5",
            "type": "profile",
            "attributes": {
                "zipcode": "80544",
                "user_id": 5,
                "profile_picture": "http://www.google.com",
                "username": "arteest"
            }
        }
    ]
}

```

</details>

### POST Create User
* Creates a post for the given profile
> Required Parameters: `:user_id` `:content`
> Optional Parameters: `:link`
```
POST   /api/v1/profiles/:id/post
```
<details open>
<summary>Sample Response</summary>
<br>

```
{
  'data': 'post created successfully'
}

```

</details>

### Post Login
* Returns the recent posts of a given profile's circle
> Required Parameters: `:user_id` 
```
GET    /api/v1/profiles/:id/circle/posts

```

<details closed>
<summary>Sample Response</summary>
<br>
  
  ```
{
    "data": [
        {
            "id": "4",
            "type": "post",
            "attributes": {
                "content": "hey did you see that headline?",
                "link": "photoURL.com",
                "user_id": 2,
                "created_at": "2021-04-21T20:35:56.040Z"
            }
        },
        {
            "id": "5",
            "type": "post",
            "attributes": {
                "content": "hey checkout my create shoes?",
                "link": "photoURL.com",
                "user_id": 2,
                "created_at": "2021-04-21T20:35:56.043Z"
            }
        },
        {
            "id": "6",
            "type": "post",
            "attributes": {
                "content": "hey did you see software update?",
                "link": "photoURL.com",
                "user_id": 3,
                "created_at": "2021-04-21T20:35:56.047Z"
            }
        },
        {
            "id": "7",
            "type": "post",
            "attributes": {
                "content": "hey did you see I called you?",
                "link": null,
                "user_id": 3,
                "created_at": "2021-04-21T20:35:56.050Z"
            }
        },
        {
            "id": "8",
            "type": "post",
            "attributes": {
                "content": "hey did you see that we're not friends on FB anymore?",
                "link": "photoURL.com",
                "user_id": 4,
                "created_at": "2021-04-21T20:35:56.053Z"
            }
        },
        {
            "id": "9",
            "type": "post",
            "attributes": {
                "content": "hey did you see hear about that create app called 'level'?",
                "link": "photoURL.com",
                "user_id": 4,
                "created_at": "2021-04-21T20:35:56.057Z"
            }
        },
        {
            "id": "10",
            "type": "post",
            "attributes": {
                "content": "hey i just got hired at a sick new comapny",
                "link": null,
                "user_id": 5,
                "created_at": "2021-04-21T20:35:56.060Z"
            }
        }
    ]
}

```

</details>


### POST Roadtrip
* Returns a given profile
> Required Parameters: `:user_id` 
```
GET    /api/v1/profiles/:id 

```

<details closed>
<summary>Sample Response</summary>
<br>

```
{
    "data": {
        "id": "1",
        "type": "profile",
        "attributes": {
            "zipcode": "80301",
            "user_id": 1,
            "profile_picture": "http://www.google.com",
            "username": "the painter man"
        }
    }
}
```

</details>
