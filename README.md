# Find shop test
## Setup
replace Google map API key in 
- android/app/src/main/AndroidManifest.xml
- ios/Runner/AppDelegate.swift
- lib/core/network/http_client/map_http_client.dart

or replace all text "ENTER_API_KEY" to your API KEY 
and make sure enabled service "Places API (New)" in Google Map Platform for search API feature

## Run App
```sh
flutter pub get
flutter run
```
or can use vs-code to run and debug (F5 to run)

## Test Unit Test
```sh
flutter test
```

## Preview
![alt text](https://github.com/mokmoei/shop_find_test/blob/main/preview/image.png?raw=true)
![alt text](https://github.com/mokmoei/shop_find_test/blob/main/preview/image2.png?raw=true)
![alt text](https://github.com/mokmoei/shop_find_test/blob/main/preview/image3.png?raw=true)
![alt text](https://github.com/mokmoei/shop_find_test/blob/main/preview/image4.png?raw=true)