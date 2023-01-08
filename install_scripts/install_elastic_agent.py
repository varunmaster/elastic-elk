import sys
import logging
import os
import time
import wget
import tarfile
import zipfile

def downloadAgent():
    if not os.name == 'nt':
        if not (os.path.exists("/var/tmp/elasticDownloadTemp")):
            os.makedirs("/var/tmp/elasticDownloadTemp")
            logging.info("Temp directory for downloading the elastic agent is created in /var/tmp/elasticDownloadTemp")
        wget.download('https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.5.3-linux-x86_64.tar.gz', '/var/tmp/elasticDownloadTemp/elastic.tar.gz')
        tarFile = tarfile.open("elastic.tar.gz")
        tarFile.extractall("/var/tmp/elasticDownloadTemp/")
        tarFile.close()

    else:
        if not (os.path.exists("C:\\Temp\\elasticDownloadTemp")):
            os.makedirs("C:\\Temp\\elasticDownloadTemp")
            logging.info("Temp directory for downloading the elastic agent is created in C:\\Temp\elasticDownloadTemp")
        wget.download('https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.5.3-windows-x86_64.zip', 'C:\\Temp\\elasticDownloadTemp\\elastic.zip')
        zippedFile = zipfile.ZipFile("C:\\Temp\\elasticDownloadTemp\\elastic.zip", mode='r')
        zippedFile.extractall("C:\\Temp\\elasticDownloadTemp")
    
    # TODO
    # write the installation steps 

def main(args):
    # for linux it will be 'posix'
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
    downloadAgent()

if __name__ == "__main__": 
    main(sys.argv[1:])
