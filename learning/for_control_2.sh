#!/usr/bin/env bash

# continue
for i in $(seq 1 9)
    do
        if [[ "$i" -eq 5 ]]; then
            continue
        fi

        echo "$i"
done


# break
for ((;;))
    do
        read -p "char: " ch
        if [[ "$ch" == "q" ]]
            then
                break
        fi

        echo "你输入的字符是: $ch"

done

