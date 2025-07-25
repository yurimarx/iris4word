## iris4word

 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/iris4word)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis4word&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis4word)
 
This is a Developer Tool to create MS Word content with InterSystems IRIS.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation with ZPM

zpm:USER>install iris4word

## Installation for development

Create your repository from template.

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone https://github.com/yurimarx/iris4word.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

## How to Work With it

1. Open the Postman
2. Import the iris4word.postman_collection.json file (in the root folder of this repository)
3. Upload the file template template.docx (in the sample/template.docx path of this repository). To upload, fill the file field into the Body tab with sample/template.docx
4. Open the 2. Download Word Document
5. Go to the /sample/data.json, copy the content and past into the body of the Download Word Document 
6. On the Send button, select the option Send and Download
7. See the results
8. Compare with sample/data.json
9. Open the file sample/template.docx and see the marks and tags used.
10. Enjoy this app to create word documents easily!