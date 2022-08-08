# ExerLog

<p align="center">
  <img width="300" src="https://github.com/KalleHallden/exer_log/blob/master/assets/img/logo-dark.png?raw=true#gh-light-mode-only">
  <img width="300" src="https://github.com/KalleHallden/exer_log/blob/master/assets/img/logo-light.png?raw=true#gh-dark-mode-only">
</p>

## Introduction

![](https://badgen.net/github/stars/kallehallden/exer_log)
![](https://badgen.net/github/forks/kallehallden/exer_log)
![](https://badgen.net/github/open-issues/kallehallden/exer_log)
![](https://badgen.net/github/open-prs/kallehallden/exer_log)

**ExerLog** is simple and easy-to-use exercise-journal app. Developed in
conjunction with Sports Science, ExerLog focuses on providing all the
essential workout data without all the unnecessary and irrelevant
information. The goal of this app is to give you the freedom of a
historical exercise journal paired with the analytical abilities of
[spreadsheets](https://en.wikipedia.org/wiki/Spreadsheet).

This project is currently *in development*; there are still several
features that are [yet to be implemented](#room-for-improvement).

There is a series dedicated to the full build-out of this project
on my YouTube channel:

- [[YouTube] Coding My Startup - @KalleHallden](https://www.youtube.com/playlist?list=PL5tVJtjoxKzpxnc9ventef-1sgvoR8nqG)


## Technologies Used

- [Flutter](https://en.wikipedia.org/wiki/Flutter_(software))
- [Firebase](https://en.wikipedia.org/wiki/Firebase)


## How to Run

- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).

- Clone this repository onto your local machine.

```powershell
git clone "https://github.com/KalleHallden/exer_log.git"
```

- Navigate into the proper directory.

```powershell
cd "./exer_log/app/exerlog"
```

- Download the project's dependencies.

```powershell
flutter pub get
```

- Run the project.

```powershell
flutter run
```


## Room for Improvement

### Current features

Workout Metrics:

- [x] Custom exercise names
- [x] Reps
- [x] Sets
- [x] Weight
- [x] Rest
- [x] Total weight, reps and sets per exercise for the entire workout.

### Unimplemented features

Workout Analytics:

- [ ] Chart displaying strength increase over time.
- [ ] Chart displaying volume* over time (for easy periodization).
- [ ] Tracking progressive overload.

> *Volume refers to the total amount of physical work performed in
> either a single workout session or over the course of an extended
> exercise program.

Workout Planner:

- [ ] Ability to set up a workout plan for future workouts.

Body Metrics:

> The rationale behind this is that this can become a way for users to
> create workouts and share them with one another. For example, a JSON
> workout template can be imported into the app so that you can perform
> that workout. This might be a really good way for trainers to create
> long term workout plans for their athletes.

- [ ] Body Weight
- [ ] Waist size
- [ ] Arm size
- [ ] Calf size
- [ ] Chest size
- [ ] Wrist size
- [ ] Thigh size


## Contributing

Want to contribute? Great!
Click [here](./contributing.md) to get started.

Please adhere to the project's [Code of Conduct](./code_of_conduct.md).

Bug/Feature Request
--------------------

If you find a bug (program failed to run and/or gave undesired results)
or you just want to request a feature, kindly open a
[new issue](https://github.com/KalleHallden/exer_log/issues).


## Authors

- [@KalleHallden](https://github.com/KalleHallden)
