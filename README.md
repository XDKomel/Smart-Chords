# Smart Chords

A Flutter project for the Flutter course 

## What is this app about

This app allows you to watch songs' chords, while it automatically scrolls them and adjusts according to your eyes position.

[App Icon](https://user-images.githubusercontent.com/35888414/230712008-e9617308-5259-4663-943d-fd37c37ec57e.png)

## Screens

There are two screens: a list of all supported songs + the screen with chords. More screenshots are [on the drive](https://disk.yandex.com/d/eT2Or7zTcG8LbQ).

## How are songs stored

The songs are stored on Firebase Firestore

## How does the recognition work

It uses the [eye tracking API](https://rapidapi.com/smartclick-smartclick-default/api/eye-tracking-and-gaze-detection) with the [IMGBB](https://api.imgbb.com/) to store temporary images.

## What architectural decisions have been made?

The app uses Riverpod with the default setState, and the UI files are separated from logic, so each screen has its own controller.

## IT WORKS WITH iOS and WEB!!!

## IT USES A CUSTOM MATERIAL 3 THEME 

## [Recording and the APK](https://disk.yandex.com/d/eT2Or7zTcG8LbQ)
