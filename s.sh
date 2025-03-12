awk -F, '
$5 > "2023-12-31" && $9 == "Asia" { genre_count[$4]++ }
END {
	for (genre in genre_count)
        	print genre, genre_count[genre]
	fi
}' reading_data.csv
