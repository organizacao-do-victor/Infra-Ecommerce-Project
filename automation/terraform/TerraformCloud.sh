#!/bin/sh
#Login no terraform cloud#
terraform login
#Pega o estado mais recente presente no cloud#
terraform state pull
