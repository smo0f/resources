import uuid

class Game:
    def __init__(self, game_name = 'Default'):
        self.game_name = game_name
        self._vehicles = []

    def setup_game(self):

        # Build
        num_vehicles = int(input('How many vehicles do you want?'))

        vehicle_num = 1
        for vehicle in range(num_vehicles):
            name = 'smasher' + str(vehicle_num)
            if vehicle_num % 2 == 0:
                type = 'tank'
            else:
                type =  'mustang'

            if type.lower() == 'mustang':
                if vehicle_num % 2 == 0:
                    color = 'red'
                else:
                    color =  'blue'
                mustang = Mustang(color=color, name=name)

                self.add_vehicle(mustang)

            elif type.lower() == 'tank':
                tw = 30
                tank = Tank(tread_width=tw, name=name)
                self.add_vehicle(tank)


            vehicle_num += 1


    def add_vehicle(self, vehicle):
        if isinstance(vehicle, Vehicle):
            for v in self._vehicles:
                if vehicle._name.lower() == v._name.lower():
                    raise Exception('Vehicle with that name already exists. ')
            self._vehicles.append(vehicle)
        else:
            raise Exception('Only valid vehicles allowed!')

    def get_vehicle_by_id(self, id_to_retrieve):
        vehicle =  next(filter(lambda x: x._name == id_to_retrieve, self._vehicles))
        return vehicle

    def move_vehicle(self, name_of_vehicle_to_move):
        self._vehicles[self._vehicles.index(name_of_vehicle_to_move)]

    def get_game_stats(self):
        print('*' * 50)
        print('GAME SUMMARY  ')
        print('*' * 50)

        print('\nGAME NAME')
        print('*' * 20)
        print(self.game_name)

        print('\nTHE PLAYERS')
        print('*' * 20)
        for vehicle in self._vehicles:
            print(vehicle.get_summary())

        print('\nTHE RESULTS')
        print('*' * 20)
        for vehicle in self._vehicles:
            print(vehicle.get_current_odometer())

class Vehicle:
    total_vehicles_produced = 0

    def __init__(self, vtype, max_mph_speed, name):
        self.vtype = vtype
        self.max_mph_speed = max_mph_speed
        self._odometer = 0
        self._name = name
        self._vehicle_number = Vehicle.total_vehicles_produced
        self._unique_guid = str(uuid.uuid4())
        self._python_object_id = str(id(self))


        # Note that to access class variable it must be pre-fixed by class name
        Vehicle.total_vehicles_produced += 1

        #print('Vehicle Created...')

    def get_summary(self):
        return f'{self._name}, which is a: {self.vtype},reaching a max speed of {self.max_mph_speed} mph'

    def get_details_about_vehicle(self):
        return f'\n\n{self._name} DETAILS\n'\
               f'-------------------------\n'\
               f'*  _name: {self._name}\n'\
               f'*  _vehicle_number: {self._vehicle_number}\n'\
               f'*  _unique_guid: {self._unique_guid}\n' \
               f'*  _python_object_id: {self._python_object_id}\n\n'

    def get_current_odometer(self):
        return f'{self._name} currently has an odometer reading of: {self._odometer}.'

    def move_forward(self, miles):

        self._odometer += miles




class Tank(Vehicle):
    def __init__(self, name,tread_width=10):
        Vehicle.__init__(self, vtype='tank', max_mph_speed=50, name=name)
        self.tread_width = tread_width

    def move_forward(self, miles):
        Vehicle.move_forward(self, miles)
        print('Moving treads slowly but surely')
        return miles

    def fire_gun(self):
        print('Firing Weapon')

    def throw_grenade(self):
        print('Throw Grenade')



class Mustang(Vehicle):
    def __init__(self, name, color='red',):
        Vehicle.__init__(self, name=name, vtype='muscle-car', max_mph_speed=280)
        self.color = color


    def move_forward(self, miles):
        Vehicle.move_forward(self, miles)

        print('Moving mustang quickly!!!')
        return miles

    def burn_out(self):
        print('BUUURRRRRRRRN!')



def move_vehicle_forward(vehicle, miles):
    if not isinstance(vehicle, Vehicle):
        raise Exception('Only vehicles move forward!')
    return vehicle.move_forward(miles)

if __name__ == '__main__':

    # Create a new game

    game = Game(game_name='B@ttle Central')
    # Battle
    game.setup_game()
    game.get_game_stats()
    smasher1 = game.get_vehicle_by_id('smasher1')
    move_vehicle_forward(smasher1, 500)
    game.get_game_stats()


    print(smasher1.get_details_about_vehicle())


