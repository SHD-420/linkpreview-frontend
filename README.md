# "LinkPreview" frontend

This is frontend repository for the "LinkPreview" tool I created that takes a URL as input from user and displays a "preview" for that link by doing some runtime web-scraping.

[It's deployed here.](http://194.195.117.9/)


## Stack used
- Vue with typescript (+ tailwindcss) for frontend (this repo)
- Go executable as backend ([its repo](https://github.com/SHD-420/linkpreview-backend))

## Deployment strategy
This repo contains a shell script "deploy.sh" which builds the Vue application and pushes the output files into a branch by name "deploy". I pull from that branch on the server machine and serve the bundle from there.

