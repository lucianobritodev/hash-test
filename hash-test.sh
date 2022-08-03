#!/usr/bin/env bash
#
#-------------------------------------------------------
#
# autor: Luciano Brito
# author: Luciano Brito
#
#-------------------------------------------------------
#
# Creation
#
# Data: 05/04/2022 as 12:00 am
# Date: 05/04/2022 at 12:00 am
#
#-------------------------------------------------------
#
# Contacts
#
# e-mail: lucianobrito.dev@gmail.com
# github: github.com/lucianobritodev
# linkedin: linkedin.com/in/luciano-brito-dev
#
#-------------------------------------------------------
#
# Versions
#
# version: 1.0.0 - Created script
#
#-------------------------------------------------------
#
# Script Execution
#
# To run the script run one of the following commands:
#
# chmod +x hash-test.sh 		=> Add execution permission
# ./hash-test.sh			=> To exec
# or
# bash hash-test.sh 			=> To exec
#-------------------------------------------------------

_VERIFICATION=
TYPE_TESTER=
HASH_PARAMETER=
_PATH=
FLAG=0

_VERIFICATION="$(zenity --title="Teste de Integridade" \
	--text="Escolha o tipo de verificação a ser realizada\n" \
	--list \
	--radiolist \
	--column "" \
	--column "Indice" \
	--column "Tipo" \
	True 1 'Verificacao de arquivo' \
	False 2 'Comparacao de hash' \
	False 3 'Geracao de hash a partir de um arquivo' \
	--width=600 \
	--height=300)"
[ $? -ne 0 ] && exit 1;

function typeEncript() {
	TYPE_TESTER=$(zenity --title="Teste de Integridade" \
	--text="Escolha o tipo de encriptação\n" \
	--list \
	--radiolist \
	--column "" \
	--column "Indice" \
	--column "Tipo" \
	True 1 "SHA256" \
	False 2 "MD5" \
	--width=600 \
	--height=200)
	[ $? -ne 0 ] && exit 1;
}


function verificationFileExec() {
	typeEncript

	HASH_PARAMETER=$(zenity --entry \
		--title="Hash padrão" \
		--text="Cole o hash oficial no campo abaixo para ser comparado:" \
		--width=600 \
		--height=100)
	[ $? -ne 0 ] && exit 1;

	while [[ "$HASH_PARAMETER" == "" ]]; do
		zenity --info \
			--text="O hash para verificação é requerido!
			\nPor favor, cole o hash oficial no campo indicado." \
			--ellipsize
		[ $? -ne 0 ] && exit 1;

		HASH_PARAMETER=$(zenity --entry \
			--title="Hash padrão" \
			--text="Cole o hash oficial no campo abaixo para ser comparado:" \
			--width=600 \
			--height=100)
		[ $? -ne 0 ] && exit 1;
	done


	_PATH=$(zenity --title="Escolha o arquivo para ser verificado"  \
		--file-selection \
		--width=900 \
		--height=500)
	[ $? -ne 0 ] && exit 1;

	while [[ "$_PATH" == "" ]]; do
		zenity --info \
			--text="O arquivo para verificação é requerido!\nPor favor, escolha um arquivo para verificação de integridade." \
			--ellipsize
		[ $? -ne 0 ] && exit 1;

		_PATH="$(zenity --title="Escolha o arquivo para ser verificado"  \
			--file-selection \
			--width=900 \
			--height=500)"
		[ $? -ne 0 ] && exit 1;
	done
}

function printResult() {

	if [ $FLAG -eq 0 ]; then
		if [ $1 == "$HASH_PARAMETER" ]; then
			zenity --warning --title="Sucesso!" --text="Arquivo integro e equivante!" --ellipsize
			[ $? -ne 0 ] && exit 1;
		else
			zenity --error --title="Erro!" --text="Arquivo sem integridade ou sem equivalencia!" --ellipsize	
			[ $? -ne 0 ] && exit 1;
		fi
	else
		if [ $1 != "" ]; then
			zenity --info --title="Sucesso!" --text="Hash do tipo $2 gerado com sucesso:\n\n$1" --ellipsize
			[ $? -ne 0 ] && exit 1;
		else
			zenity --error --title="Erro!" --text="Não foi possível gerar o Hash do tipo $2!\n\nSelecione outro arquivo." --ellipsize
			[ $? -ne 0 ] && exit 1;
		fi
	fi

}


function executeSha256Sum() {
	local HASH
	HASH=$(sha256sum "$_PATH" | awk '{print $1}')
	printResult "$HASH" "sha256sum";

}

function executeMd5Sum() {
	local HASH
	HASH="$(md5sum "$_PATH" | awk '{print $1}')"
	printResult "$HASH" "md5sum";

}

function verificationFile() {
	FLAG=0
	verificationFileExec

	case $TYPE_TESTER in
		1 ) executeSha256Sum ;;
		2 ) executeMd5Sum ;;
		* ) exit 1 ;;
	esac
}


function compareHash() {
	local HASH_1
	local HASH_2

	HASH_1=$(zenity --entry \
	--title="Hash padrão" \
	--text="Cole o hash oficial no campo abaixo para ser comparado:" \
	--width=600 \
	--height=100)
	[ $? -ne 0 ] && exit 1;

	while [[ "$HASH_1" == "" ]]; do
		zenity --info \
			--text="O hash para verificação é requerido!
			\nPor favor, cole o hash oficial no campo indicado." \
			--ellipsize
		[ $? -ne 0 ] && exit 1;

		HASH_1=$(zenity --entry \
			--title="Hash padrão" \
			--text="Cole o hash oficial no campo abaixo para ser comparado:" \
			--width=600 \
			--height=100)
		[ $? -ne 0 ] && exit 1;
	done

	HASH_2=$(zenity --entry \
	--title="Hash para comparação" \
	--text="Cole o hash para comparação no campo abaixo:" \
	--width=600 \
	--height=100)
	[ $? -ne 0 ] && exit 1;

	while [[ "$HASH_2" == "" ]]; do
		zenity --info \
			--text="O hash para comparação é requerido!
			\nPor favor, cole o hash para comparação no campo indicado." \
			--ellipsize
		[ $? -ne 0 ] && exit 1;

		HASH_2=$(zenity --entry \
			--title="Hash para comparação" \
			--text="Cole o hash para comparação no campo abaixo:" \
			--width=600 \
			--height=100)
		[ $? -ne 0 ] && exit 1;
	done


	if [ $HASH_1 == $HASH_2 ]; then
		zenity --warning --title="Sucesso!" --text="Hashs equivantes!" --ellipsize
		[ $? -ne 0 ] && exit 1;
	else
		zenity --error --title="Erro!" --text="Hashs não são equivalentes!" --ellipsize	
		[ $? -ne 0 ] && exit 1;
	fi
}


function selectFile() {

	_PATH=$(zenity --title="Escolha o arquivo para geração de Hashs"  \
		--file-selection \
		--width=900 \
		--height=500)
	[ $? -ne 0 ] && exit 1;

	while [[ "$_PATH" == "" ]]; do
		zenity --info \
			--text="A localização do arquivo é requerido!\nPor favor, escolha um arquivo." \
			--ellipsize
		[ $? -ne 0 ] && exit 1;

		_PATH="$(zenity --title="Escolha o arquivo."  \
			--file-selection \
			--width=900 \
			--height=500)"
		[ $? -ne 0 ] && exit 1;
	done

	return archivePath;
}


function generateHashFromFile() {
	FLAG=1

	typeEncript
	selectFile

	echo "Path de arquivo: $_PATH"

	case $TYPE_TESTER in
		1 ) executeSha256Sum ;;
		2 ) executeMd5Sum ;;
		* ) exit 1 ;;
	esac

}

case $_VERIFICATION in
	1 ) verificationFile ;;
	2 ) compareHash ;;
	3 ) generateHashFromFile ;;
	* ) exit 1 ;;
esac

exit 0;
