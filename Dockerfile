ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

COPY sample /usr/irissys/bin/sample/
COPY enstemplate.docx /usr/irissys/enstemplate.docx
COPY bitemplate.docx /usr/irissys/bitemplate.docx
COPY iris4word-1.0.0-jar-with-dependencies.jar /usr/irissys/bin/

WORKDIR /home/irisowner/dev

ARG TESTS=0
ARG MODULE="iris4word"
ARG NAMESPACE="USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly
