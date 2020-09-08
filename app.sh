# 1. Build image
# docker build -t some-content-nginx .

# 2. Run container with local Dockerfile
# docker run --name some-nginx -d -p 8081:80 some-content-nginx

# 3. Run container with image from repo
# docker run --name local-nginx -d -p 8081:80 mkuegeler/nginxapp:latest

# 4. Open in browser
# http://localhost:8081

# 5. Stop container
docker stop some-nginx 

# 6. Remove container
docker rm some-nginx

# 7. Remove image
docker rmi some-content-nginx