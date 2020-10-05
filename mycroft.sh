#!/bin/bash

curl 'https://mycroftproject.com/search-engines.html?submitform=entirelist' \
	| grep addOpenSearch \
	| cut -c 27- \
	> mycroft-list

# example:
# onClick="addOpenSearch('bg_nivuk','ico','','39782','g');return false">Bible Gateway Passage (NIV-UK)</a>
# [strip first 27 chars]
# 'bg_nivuk','ico','','39782','g');return false">Bible Gateway Passage (NIV-UK)</a>

mkdir plugins

while read -r l; do
	echo "$l"
	name=$(echo "$l" | cut -d ',' -f 1)
	name="${name:1:-1}"
	ext=$(echo "$l" | cut -d ',' -f 2)
	ext="${ext:1:-1}"
	#cat=
	pid=$(echo "$l" | cut -d ',' -f 4)
	pid="${pid:1:-1}"
	#meth=
	#title=$(echo "$l" | cut -d '>' -f 2 | cut -d '<' -f 1)

	# plugin
	curl -so "plugins/${pid}__$name.xml" "https://mycroftproject.com/installos.php/$pid/$name.xml"
	# icon
	curl -so "plugins/${pid}__$name.$ext" "https://mycroftproject.com/installos.php/$pid/$name.$ext"

done < mycroft-list
