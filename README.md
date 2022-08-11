<p align="center">
<img width="300" src="https://github.com/KalleHallden/exer_log/blob/master/assets/img/logo-dark.png?raw=true#gh-light-mode-only">
<img width="300" src="https://github.com/KalleHallden/exer_log/blob/master/assets/img/logo-light.png?raw=true#gh-dark-mode-only">
</p>

<div align="center">

![Issues](https://img.shields.io/github/issues/KalleHallden/exer_log) &nbsp; &nbsp;
![Forks](https://img.shields.io/github/forks/KalleHallden/exer_log?color=orange) &nbsp; &nbsp;
![Stars](https://img.shields.io/github/stars/KalleHallden/exer_log)

</div>

<!-- # ExerLog  -->

---

ExerLog is a simple and easy-to-use exercise journal app developed in conjunction with sports science that focuses on providing you with all the essential data without all the irrelevant information that you don't need. An app that keeps track of your exercises, body measurements, and offers you access to relevant workout information. The goal is to give you the freedom of a analog exercise journal with the analytical abilities of excel.

Create workouts and keep track of your reps, sets, weight, total weight, total reps, total sets, maxes and more. Track important physical measurements including bodyweight, waist size, arm size, and more. Then, visualize all of these measurements in bar charts and graphs that show your advancement over time.

Right now the project is in its infancy so there are a lot of features left to be added. If you want to follow the full buildout of this project then I (Kalle Hallden) have a YouTube channel where I [document the progress](https://youtube.com/playlist?list=PL5tVJtjoxKzpxnc9ventef-1sgvoR8nqG) every week.

## Technologies used

This project uses Flutter. The reason I (Kalle) chose Flutter is that I am very comfortable with using the framework and that you only have to write once and can run anywhere. Additionally, for authentication and database storage this project uses Firebase Auth and Firestore.

## Current Features

Workout metrics:

- Name of exercise
- Reps
- Sets
- Weight
- Rest
- Total weight/reps/sets per exercise and for the full workout

## Future features

Workout analytics:

- Charts for strength increases over time
- Charts for volume (ie total weight and average weight per workout) over time (for easy periodisation)
- Progressive overload tracking

Workout Planner:

- The ability to set up a workout plan for future workouts

The thinking here is that this can become a way for people to create workouts and share them with each other. Let's say that a json workout template can be imported in the app so that you can perform that workout. This might be a really good way for trainers to create long term workout plans for their athletes.

Body metrics:

- Body Weight
- Waist size
- Arm size
- Calf size
- Chest size
- Wrist size
- Thigh size

## Contributing

Contributions are always welcome!

See [CONTRIBUTING.md](https://github.com/KalleHallden/exer_log/blob/master/CONTRIBUTING.md) for ways to get started.

Please adhere to this project's [code of conduct](https://github.com/KalleHallden/exer_log/blob/master/CONDUCT.md).

## Development

Install the Flutter SDK from the official [Flutter](https://docs.flutter.dev/get-started/install) website for your operating system. Note that this project was created using Flutter 2.5.0.

---

## Cloning for Windows

Clone this project

```
git clone https://github.com/KalleHallden/exer_log.git
```

CD into the project

```bash
cd exer_log/app/exerlog
```

Download dependencies

```bash
flutter pub get
```

Run the project

```bash
flutter run
```

Execute all commands simultaneously

```bash
git clone https://github.com/KalleHallden/exer_log.git & cd exer_log/app/exerlog & flutter pub get & flutter run
```

## Cloning for Mac / Linux

```
git clone https://github.com/KalleHallden/exer_log.git
```

CD into the project

```bash
cd exer_log/app/exerlog
```

Download dependencies

```bash
flutter pub get
```

Run the project

```bash
flutter run
```

Execute all commands simultaneously

```bash
git clone https://github.com/KalleHallden/exer_log.git && cd exer_log/app/exerlog && flutter pub get && flutter run
```

## Authors

- [@KalleHallden](https://github.com/KalleHallden)
