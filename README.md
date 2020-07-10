# AwDyu-iOS
A simple app that fetches, Show list of Itunes tracks, and show details page


## Design Patterns

### Model-View-ViewModel
- Flexible 
- Model captures data / repsonses from API
- We put heavy lifing to business logics on ViewModel while View behaves base on the provided data from view model.


Since this only a split view master-detail, or there are only 2 pages. We don't need Flow Coordinators, yet, and Main Storyboard is enough. 

As when this will expand to more features and pages and/or Content-Driven hierarchy, Flow Coordinator should be considered, which it manages Navigation stacks, showing of views, decides what pages to show.


## Paradigm

Composition over Inheritance.
Priotizing Protocol-Oriented programming over Object-Orient Programming.
POP gives more flexibility, readabilty, and less prone to unintended mutabilty.

So when implementing OOP here, we should limit subclassing to 1 level.


## Persistence

- Using User Defualts for saving Last visited of app will suffice.

- Using State Preservation and Restoration, can show restore the last detail page, if the app goes to backround state from the details page, and when system might terminate the app to free up the resources it holds, it can restore the page with details in it.


## Dependencies

1. Alamofire

For the networking layer, this simplifies a lot of networking requests and stuff.

2. SnapKit

Simple, and fast way to layout, and do constraints on views.
