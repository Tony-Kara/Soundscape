# Production Builds

The soundscape app uses [fastlane](https://docs.fastlane.tools/) for creating builds and distributing them to TestFlight.

## Setup

1. Go to https://appleid.apple.com/account/manage login, with your Apple ID and go to App-Specific Passwords. Generate a new App Specific Password, then copy it.
2. Inside your .env file, paste the new App Specific Password:

```
FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=<App-Specific Password>
```

## Running lanes

Every time you run fastlane, use `bundle exec fastlane [lane]`.

## Updating fastlane

To update fastlane, just run `bundle update fastlane` from the `ios` directory.

## Creating builds

To create a new build and push to TestFlight, run: `bundle exec fastlane beta`
