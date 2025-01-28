 https://www.terraform.io/docs/language/modules/testing-experiment.html

Additional and experimental option:
/// Terraform test module notes

I've tested this experimental module, and would consider it an option to be used. However it is not finalized so there will be changes made to the module which could make it unstable for our usage at this time probably.

<Terraform test> module has some additional requirements in regards to structure of the dir that the main.tf and other files resides in. In order to properly utilize the <terraform test> module we need to have subdir created "tests/default/" and with in that directory a file named "tests_default.tf"
