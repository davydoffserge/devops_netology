# devops-netology
# **/.terraform/* добавляет в исключения директорию .terrafotm где бы она не находилась

# *.tfstate добавит в исключения файлы с расширением .tfstate , например
# Dima.tfstate
# *.tfstate.* будет в исключениях Dima.tfstate.old к примеру.

# crash.log добавит в исключения файл с конкретным именем - crash.log

# *.tfvars соответственно будут файлы с расширением .tfvars , Dima.tfvars

# override.tf и override.tf.json будут исключены файлы с соответствующими именами

# *_override.tf - файлы оканчивающиеся на _override.tf
# *_override.tf.json - файлы оканчивающиеся на _override.tf.json

# .terraformrc - соответствующий файл .terraformrc 
# terraform.rc - файл terraform.rc 
#
