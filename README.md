# Cepik
  Simple app created in Swift using UIKit to observe data about registered vehicles in Central Register Of Vehicles And Drivers (CEPIK) in Poland.

## Table of Contents
  * [Introduction](#introduction)
  * [Technologies](#technologies)
  * [API](#api)
  * [App presentation](#app-presentation)
  * [Features to add](#features-to-add)

## Introduction
  I build this app for training purposes. I wanted to combine skills that I gained while learning Swift. I also wanted to polish building a user interface programatically and try to make an app using MVVM.
  
  The application allows to search and view detailed information about vehicles in a given province in a given period and type of registration.

## Technologies
  Xcode - 14.2

  Swift - 5.7

## API
  I used API from Central Register Of Vehicles And Drivers (CEPIK) in Poland - https://api.cepik.gov.pl/doc.

## App presentation

### Search screen
  In this screen user sees and can choose parameters about the query.
  Application implements Dynamic Text on all screens.
  <p align="center">
    <img src="https://user-images.githubusercontent.com/58117854/221962496-b9955daa-3ab6-4969-8193-60cc2f26c1e2.jpg" height="500" />
  </p>
  
### Values to select for API call
  These are parameters for province presented with Alert Controller, date presented modally in UIView with Date Picker, and registration also presented with Alert Controller.
  Date is limited to a maximum of 2 years back. It is a limitation of CEPIK API. Date that is presented to user at first is fetched from API as latest database modification date.
  <p align="center">
    <img src="https://user-images.githubusercontent.com/58117854/221963452-ac90a263-8ddf-463c-98b3-56b09864295b.jpg" height="500" />
  </p>
  
### Returned vehicles screen
  This screen shows the reulsts from query in Table View with search option and sort option.
  <p align="center">
    <img src="https://user-images.githubusercontent.com/58117854/221963885-e9f7753e-7ca8-4a84-9081-93dc12fdfd46.jpg" height="500" />
  </p>
  
### Vehicle detail screen
  This screen shows details information about specific vehicle with Scroll View
  <p align="center">
    <img src="https://user-images.githubusercontent.com/58117854/221963951-60e18d10-e428-45e7-a74d-d34d03317453.png" height="500" />
  </p>
  
  #### Screenshots created using [screenshots.pro](*screenshots.pro)
  
 ## Features to add
 - [ ] API call for driving licenses
 - [ ] SwiftUI screen with BarChart for number of vehicles registered in given month/year
 - [ ] Unit tests
 
