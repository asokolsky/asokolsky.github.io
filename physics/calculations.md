# Efficient Scientific Calculations

You are given a test - solve a thousand of "science" problems in 1 hour.  Here are my recommendations...


## Basics

1. Use [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation).

2. Stick to a reasonable system of units, e.g. [metric system a.k.a. SI](https://en.wikipedia.org/wiki/International_System_of_Units).

3. Use two extra sheets: one for constants, another for conversions.

## Constants to Memorize

This is kept on separate sheet of paper to be distilled during the problem solving.

Pedestrian speed: 3-5 km/h.

Speed of sound (at atmospheric pressure): 330 m/s

Speed of light (in a vacuum): c = 300,000 km/s = 3 * 10^8 m/s

Gravity earth acceleration at sea level: g = 9.8 m/s^2

Water boiling temp at 1 atm = 100C


## Conversions

This is kept on separate sheet of paper to be distilled during the problem solving.


1 mile = 1609.34 meters

1" = 2.5 cm = 2.5 * 10^-2 m

1 hour = 60*60 secs = 3600 secs

1 psi = 6894.757293168 PA = 6.89 * 10^3 PA

1 atm = 101325 PA = 1.01 * 10^5 PA


## Problem.  Linear Movement

### Problem Statement

John walks home from school at a speed of 1 m/s.  His home is 2.5 miles from school.

How much time (in hours) will it take John to get home.

How much time (in minutes) will it take John to get home.

### Solution

Assumption: John maintains the average speed of 1 m/s at all times.

Formula: v * t = d

Hence: t = d / v

Solving the problem in metric system:

t (secs) = (2.5 * 1609)(meters) / 1 m/s = 2.5 * 1.6 * 10^3 = 4 * 10^3

t (hours) = 4 * 10^3 / 3.6 * 10^3 = 4 / 3.6 = 1.11

t (minutes) = 4 * 10^3 / 6 * 10 = .67 * 10^2 = 67

## Problem.  Gas Pressure

### Problem Statement

Bicycle wheel is 19" in radius.  The tire is 1" in diameter and contains air at the pressure of 20 psi.  How much volume will take the air from the tire at the pressure of 1 atmosphere.

### Solution

Assumption: tire is tor with walls of 0 thickness.

p1 * v1 = p2 * v2


Calculating tire volume:

wheel radius: R = 19" = 19 * 2.5 * 10^-2 = 4.75 * 10^-1

tube cross section radius: r = 0.5" = 0.5 * 2.5 * 10^-2 = 1.25 * 10^-2

tube cross section: pi * r^2

tire circumference: pi * R

tire volume: v1
  = pi * r^2 * pi * R
  = pi^2 * 1.25^2 * 10^-4 * 4.75 * 10^-1
  = 73.2 * 10^-5 = 7.32 * 10^-4 m^3

tire pressure: p1
  = 6.89 * 10^3 PA
