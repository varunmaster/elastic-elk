import sys
import logging
import os
import time
import wget

def downloadAgent():
    if not os.name == 'nt':
        wget.download('https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.5.3-linux-x86_64.tar.gz', '/var/tmp/elastic.tar.gz')
    else:
        wget.download('https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.5.3-windows-x86_64.zip', 'C:\\Logs\\elastic.zip')

def main(args):
    if os.name == 'nt':
        print("Determined this is a Windows machine")
        fileLoc = 'C:\\Logs'
    else: 
        print("Determined this is a Linux machine")
        fileLoc = '/var/tmp/logs/'
    
    if not os.path.exists(fileLoc):
        print("The log directory didn't exist so creating one now in: ", fileLoc)
        os.makedirs(fileLoc)
    else:
        print("The log directory for this install script is: ", fileLoc)

    logFileName = str(os.path.basename(__file__)) + "-" + str(time.strftime('%d-%b-%Y--%H-%M-%S', time.localtime())) + ".log"
    print("The name of the current logFile is: ", logFileName)

    fullLogFileNameAndLoc = str(fileLoc) + logFileName
    
    logging.basicConfig(filename=fullLogFileNameAndLoc, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    #logging.basicConfig(filename=fullLogFileNameAndLoc, level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
    logging.info("----------Script Start----------")
    
    
    # TODO
    # finish the downloadAgent method
    #   add logic to store it in %temp% dir in windows
    #   add logic to extract the agent and then install it 

    print("args: ", args)

if __name__ == "__main__": 
    main(sys.argv[1:])
