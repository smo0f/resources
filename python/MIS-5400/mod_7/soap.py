# Using http://docs.python-zeep.org/en/master/

from zeep import Client

# Use the following WSDL http://www.webservicex.net/ConvertSpeed.asmx?WSDL

client = Client('http://www.dneonline.com/calculator.asmx?wsdl')
result = client.service.Add(12, 34)
print(result)