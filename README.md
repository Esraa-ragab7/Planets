# Planets
Planets is an application designed to analyze any recipe and get a detailed nutrition data about it.

## Architecture pattern
* MVP(Model View Presenter) + Clean Architecture concepts

## Run Requirements
* Minimum xcode version: Xcode 11
* Swift 5

## Installation 
* Clone this repo: <br/>
           `git clone https://github.com/Esraa-ragab7/Planets.git`
* Open the terminal and navigate to the directory of project:  <br/>
           `cd Planets`
* Run this command to open the project directory: <br/>
          `open .`
* Open the workspace Planets.xcodeproj.
* Now you can run the project.



![alt text](https://user-images.githubusercontent.com/13772702/143316833-c2844a47-c6e1-4473-994f-c88480146485.png)




## App Layers

#### MVP Concepts
##### Presentation Logic
* `View` - handle user interaction events to the `Presenter` and displays data passed by the `Presenter`
* `Presenter` - contains the presentation logic and tells the `View` what to present
* `Configurator` - injects the dependency object graph into the scene (view controller)
* `Router` - contains navigation / flow logic from one scene (view controller) to another

#### Clean Architecture Concepts
##### Application Logic

* `UseCase / Interactor` - contains the application / business logic for a specific use case in your application
* `Entity` - plain `Swift` classes / structs

##### Gateways & Framework Logic

* `Gateway` - contains actual implementation of the protocols defined in the `Application Logic` layer
* `Persistence / API Entities` - contains framework specific representations
* `Framework specific APIs` - contains implementations of `iOS` specific APIs such as sensors / bluetooth / camera


