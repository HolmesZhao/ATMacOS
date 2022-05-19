[_TOC_]

# Title

xxxxx

## H2 Title

xxxx

### H3 Title

xxxx

#### H4 Title

xxxxx

# Second Title

xxxxx

## Second H2 Title

xxxx

## Second H2 Title 2 

<details>
<summary>Releasing a new version</summary>

Follow the steps below to build and release a new version of Xcodes.app. For any of the git steps, you can use your preferred tool, but please sign the tag.

```sh
# Update the version number in Xcode and commit the change, if necessary
# Question: Did anything in XPCHelper change?
# - com.robotsandpencils.XcodesApp.Helper folder and HelperXPCShared
# - if so, bump the version number in com.robotsandpencils.XcodesApp.Helper target.
# Note: you do not have to bump the version number if nothing has changed.
# Note2: If you do bump the version, the end user, must re-install the XPCHelper and give permission again.
# Increment the build number
scripts/increment_build_number.sh
# Commit the change
git add Xcodes/Resources/Info.plist
git commit -asm "Increment build number"
# Tag the latest commit
# Replace $VERSION and $BUILD below with the latest real values
git tag -asm "v$VERSIONb$BUILD" "v$VERSIONb$BUILD"
# Push to origin
git push --follow-tags
# Build the app
# Make sure you have the Xcode Selected you want to build with
scripts/package_release.sh
# Notarize the app
# Do this from the Product directory so the app is zipped without being nested inside Product
# Create a app specific password on appleid.apple.com if you haven't already
# xcrun notarytool store-credentials "AC_PASSWORD" \
#              --apple-id "test@example.com" \
#              --team-id "teamid" \
#               --password "app specific password"
pushd Product
../scripts/notarize.sh Xcodes.zip <MYORG>
# Sign the .zip for Sparkle, note the signature in the output for later
# If you're warned about the signing key not being found, see the Xcodes 1Password vault for the key and installation instructions.
../scripts/sign_update Xcodes.zip
popd
# Go to https://github.com/RobotsAndPencils/XcodesApp/releases
# If there are uncategorized PRs, add the appropriate label and run the Release Drafter action manually
# Edit the latest draft release
# Set its tag to the tag you just pushed
# Set its title to a string with the format "$VERSION ($BUILD)"
# Polish the draft release notes, if necessary
# Add the signature to the bottom of the release notes in a comment, like:
<!-- sparkle:edSignature=$SIGNATURE -->
# Attach the zip that was created in the Product directory to the release
# Publish the release
# Update the [Homebrew Cask](https://github.com/RobotsAndPencils/homebrew-cask/blob/master/Casks/xcodes.rb).
```
</details>
