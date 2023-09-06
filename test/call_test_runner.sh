failures=0

for lang in "$@"
do
    output=$(./build/test_${lang}_call)
    expected_string="this is a test string"
    
    if [ "$output" == "$expected_string" ] 
    then
        echo -e "\033[32m${lang} worked\033[0m"
    else
        echo -e "\033[31m${lang} failed\033[0m"
        ((failures++))
        echo "expected ${expected_string}"
        echo "got ${output}"
    fi
done

echo -e "\n${failures} failures"

if [ $failures -gt 0 ]
then
    exit 1
fi
