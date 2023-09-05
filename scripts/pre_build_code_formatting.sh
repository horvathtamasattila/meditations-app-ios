if which swiftFormat >/dev/null; then
	git diff --diff-filter=AM --name-only | grep -e '\(.*\).swift$' | while read line; do
		swiftformat "${line}"
		echo "SwiftFormat: ${line}"
	done
  
	git status --porcelain| grep -e '\(.*\).swift$' |awk '{if($1=="M" || $1=="A" || $1=="AM") {print $2}}' | while read line; do
		swiftformat "${line}"
		echo "SwiftFormat: ${line}"
	done

else
	echo "warning: SwiftFormat not installed"
fi

if which swiftlint >/dev/null; then
	swiftlint;
else
	echo "warning: SwiftLint not installed"
fi