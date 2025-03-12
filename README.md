## IT-06

Repository ini berisi hasil pengerjaan Praktikum Sistem Operasi 2025 Modul 1

| Nama                     | Nrp        |
| ------------------------ | ---------- |
| Paundra Pujo Darmawan    | 5027241008 |
| Putri Joselina Silitonga | 5027241116 |

### Soal 1

1. Di sebuah desa kecil yang dikelilingi bukit hijau, Poppo dan Siroyo, dua sahabat karib, sering duduk di bawah pohon tua sambil membayangkan petualangan besar. Poppo, yang ceria dan penuh semangat, baru menemukan kesenangan dalam dunia buku, sementara Siroyo, dengan otaknya yang tajam, suka menganalisis segala hal. Suatu hari, mereka menemukan tablet ajaib berisi catatan misterius bernama reading_data.csv. Dengan bantuan keajaiban awk, mereka memutuskan untuk menjelajahi rahasia di balik data itu, siap menghadapi tantangan demi tantangan dalam petualangan baru mereka.

a. Poppo baru saja mulai melihat tablet ajaib dan terpukau dengan kekerenan orang bernama “Chris Hemsworth”. Poppo jadi sangat ingin tahu berapa banyak buku yang dibaca oleh “Chris Hemsworth”. Bantu Poppo menghitung jumlah baris di tablet ajaib yang menunjukkan buku-buku yang dibaca oleh Chris Hemsworth.

```shell
awk -F',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_data.csv
```

b. Setelah menemukan tablet ajaib, Siroyo mulai penasaran dengan kebiasaan membaca yang tersimpan di dalamnya. Ia mulai menggunakan tablet ajaib dan bergumam sambil meneliti, “Aku ingin tahu berapa lama rata-rata mereka membaca dengan benda ini”. Bantu Siroyo untuk menghitung rata-rata durasi membaca (Reading_Duration_Minutes) untuk buku-buku yang dibaca menggunakan “Tablet”

```shell
awk -F, 'NR>1 && $8 == "Tablet" { sum += $6; count++ } END { if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah", sum / count, "menit."; else print "Tidak ada data."; }' reading_data.csv
```

c. Sementara Siroyo sibuk menganalisis tablet ajaib, Poppo duduk disampingnya dengan ide cemerlang. “Kalau kita sudah tahu cara mereka membaca, aku ingin memberi hadiah ke temen yang paling suka sama bukunya!”. Ia pun mencari siapa yang memberikan rating tertinggi untuk buku yang dibaca (Rating) beserta nama (Name) dan judul bukunya (Book_Title).

```shell
awk -F, 'NR>1 {if ($7 > max) {max=$7; title=$3}} END {print "Buku dengan rating tertinggi:", (max > 0 ? title : "Tidak ada data"), "dengan rating: " max}' reading_data.csv
```

d. Siroyo mengusap keningnya dan berkata, "Petualangan kita belum selesai! Aku harus bikin laporan untuk klub buku besok." Ia ingin membuat laporan yang istimewa dengan tablet ajaib itu, fokus pada teman-teman di Asia. "Aku penasaran genre apa yang paling populer di sana setelah tahun 2023," katanya, membuka reading_data.csv sekali lagi. Bantu Siroyo menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023, beserta jumlahnya, agar laporannya jadi yang terbaik di klub.

```shell
awk -F, '
$5 > "2023-12-31" && $9 == "Asia" { genre_count[$4]++ }
END {
    for (genre in genre_count)
        print genre, genre_count[genre]
}' reading_data.csv | sort -k2 -nr | head -n1 | awk '{print "Genre paling populer di Asia setelah 2023 adalah", $1, "dengan", $2, "buku."}'
```
