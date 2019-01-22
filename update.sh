git tag -d 0.1.5
git push origin :0.1.5
git add .
git commit -m "Update project"
git push
git tag 0.1.5
git push --tags
pod spec lint --verbose"
