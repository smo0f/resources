#####################################
# PYPI 3rd Party Package Repository #
#####################################
'''
The Python Package Index site https://pypi.python.org/
has more packages than you can shake a stick at!

Let's look at an example of how to use them

# GeoPy
# GitHub: https://geopy.readthedocs.org/en/1.8.1/
# Pypi: https://pypi.python.org/pypi/geopy/1.8.1

# Installed by running the following in the

# OS Command Prompt (May need to add to path)

pip install geopy

pip is the built in package manager for Python
more details here https://pip.pypa.io/en/latest/

'''


# execute "pip install geopy" from os shell
# This will install it into site-packages

from geopy.geocoders import Nominatim
geolocator = Nominatim()

location = geolocator.geocode("175 5th Avenue NYC")
print('\n',location.address)

print('\n',location.latitude, location.longitude)

print('\n',location.raw)

# Can also do reverse  / Fuzzy Matching
# Which county is Seattle, WA in?
location = geolocator.geocode("Seattle, WA")
print('\n',location.address)