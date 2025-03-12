awk -F',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_data.csv

awk -F, 'NR>1 && $8 == "Tablet" { sum += $6; count++ } END { if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah", sum / count, "menit."; else print "Tidak ada data."; }' reading_data.csv

awk -F, 'NR>1 {if ($7 > max) {max=$7; title=$3}} END {print "Buku dengan rating tertinggi:", (max > 0 ? title : "Tidak ada data"), "dengan rating: " max}' reading_data.csv

awk -F, '
$5 > "2023-12-31" && $9 == "Asia" { genre_count[$4]++ }
END {
    for (genre in genre_count)
        print genre, genre_count[genre]
}' reading_data.csv | sort -k2 -nr | head -n1 | awk '{print "Genre paling populer di Asia setelah 2023 adalah", $1, "dengan", $2, "buku."}'

