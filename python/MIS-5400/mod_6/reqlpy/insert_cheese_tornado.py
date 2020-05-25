import rethinkdb as r

# Connect
conn = r.connect(host='localhost', port=28015, db='CheeseTornado')


# Insert some records into the table
r.table('Cheese').insert([
    {'flavor': 'Yellow',
     'status': 'Moved',
     'color' : 'Blue'
     }
]).run(conn)
