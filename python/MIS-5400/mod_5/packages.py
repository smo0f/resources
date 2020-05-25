#####################################
# PACKAGES - Collections of Modules #
#####################################
'''
* Packages are created by placing a module named __init__.py
* at the root of a directory (folder), at that point every module
* inside of that directory belongs to the package.
*
*
*
* Copy the folder "mis" and it's contents to your Site-Packages directory
*
'''

'''
This is the mis package!
'''
import mis
result = mis.calculator.add(2, 3)

print(result)


mis.sms.send('Sup')

# Even though talker.py exists in the mis package, since we did not import it in __init__.py, it is not available.
#mis.talker.talk() # FAILS

# In our __init__.py we can control which modules
# get loaded on a default import.
# Go look in the __init__.py file to see which modules are imported
# We can explicity import modules like this:
import mis.talker
mis.talker.talk()


# We can also import only modules we are interested in
from mis import sms



# If the __init__.py file has the __all__ variable set
# then from mis import * will import every module declared there
from mis import *

#########
# TESTS #
#########
# Take a look at the sms.py module...
# It is common to include tests with your modules.
name_var_in_sms = sms.say_my_name()
print(name_var_in_sms)

