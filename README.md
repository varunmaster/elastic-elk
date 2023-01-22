# About
ELK stack installation "automatiion". This project is basically for MY home setup and if you happen to stumble upon this, it may or may not work for you. Make changes where necessary for your setup. 

## Setup
My config consists of below:
- **E**lasticsearch: CentOS 7.9 host (non-cluster/single host) with 4 Core and 16 GB RAM
    - Installation script: 
        ```sh
        /install_scripts/install_elastic_search.sh
        ```
        > Note: this is a shell script because I know that my host is Linux so I don't want to deal with Python for OS agnostic-ness and laziness :D
- **L**ogstash: asf
- **K**ibana: asdf

##### If you do end up using any of my scripts, please drop me a note that you used it (and which part) because it's nice to know that my code actually works for other people. 