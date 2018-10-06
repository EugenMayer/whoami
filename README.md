# whoami

Tiny Go webserver that prints os information and HTTP request to output for tests of any like.
Usually to test load-balancer upstream setup or for example setup of such.

Includes a docker-image [eugenmayer/whoami](https://hub.docker.com/r/eugenmayer/whoami) 
 - running one single service (port 80) [eugenmayer/whoami:single](https://hub.docker.com/r/eugenmayer/whoami)
 - running multiple service (port 80,90,100) [eugenmayer/whoami:multiple](https://hub.docker.com/r/eugenmayer/whoami)

This way you can test single upstream server per docker image or multi-service upstreams, e.g. test segments with traefik and other load-balancers or whatever you build you example with.

## run
```
docker run -p 80:80 eugenmayer/whoami:single
# access
wget http://localhost:80
```

or the multi-service variant using 
```    
docker run -p 80:80 -p 90:90 -p 100:100 eugenmayer/whoami:multiple
# access
wget http://localhost:80
wget http://localhost:90
wget http://localhost:100
```

The response looks like this            
```sh
Hostname :  6e0030e67d6a
IP :  127.0.0.1
IP :  ::1
IP :  172.17.0.27
IP :  fe80::42:acff:fe11:1b
GET / HTTP/1.1
Host: 0.0.0.0:32769
User-Agent: curl/7.35.0
Accept: */*
```


## build

    make image 
    
## develop

Change `app.go` to your likings and then run 

    make build

And if those changes are valuable for all, why not create a pull request :)    
        
## Credits

Credits to https://github.com/containous/whoami for providing the initial version