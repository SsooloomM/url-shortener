# Prerequisites
* Docker
* Docker Compose

# Running the app

## Build and run
docker-compose up --build

## Run the app
docker-compose up

## Stop the app
docker-compose down

## Run unit test
docker-compose run app bash -c "RAILS_ENV=test;  bundle exec rspec"

# Available endpoints
## Decode
* method: GET
* path: /api/shortener/decode
* params: `short_url` -- string ex: http://localhost:3000/m
* response:
```
{
  "url": {
    "original_url": "http://codesubmit.io/library/react",
    "short_url": "http://localhost:3000/m"
  }
}
```
## Encode
* method: GET
* path: /api/shortener/encode
* params: `original_url` -- string. should start with (http/https) ex: http://codesubmit.io/library/react
* response:
```
{
  "url": {
    "original_url": "http://codesubmit.io/library/react",
    "short_url": "http://localhost:3000/m"
  }
}
```

# Attack vectors
### SQL injection 
* Risk: if user input is interpolated into SQL queries (string concatenation), an attacker can inject SQL and manipulate or exfiltrate data.
* I should use parameter binding / ActiveRecord helpers
### DDos Attacks
* Risk: High-volume or malformed request floods can exhaust CPU, DB connections, or network bandwidth and make the service unavailable.
* Solution: Enforce rate-limiting/throttling at the edge (CDN / API gateway / Nginx), use a WAF/CDN (e.g., Cloudflare), enable caching and autoscaling, and block/blacklist abusive IPs while monitoring traffic.

# Scaling
### Horizontal Scaling
* Add a load balancer and increase the number of running instances as needed.
* This approach works well for this app because each process is small and independent, allowing instances to be scaled up or down easily.
