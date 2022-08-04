# AIM: Build the app and push the dist contents to 'deploy' branch
rm -rf dist

# Abort on errors
set -e

yarn build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:SHD-420/linkpreview-frontend.git master:deploy


# Now cd back and delete the dist folder
cd ..
rm -rf dist
