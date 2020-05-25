import rethinkdb as r

# Connect
conn = r.connect(host='localhost', port=28015, db='CheeseRealtime')

# Insert some records into the table
r.table('Cheese').insert([
    {'flavor': 'American',
     'status': 'Moved'
     },
    {'flavor': 'Pepperjack',
     'status': 'Available'
     }
]).run(conn)
