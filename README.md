# SISOP IT-06

Repository ini berisi hasil pengerjaan Praktikum Sistem Operasi 2025 Modul 1

| Nama                     | Nrp        |
| ------------------------ | ---------- |
| Paundra Pujo Darmawan    | 5027241008 |
| Putri Joselina Silitonga | 5027241116 |

### Soal 2 (Paundra Pujo Darmawan)

Jadi untuk soal ini objektif nya adalah membuat sebuah aplikasi monitoring RAM dan CPU pada perangkat kita. Pada menu awal diharuskan untuk login, dan jika belum login harus melakukan register dahulu dengan beberapa ketentuan, yaitu:

- Email harus memiliki pola aaaa@bbb.ccc
  Contoh: pujo@gmail.com
- Email harus unik, jadi jika sudah ada email yang terdaftar di database, maka email tersebut tidak bisa digunakan untuk register lagi.
- Password harus mengandung lebih dari atau sama dengan 8.
- Password harus di hash menggunakan sha256

Pada fitur diatas, dapat di implementasikan menjadi beberapa fungsi:

- Pola email:

  ```shell
  validate_email() {
      local email=$1
      if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
          return 0
      else
          return 1
      fi
  }
  ```

- Cek email di database:

  ```shell
  email_exists() {
      local email=$1
      if grep -q "^.*,$email,.*$" "$CSV_FILE"; then
          return 0  # Email exists
      else
          return 1  # Email does not exist
      fi
  }
  ```

- Cek panjang password:

  ```shell
  validate_password() {
      local password=$1
      if [[ ${#password} -ge 8 ]]; then
          return 0
      else
          return 1
      fi
  }
  ```

- Hash password:
  `shell
local saved_password
saved_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
`
  Setelah melewati semua validasi diatas, maka user akan masuk ke database dan dapat login ke sistem.

```shell
    echo "$name,$email,$saved_password" >> "$CSV_FILE"
    echo "✅ Registration successful!"
    return 0
```

Setelah berhasil register, kita dapat login kedalam sistem dengan email dan password yang sudah dimasukkan.

```shell
    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')

    while IFS=',' read -r name email_in file_password; do
        if [[ "$email" == "$email_in" && "$password_hash" == "$file_password" ]]; then
            echo "✅ Login successful!"
            return 0
        fi
    done < <(tail -n +2 "$CSV_FILE")
```

##### Fitur register
<img src="./img/register.jpeg" width="300" />

##### Fitur login
<img src="./img/login.jpeg" width="300" />


**Soal 1: Putri Joselina Silitonga**

**Di sebuah desa kecil yang dikelilingi bukit hijau, Poppo dan Siroyo, dua sahabat karib, sering duduk di bawah pohon tua sambil membayangkan petualangan besar. Poppo, yang ceria dan penuh semangat, baru menemukan kesenangan dalam dunia buku, sementara Siroyo, dengan otaknya yang tajam, suka menganalisis segala hal. Suatu hari, mereka menemukan tablet ajaib berisi catatan misterius bernama reading_data.csv. Dengan bantuan keajaiban awk, mereka memutuskan untuk menjelajahi rahasia di balik data itu, siap menghadapi tantangan demi tantangan dalam petualangan baru mereka.**

**a. Bantu Poppo menghitung jumlah baris di tablet ajaib yang menunjukkan buku-buku yang dibaca oleh Chris Hemsworth.**

```bash
awk -F',' '$2 == "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca", count, "buku."}' reading_data.csv
```

-F',' → Menetapkan pemisah kolom sebagai koma (CSV format).

'$2 == "Chris Hemsworth"' → Mengecek apakah kolom kedua berisi "Chris Hemsworth".

{count++} → Menghitung jumlah baris yang cocok.

END {print "Chris Hemsworth membaca", count, "buku."} → Menampilkan hasil setelah semua baris diproses.

**b. Bantu Siroyo untuk menghitung rata-rata durasi membaca (Reading_Duration_Minutes) untuk buku-buku yang dibaca menggunakan “Tablet”**

```bash
awk -F, 'NR>1 && $8 == "Tablet" { sum += $6; count++ } END { if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah", sum / count, "menit."; else print "Tidak ada data."; }' reading_data.csv
```

'NR>1 && $8 == "Tablet"' →
NR>1 → Melewati baris pertama ( header).

$8 == "Tablet" → Memilih hanya baris yang di kolom ke-8 berisi "Tablet".

{ sum += $6; count++ } →
Menjumlahkan nilai di kolom ke-6 (durasi membaca).

END { if (count > 0) ... } →
Jika ada data (count > 0), hitung rata-rata sum / count dan cetak hasil.
Jika tidak ada data, cetak "Tidak ada data.".

**c.Siapa yang memberikan rating tertinggi untuk buku yang dibaca (Rating) beserta nama (Name) dan judul bukunya (Book_Title).**

```bash
awk -F, 'NR>1 {                                if ($7 > max) {                                                   
        max = $7
        title = $3
        reader = $2
    }                                                                                                     }                                
END {
    if (max > 0) 
        print "Pembaca dengan rating tertinggi:", reader, "-", title, "-", max
    else 
        print "Tidak ada data."
}' reading_data.csv
```

NR>1 → Melewati baris pertama (header).

Membandingkan rating tertinggi di kolom ke-7 ($7).

Jika ditemukan rating lebih tinggi, simpan rating, judul buku, dan nama pembaca.
Setelah semua data dibaca, cetak hasilnya.

d. **Bantu Siroyo menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023, beserta jumlahnya, agar laporannya jadi yang terbaik di klub**


```bash 
awk -F, '
$5 > "2023-12-31" && $9 == "Asia" { genre_count[$4]++ }
END {
    for (genre in genre_count)
        print genre, genre_count[genre]
}' reading_data.csv | sort -k2 -nr | head -n1 | awk '{print "Genre paling populer di Asia setelah 2023 adalah", $1, "dengan", $2, "buku."}'
```

Pilih hanya buku yang dibaca setelah 31 Desember 2023 ($5 > "2023-12-31").
Hanya untuk pembaca dari Asia ($9 == "Asia").

Simpan dalam array genre_count[$4]++.
Urutkan dan ambil genre terbanyak 

sort -k2 -nr → Urutkan berdasarkan jumlah buku (terbanyak ke terkecil).

head -n1 → Ambil genre dengan jumlah buku terbanyak.








