# log_report.py
'''
This is the log_report Module! Woot!
'''

def generate_report():
    # Create some empty lists to store the parsed data in. 
    logs_404 = []

    with open(r'access.log') as f:
        # Lets loop through each line in the file. 
        for line in f: 
            # Add it to one of the following (It could be both "MIS" and "404")
            if '404' in line:
                logs_404.append(line)


    # Write out our report
    out_file = open(r'404_errors.log', 'x')
    out_file.write('\n'.join(logs_404))
    out_file.close()

