echo script incompleto && crash && \
#cd to terraform folder
cd  && \
#Waits for confirmation, -auto-approve removes it
terraform apply && \
#save outputs to file
terraform output >> ../output && \
#cds out
#cd .. && \

#format ansible hosts and other files from output
python3 format.py && \

ansible-playbook playbook.yaml -i hosts