# TheMilkyWay

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Architecture](#architecture)
* [Design choices](#design-choices)

## General info

This is a sample iOS project created using NASA search image API.

## Technologies

* iOS14>
* Swift 5
* UIKit
* Combine

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
