#####################
# IMPORTING MODULES #
#####################

'''
Modules are simply Python files stored on our computer.
When we "import" a module, it loads and executes the file and creates
all of the objects from it (e.g. variables, functions, classes, etc...).

We can specify where the Python interpreter looks for
these files, but by default third-party modules get installed to the following:

Windows
c:/python38-64/Lib/site-packages

Mac OS
Using Global: /Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages
Using venv (Virtual Environment): [project root]/venv/lib/python3.8/site-packages


Many of these modules are included in the Python Standard Library.
A description of these is available at
https://docs.python.org/3.7/library/

However, most are 3rd party, meaning we will install / download them.
'''


################
# TRY IT OUT! #
###############

import mod_6.games.battle_game as bg

def main():
    game = bg.Game('@New Game')

    a_tank = bg.Tank(tread_width=30)

    game.add_vehicle(a_tank)

    game.get_game_stats()

if __name__ == '__main__':
    main()

#
# A module can be used to abstract logic, just like a function or a class.
#
# It defines some variables, maybe to be used as settings that can be changed.
# It also defines functions or classes that can be called by any other Python code that imports it.
# This is the next level of abstraction from a function and class
#
# We can group functions and classes into a module to provide a robust set of code for all to use.
