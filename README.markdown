# LCD Numbers

## About

Best of Ruby Quiz, Chapter 2

Write a program that displays LCD-style numbers at adjustable sizes. 
The digits to be displayed will be passed as an argument to the program. Size should be controlled with the command-line option `-s` followed by a positive integer. The default value for `-s` is 2.

    $ lcd.rb 012345
    $ lcd.rb -s 1 6789

## Requirements

Ruby 2.2.2

## Usage

    $ lcd.rb 012345
    $ lcd.rb -s 1 6789

## Observations

- Corners are always 1 character and blank.
- Mid-points are always 1 character and blank.
- Each digit is made up of top, top-left, top-right, middle, bottom-left, bottom-right, bottom.

