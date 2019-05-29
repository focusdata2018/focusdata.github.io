#!/bin/bash

SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
#SYMBOLS=$SYMBOLS'!@#$%&*()?/\[]{}-+_=<>.,'
# Строка со всеми символами создана.
# Теперь нам надо в цикле с количеством итераций равным длине пароля
# случайным образом взять один символ и добавить его в строку, содержащую пароль.
PWD_LENGTH=16  # длина пароля
PASSWORD=""    # переменная для хранения пароля
RANDOM=256     # инициализация генератора случайных чисел
for i in `seq 1 $PWD_LENGTH`
do
PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
done
echo $PASSWORD
exit 0
