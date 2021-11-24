# TheMilkyWay

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Architecture](#architecture)
* [Design choices](#design-choices)
* [Unit tests](#unit-tests)
* [Dependency injection](#dependency-injection)

## General info

This is a sample iOS project created using NASA search image API.


## Technologies

* iOS14>
* Swift 5
* UIKit
* RXSwift


## Architecture

* MVVM-C
* Modular Architecture


## Design choices

I choosed **MVVM** for this sample project for testability and scalability. Preferred the **Coordinator Pattern** to be able to easily handle navigation.
**Modular Architecture** choice is made to be able to define development areas and responsibilities clearer.

* **MVVM**: 
  * Reduced complexity: MVVM makes the view controller simpler by moving a lot of business logic out of it.
  * Expressive: The view model better expresses the business logic for the view.
  * Testability: A view model is much easier to test than a view controller. You end up testing business logic without having to worry about view implementations.
  
* **Coordinator**: 
  * Using the coordinator pattern in iOS apps lets us remove the job of app navigation from our view controllers, helping make them more manageable and more reusable, while also letting us adjust our app's flow whenever we need.

* **Modular**:
  * Less build-time when compiling after a change is made.
  * Clearer development areas/responsibilities.
  * Isolation of changes.


## Unit tests

  Unit tests can be found under the "\(Module)Tests" directory in each module.

## Dependency injection

 1. **NetworkManager** conforms to **Requestable** protocol which can be easily replaced with another source,
 2. **RestNasaServices** conforms to **NasaServices** protocol which can be replaced by **Mock** or **Rest** service or local source anytime and it has constractor injection of **Requestable** to be able to change the source easily
 3. **ViewModels** require constractor injection of **NASAService** protocol which can be **Mock** or **Rest** or any other source at any time which allows them to be tested easily.
 4. **ViewControllers** require constractor injection of their **ViewModels** which needs to be set in coordinators,
 5. **Coordinator** requires constractor injection of **NASAServices** which needs to be set in **AppCoordinator**,
 6. **AppCoordinator** also requires constractor injection of **NASAServices**, so we can run our app entirely on **Mock** or **Rest** services.
