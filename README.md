# Cocktail iOS app
## Cocktail App


- Create an iOs app that will search for a Cocktail based on the input given by the user. Search results would be a grid as shown in the attached screenshot. You need to use this API (thecocktaildb.com/api/json/v1/1/search.php?s=mojito). A few search keys are "Vodka, "Rum", and "Margarita". You need to consider the below points.

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

## Installation
- Pod install.
- using SDWebImage framework for caching & displaying image in cells.
- open Cocktail.xcworkproj. 
- Select the iphone simulator of your choice & run it. 
- Tested on iOS 14.3, iOS 14.5 ( iphone SE, iphone 12 pro).

## Design Pattern: Model-View-ViewModel-Coordinator (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
  - hold application data. They’re usually structs or simple classes.
- #### Views 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.


## Requirements

- **1. Use the data from the json file:**
- thecocktaildb.com/api/json/v1/1/search.php?s=. 
- NetworkManager contains basic network layer.

- **2. Use UICollectionview to present the
feed.**
- used the collectionviewcompositionalLayout with three different layout top(single horizontal), middle( 2 cell horizontal) and bottom (vertical).
-  For UI part I've decided to mainly do the UI layout in code, I decided this as it's much easier to control and reuse the UI layout. 

3. Search bar at the top for searching for the specific drinks.
thecocktaildb.com/api/json/v1/1/search.php?s=mojito

4. Detail view for a specific drink details.

5. Implemented a simple generic alert for Network Reachability for no connectivity.


- **2. Limitation**

- Code not fully tested. I tried adding some unit test for fetch API and some UI tests, but didn't have time  complete all the tests.

- UI Design could be improved on the detail  screen. I didn't want to spend too much time coming up with the UI so I decided to go with a very basic UI.

    
  ## Improvements / Need to be done
- Due to limited time constraints, wrote only few unit Tests and UI tests by using XCTest. Need to cover all unit test.
- Generic networking layer for all apis.
- Detail VIew UI  improvements.
- Navigation bar improvement.
- Infinite scroll on bottomview for better experience.


## Technology/Tools

- iOS 14.3
- Xcode 12
- Swift 5
- UIKit
- Combine
- Codable, Decodable
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- Programmatically written UI
- StoryBoard
- AutoLayout
- MVVM
- Nightmode
- XCTestCase for unit tests and UI Tests.
- Xcode Instruments for memory leaks and allocations.

## 📱 Screenshots

<p float="left"> 
<img src="/Documentation/sim1.png" width="100">
<img src="/Documentation/sim2.png" width="100">
<img src="/Documentation/sim3.png" width="100">
<img src="/Documentation/sim4.png" width="100">
</p>


<p float="left"> 
<img src="/Documentation/sim1.png" width="100">
<img src="/Documentation/sim2.png" width="100">
<img src="/Documentation/sim3.png" width="100">
<img src="/Documentation/sim4.png" width="100">
<img src="/Documentation/sim5.png" width="100">
</p>

<img src="/Documentation/sim5.png" width="500">

