# AwDyu-iOS
A simple SplitView-Master-Detail app that fetches, Show list of iTunes tracks, and show details page

- Supports Dark Mode
- Supports Portrait and Landspace Orientation
- Supports iPhones and iPad Screens
- Supports Accessibility - Font size adjustments


## Design Patterns

### Model-View-ViewModel
- Flexible 
- Model captures data / repsonses from API
- We put heavy lifing of business logics on ViewModel while View behaves base on the provided data from view model.


Since this only a split view master-detail, specifically only 2 pages. We don't need Flow Coordinators, yet, and Main Storyboard is enough. 

As should this expand with more features and pages and/or Content-Driven hierarchy, Flow Coordinator should be considered, which manages Navigation stacks, showing of views, decides what pages to show.


## Paradigm

Composition over Inheritance.  
Priotizing Protocol-Oriented programming over Object-Orient Programming.   
POP gives more flexibility, readabilty,less prone to unintended mutabilty, and uninteded inheritances.

So when implementing OOP here, we should limit subclassing to 1 level.


## Persistence

- Using User Defualts for saving Last visited of app will suffice.

- Using State Preservation and Restoration, can show restore the last detail page, if the app goes to backround state from the details page, and when system might terminate the app to free up the resources it holds, it can restore the page with details in it.

if this should 

[Restoring App State](https://developer.apple.com/documentation/uikit/uiviewcontroller/restoring_your_app_s_state)

While this is a relatively simple small app, with a small amount of data from Web service, and a function for purchases in Details page, this requires Internet Connection. 
So at this point storing data like the results may not be needed, yet, but should be always be consired. 

**Consider to use** 
- [CoreData](https://developer.apple.com/documentation/coredata)
- [RealmSwift](https://github.com/realm/realm-cocoa)
- [CoreStore](https://github.com/JohnEstropia/CoreStore).


## Dependencies

1. [Alamofire](https://github.com/Alamofire/Alamofire)

For the networking layer, this simplifies a lot of networking requests and stuff.

2. [SnapKit](https://github.com/SnapKit/SnapKit)

Simple, and fast way to layout, and do constraints on views.
