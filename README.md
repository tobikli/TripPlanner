# Intro Course Project App of Tobias Klingenberg for the iPraktikum

To pass the intro course, you need to create your own unique iOS app (based on SwiftUI).

There are no requirements regarding the functions of your app, so you can get creative.
However, we provide you with Non-Functional Requirements (NFR) that your app needs to fulfill.

After each day of learning new Swift and SwiftUI concepts, these NFRs may change, or new NFRs get added.

## Submission procedure

You get a **personal repository** on Gitlab to work on your app.

Once you implemented a new feature into your app, you need to create a Merge Request (MR - Sometimes we will also reference these as "Pull Requests"(PR)) to merge your changes from the feature branch into your main branch.

Your tutor will review your changes and either request changes or approves the MR.

If your MR got approved, you also need to merge it!

### Deadline: **15.10.2024 23:59**

Until the deadline all of your PRs **need to be merged** and your final app **needs to fulfill** all of the requested NFRs!

---

## Problem Statement (max. 500 words)

**TripPlanner**

Budgeting a planned or unplanned trip can be a hard time as many costs are not on your mind when planning. Therefore I would like an App that manages trips and vacations. It should focus on budgeting and time management, where the most important points like flight, accommodation, transport, food and activities are all corelated in the budget and schedule feature. 

It should be able to give an overview of the upcoming trip, including the budget required, the schedule planned and additional useful information and statistics. 

It should be able to create a trip plan accordingly and show the manually added budget of the user in each of the different categories.

Furthermore it should fetch data like the weather for the trip and give important notifications on upcoming events and unplanned changes, like delayed flights.

At last, it should summarize the trip afterwards with a comparison between planned spendings and actual spendings.

## Requirements

The app should:
- show an overview of upcoming trips with budget and schedule
- handle manual user input with budget for all possible events including: flights, accommodation, transportation, visa and food
- display schedule of flights, check-in and check-out of hotels using API
- display and fetch of local weather using API
- summarize the trip, including the used budget and activites, afterwards


## Analysis

![UML](/images/AOL.png)

## System Design

![UML](/images/SystemDesign.png)


## Product Backlog

| Version | Task                                | Done |
| - | ----------------------------------------- | ---- |
| 1 | Create UI for Trip creation               |   ✓  |
| 2 | Add Location and Time to Trip             |   ✓  |
| 2 | Add Budget UI                             |   ✓  |
| 2 | Add Event creation UI                     |   ✓  |
| 2 | See Schedule of Trip                      |   ✓  |
| 2 | Fetch WeatherAPI                          |   ✓  |
| 3 | Event Detail View                         |   ✓  |
