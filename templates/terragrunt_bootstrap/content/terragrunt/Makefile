.PHONY: fmt checkov
fmt:
	terraform fmt -recursive aws &&\
	terragrunt hclfmt

checkov:
	checkov --directory=aws