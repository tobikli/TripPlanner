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

**TripWise**

Budgeting a planned or unplanned trip can be a hard time as many costs are not on your mind when planning. Therefore I would like an App that manages trips and vacations. It should focus on budgeting and time management, where the most important points like flight, accommodation, transport, food and activities are all corelated in the budget and schedule feature. 

It should be able to give an overview of the upcoming trip, including the budget required, the schedule planned and additional useful information and statistics. 

It should be able to create a trip plan accordingly and show a the set budget of it in each of the different categories.

Furthermore it should fetch data like flight information and weather for the trip and give important notifications on upcoming events and unplanned changes, like delayed flights.

At last, it should summarize the trip afterwards with a comparison between planned spendings and actual spendings.

## Requirements

The app should:
- show an overview of upcoming trips with budget and schedule
- handle manual user input for all possible events including: flights, accommodation, transportation, visa, food and allocate budget
- display schedule of flights, check-in and check-out of hotels using API
- display and fetch of local weather and flight Information using API
- calculate and assign the budget to each category
- summarize the trip, including the used budget and activites, afterwards


## Analysis

TODO: Include an analysis object model. You can use [draw.io](https://draw.io) or [apollon](https://apollon.ase.cit.tum.de) to create it. Please add all models as an Image - not as a link!

## System Design

TODO: Include a system design overview describing your application.

## Product Backlog

TODO: Add a product backlog and don't forget to update it with each MR.
