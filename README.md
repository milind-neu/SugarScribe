## Personal Information
Milind Sharma | sharma.mil@northeastern.edu   

## Screenshots:
1. Launch Screen: ![alt text](https://github.com/milind-neu/SugarScribe/blob/main/Screenshots/1.%20Launch%20screen.png)
2. Recipe listing Screen: ![alt text](https://github.com/milind-neu/SugarScribe/blob/main/Screenshots/2.%20List%20Screen.png)
1. Recipe detail Screen: ![alt text](https://github.com/milind-neu/SugarScribe/blob/main/Screenshots/3.%20Detail%20Screen.png)
1. Recipe content play Screen: ![alt text](https://github.com/milind-neu/SugarScribe/blob/main/Screenshots/4.%20Content%20play%20screen.png)


## Tech Stack
- The programming language chosen for this project is `Swift`, specifically utilizing the `UIKit` framework. The chosen architectural pattern is `Model-View-ViewModel (MVVM)`. The project is being developed using `Xcode version 14.3`. The minimum deployment target for the project is `iOS 14.0+`. The app is made responsive for portrait as well as landscape orientation of iPhones. 

## Handled all cases for API response!

## Build and Run Instructions
1. Clone the forked repository `git@github.com:milind-neu/Chef-Choice.git` 
2. Open terminal and move to the project directory 
3. Run `pod install` to install the required pods
4. Open `Chef-Choice.xcworkspace` file using latest version of `XCode`
5. Build and Run the app for simulator or iPhone device with iOS version `14.0+`

## Unit Tests added
1. `testJSONDecoding()` To parse the json into the Meal model
2. `testFetchDessertMeals()` To test API call of fetching Dessert meals
3. `testFetchMealDetails()` To test API call of fetching meal detail
4. `testGetYoutubeId()`, `testGetYoutubeId_InvalidUrl()` and `testGetYoutubeId_EmptyUrl()` To test different scenarios for `getYoutubeId()` function which fetches YoutubeId from URL

## CI
1. Github Actions workflow will be triggered when a PR is raised from the fork repo to the organization repo
2. GitHub Repository has branch protection configured to prevent PRs from merging when a workflow fails

## Pods used:
1. `Alamofire` To make network requests and handle network responses
2. `RxSwift` To response to events such as API calls and notify the respective View Controller for View Model
3. `Kingfisher` To download and cache images
4. `SwiftLint` To enforce coding style and best practices
5. `ProgressHUD` To show indicator during API calls
