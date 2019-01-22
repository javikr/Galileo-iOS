git tag -d 0.1.5
git push origin:0.1.5
git add .
git commit -m "Update"
git push
pod trunk push Galileo-iOS.podspec --verbose
