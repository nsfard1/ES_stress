import getopt, sys, subprocess

unixOptions = "hn:v"  
gnuOptions = ["help", "nodes=", "verbose"] 
n = 0

try:  
   arguments, values = getopt.getopt(sys.argv[1:], unixOptions, gnuOptions)
except getopt.error as err:  
   # output error, and return with an error code
   print (str(err))
   sys.exit(2)

for arg, val in arguments:  
   if arg in ("-v", "--verbose"):
      print ("enabling verbose mode")
   elif arg in ("-h", "--help"):
      print ("displaying help")
   elif arg in ("-n", "--nodes"):
      print (("num nodes = (%d)") % int(val))
      n = int(val)

subprocess.call("./setup_script 14 16")