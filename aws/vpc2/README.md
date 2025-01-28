A sandbox I created in a virtual lab can be reached here <ssh terraform@10.148.37.91> (pass == terraform-test)

Builtin verification, and checks:

terraform ftm --check

terraform validate --json

terraform plan 

One way in which we can validate and test a main.tf is to leave that file with the basic template information and make it non-editable and then create two additional files one named variables.tf (also non-editable) that include validation checks and information, and another with extension .tfvars <terraform.tfvars> which a user can edit to place their desired variables to be used after which  :

After creation of main.tf, variables.tf, and terraform.tfvars, do the following to validate (which can be scripted.)
$ terraform fmt -check

$ terraform validate -json 

$ terraform plan



After running those tests/checks and if no errors were generated it would be safe to run..

$ terraform plan -out <plan.tf>

$ terraform apply <plan.tf>
