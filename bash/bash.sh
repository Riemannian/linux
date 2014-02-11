# sed tutorial: http://www.grymoire.com/Unix/Sed.html

touch bashpractice.txt
echo "this daylight beautiful day" > bashpractice.txt

echo "cat bashpractice.txt: "
cat bashpractice.txt
echo ""

touch practice.txt
sed 's/day/plight/' <bashpractice.txt >practice.txt
mv -f practice.txt bashpractice.txt

echo "cat bashpractice.txt: "
cat bashpractice.txt
echo ""

touch practice.txt
sed 's/[g-t]*/sorry &/' <bashpractice.txt >practice.txt
mv -f practice.txt bashpractice.txt

echo "cat bashpractice.txt: "
cat bashpractice.txt



echo ""
