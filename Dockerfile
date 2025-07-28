ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

COPY sample /usr/irissys/bin/sample/
COPY enstemplate.docx /usr/irissys/enstemplate.docx
COPY iris4word-1.0.0-jar-with-dependencies.jar /usr/irissys/bin/

WORKDIR /home/irisowner/dev

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    iris stop IRIS quietly
