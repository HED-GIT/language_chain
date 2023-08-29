failures=0

for lang in "$@"
do
    output=$(./build/test_${lang}_chain)

    expected_string=""
    
    for clang in "$@"
    do
        expected_string+="${clang} called by ${lang}\n"
    done
    expected_string=$(echo -e $expected_string)

    if [ "$output" == "$expected_string" ] 
    then
        echo -e "\033[32m${lang} worked\033[0m"
    else
        echo -e "\033[31m${lang} failed\033[0m"

        echo -e "expected:\n"
        echo -e $expected_string
        echo -e "\n\ngot:\n"
        echo -e $output

        ((failures++))
    fi
done

echo -e "\n${failures} failures"

if [ $failures -gt 0 ]
then
    exit 1
fi
