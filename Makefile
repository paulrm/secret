help:
	@echo "Secret Files"
	@echo " - make decrypt         decripta ${TS_FILE}.dat"
	@echo " - make encrypt         encripta ${TS_FILE}"

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1 }}' | \
        sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
.DEFAULT_GOAL := help
.PHONY: list

TS_FILE=top-secret-file.md

# 'private' task for echoing instructions
_pwd_prompt:
	@echo "Contact paul.messina@gmail.com for the password."

# crea Archivo Inicial
create:
	echo "# Top Secret File" > ${TS_FILE}
	echo " Very Secret Infomartion" >> ${TS_FILE}

# des-encripta y borra el encriptado
decrypt: _pwd_prompt
	rm -f ${TS_FILE}
	openssl cast5-cbc -d -in ${TS_FILE}.dat -out ${TS_FILE}
	chmod 600 ${TS_FILE}
	test -f ${TS_FILE} && rm -f ${TS_FILE}.dat

#  encripta y borra el archivo clear 
encrypt: _pwd_prompt
	rm -f ${TS_FILE}.dat
	openssl cast5-cbc -e -in ${TS_FILE} -out ${TS_FILE}.dat
	test -f ${TS_FILE}.dat && rm -f ${TS_FILE}
