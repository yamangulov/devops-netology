### все скрытые каталоги .terraform на любом уровне вложенности
**/.terraform/*

### все файлы с расширением .tfstate или содержащие tfstate в названии, отделенное точками
*.tfstate
*.tfstate.*

# все файлы crash.log или имеющие crash. в начале и .log в конце имени файла
crash.log
crash.*.log

### все файлы с окончанием на .tfvars или .tfvars.json
*.tfvars
*.tfvars.json

### все файлы override.tf, override.tf.json или заканчивающиеся на _override.tf или _override.tf.json
override.tf
override.tf.json
*_override.tf
*_override.tf.json

### это образец, означающий, что все файлы example_override.tf включаются в индекс git, даже если
### они удовлетворяют любому из вышестоящих правил
# !example_override.tf

### все файлы, которые начинаются строкой "example: ", затем любое число любых символов, затем строка "tfplan"
### затем любое число любых символов
# example: *tfplan*

### все файлы .terraformrc или terraform.rc
.terraformrc
terraform.rc