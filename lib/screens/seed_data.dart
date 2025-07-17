import 'package:cloud_firestore/cloud_firestore.dart';

final List<Map<String, dynamic>> seedBooks = [
  {
    "no": 1,
    "author": "Raisya Azliey",
    "title": "CINTA VERSI DIA",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 2,
    "author": "Raisya Azliey",
    "title": "EX SKANDAL SEBELAH RUMAH",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 3,
    "author": "Raisya Azliey",
    "title": "SAYANG",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 4,
    "author": "Raisya Azliey",
    "title": "THANKS BOSS",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 5,
    "author": "Raisya Azliey",
    "title": "KAHWIN BFF",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 6,
    "author": "Raisya Azliey",
    "title": "MY500K HUSBAND",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 7,
    "author": "Raisya Azliey",
    "title": "KAY : BUKAN SATU MALAM",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 8,
    "author": "Raisya Azliey",
    "title": "TAKE CARE, TUAN",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 9,
    "author": "Raisya Azliey",
    "title": "IKAT HATI DIA",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 10,
    "author": "Raisya Azliey",
    "title": "CUKUP DIRINYA SAJA",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 11,
    "author": "Raisya Azliey",
    "title": "I LOVE YOU MORE",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 12,
    "author": "Raisya Azliey",
    "title": "DIYA ALDRISH : PENGHUJUNG DENDAM",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 13,
    "author": "Raisya Azliey",
    "title": "HATI YANG TERPILIH",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 14,
    "author": "Raisya Azliey",
    "title": "BAD LIAR",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 15,
    "author": "Raisya Azliey",
    "title": "ISTERI TAK DIANGGAP",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 16,
    "author": "Raisya Azliey",
    "title": "TUAN FARITH : SKANDAL TAK DIRANCANG",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 17,
    "author": "Raisya Azliey",
    "title": "LAURA ARDEL",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 18,
    "author": "Raisya Azliey",
    "title": "DEEJA FAHRY : BAHAGIA YANG KAU TUNDA",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 19,
    "author": "Raisya Azliey",
    "title": "UNTUK 5 HARI KAU DAN AKU",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 20,
    "author": "Raisya Azliey",
    "title": "TUAN PENJAGA CIK KESAYANGAN",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 21,
    "author": "Raisya Azliey",
    "title": "YANG PERNAH PERGI",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 22,
    "author": "Raisya Azliey",
    "title": "PEREMPUAN YANG TERLUKA",
    "genre": "Novel Melayu",
    "description": ""
  },
  {
    "no": 23,
    "author": "Zati Mohd",
    "title": "CALON ISTERI TUAN HAIDER",
    "genre": "Novel Melayu",
    "description": "Bekerja di Kiddocare membuatkan aku tersangkut secara tak sengaja dengan Tuan Haider. Duda anak satu. Sikecil yang bernama Nia.\nMenjaga Nia secara tak langsung membuatkan aku rapat dengan papanya. Sampailah suatu hari aku di kenalkan sebagai calon isteri Tuan Haider dekat bekas isterinya.\n\"Calon isteri I.. bakal ibu Nia.?\nAku ingatkan main-main, rupanya memang dia tekad nak jadikan aku calon ibu buat Nia. Sikap Tuan Haider yang agak gentleman dan pesona Tuan Haider membuatkan perasaan aku sedikit goyah. \nHinggalah suatu pagi, ayah telefon dan bagitahu Tuan Haider masuk meminang aku. \nKenapa Tuan Haider masuk meminang saya? - Haneesa. \nAdakah dia benar-benar menyayangi aku atau hanya mahu carikan pengganti untuk ibu Nia?"
  },
  {
    "no": 24,
    "author": "Zati Mohd",
    "title": "MY BAE.. TENGKU FAHD",
    "genre": "Novel Melayu",
    "description": "Setiap kali bertembung hanya mata saja yang menyapa. Tiada senyuman terukir mahupun apa-apa perkataan.\nIya itu yang terjadi bila aku si Zalikha asyik bertembung dengan Tengku Fahd a.k.a Tengku Fahad the eligible bachelor yang aku tengok dekat media sosial. \nSampailah satu hari entah mana silapnya aku dikenalkan sebagai bakal isteri Tengku Fahd. Aku ulang bakal isteri. Gila! Tak pernah terfikir dalam kepala otak aku ni yang aku akan jadi isteri dia. Lelaki yang aku pernah cakap \"malang betul bini dia nanti.\" \nBukan dalam kalangan ahli keluarga aku saja yang kecoh tapi satu Malaysia termasuk lah kekasih-kekasih Tengku Fahd.\n \"Call off the wedding.\" - Tengku Fahd.\n \"Ehhh saya memang tak setuju. Lagipun Tengku Fahd bukan ada ciri-ciri lelaki idaman saya pun.\"\n \"Then apa ciri-ciri lelaki idaman awak?\" Keningnya terjungkit sedikit.\n \"Act with services, romantik, baik, jujur, setia, tak banyak perempuan, handsome, kaya, hero novel.\" Senarai panjang aku bagi.\n \"Well.. semua tu saya ada.\" Dia senyum.\n Bluerk! Tang banyak perempuan aje dah failed.\n Tapi itulah, jodoh tu rahsia Allah. Tak fasal kena kahwin dengan Tengku Fahd. Bermulalah ketenteraman hidup aku diganggu oleh perempuan-perempuan spesis tak boleh move on.\n Dah hari-hari jumpa mestilah akan jatuh cinta. Sampai kehadiran Moana buat aku goyah.\n \"I pregnant anak Fahd. Please.. kalau you tak boleh terima I tak apa.. you jaga anak i.. please Zalikha.\"\n Kusut, serabut, sakit hati, sakit jiwa.\n \"Sayang.. tu bukan anak abang..\"\n \"Then anak siapa? Anak Ika?\"\n Sebab tu aku takut nak sayang dan cintakan orang, takut disakiti.. perlu ke aku tinggalkan Fahd demi anak yang Moana kandung? Seorang anak perlukan keluarga yang sempurna.."
  },
    {
    "no": 25,
    "author": "Zati Mohd",
    "title": "BERDOSAKAH AKU",
    "genre": "Novel Melayu",
    "description": "Tak mengandung perempuan salah..\nTak pandai jaga anak perempuan salah..\nTak ada jodoh perempuan salah..\nTak pandai masak perempuan salah..\nKenapa setiap kesalahan harus diletak atas kepala insan bernama perempuan.\nKalau dah nama menantu tu buat lah kerja..\nKalau dah tak boleh mengandung bagi suami tu kahwin lain..\nohh dia tak apa, tak ada anak.. biar dia buat.\nItulah Ayu.. nama yang indah tetapi tak seindah kehidupan. Usia perkahwinan selama\nempat tahun tanpa zuriat meletakkan Ayu sebagai wanita paling malang di dunia.\nNamun kerana ingin menjaga aib suami dan keluarga mentua semuanya di telan sendiri.\nHati yang terluka terpaksa dia ikhlaskan semua. Alasan tak punya zuriat menyebabkan\nAyu dibuang begitu sahaja.\nIkuti kisah Ayu.. adaptasi dari KRT / IIUM / KISAH BENAR insan terdekat dan\npenambahan sedikit fiksyen.\n\"Kami semua dah sepakat nak kahwinkan Saiful dengan Wanie, yela kamu kan tak boleh\nmengandung.\" - Makanjang yang kenenkan Saiful dengan Wanie.\n\"Basuh baju ni pakai tangan tau Kak Ayu, jangan pakai mesin ni baju mahal harga ratusratus.\nLagi satu kakngah cakap suruh bancuh susu anak dia. Yela kak Ayu kan takde\nanak.. ada banyak masa lapang.\" - Afiqah (adik ipar Ayu)\n\"Awak kahwin dengan saya.. kita balas dendam.. jangan tunjuk wanita tu lemah Ayu..\nawak sempurna dekat mata saya.\" - Hakim si sweet manis melecas"
  },
  {
    "no": 26,
    "author": "Zati Mohd",
    "title": "KAU MASIH KUCINTAI",
    "genre": "Novel Melayu",
    "description": "Tolong aku please kali ni aje.. aku janji last.\" Gaya dia merayu-rayu dekat aku.\nFuh! Aku hela nafas panjang. Panjang dari Perlis sampai Johor.\n\"Kau ingat kita kembar.. muka kita sama.. semua benda aku nak cover kau? Tolong la\nwei kau nak bertunang sabtu ni kan? Flight kau hari khamis. Kau memang suka buat gila\nkan.\" Aku marah sungguh-sungguh.\n\"Please kau aje harapan aku. Kau tahu kan impian aku nak jadi angle untuk satu produk\ninternational di Turki. Aku dah hantar paperwork, diorang suka. Sekarang aku kena pergi\nuntuk saringan ujibakat pulak. Tolong lah please.\"\nAku diam.\nAku Farah Afiqah.. gadis yang simple, cuma letak compact powder dengan liptint pastu\ntudung aku belasah ikut dan janji sarung atas kepala. Boyfriend? Takde.. sebab fokus aku\nnak jadi.. hurm jadi apa? Haaa.. fokus hidup aku jadi tukang cover si kembar kalau dia\nada masalah. Contohnya macam sekarang.\nDia. Farah Atikah.. gadis yang complicated. Sebelum keluar harus bersiap 1 jam awal.\nDari foundation sampai lip matte harus pakai elok-elok. Tudung? Harus lilit terletak\ncantik kalau tak rumah ni boleh meletup sebab tudung tak jadi. Instafamous merangkap\nmodel muslimah. Jumlah pengikut dia 630k. Fokus hidup dia nak lebarkan pengaruh\nhingga ke tahap international. Boyfriend? Boyfriend dia anak orang paling kaya dekat\nMalaysia. Kamal Hadi aka Hadi.\nHadi.. jejaka impian gadis-gadis malaya.. Malaysia, Indonesia, Brunei, Singapore siapa\ntak kenal. Tapi suri hati dia hanya Farah Atikah si model muslimah yang cantik namati.\nHandsome, bergaya, maskulin, macho ala-ala Mario Casas.\nMacam mana aku si Farah Afiqah nak jadi Farah Atikah dan menyamar sebagai tunang\nHadi. Omg! Aku kena lari jugak ke? Atau stay dekat sini dan jadi Farah Atikah. Aku\nbuntu.."
  },
  {
    "no": 27,
    "author": "Zati Mohd",
    "title": "LURUHNYA CINTA DI BUMI KOREA",
    "genre": "Novel Melayu",
    "description": "Bercinta dengan IDOL KPOP? korang tak percayakan? Tapi itulah realiti seorang gadis\nbernama Izznie Syahirah. Perkenalan yang tercipta bersama Lee Jong Hyun semasa\nIzznie berpindah ke sebuah apartment studio di wilayah Seoul. Perkenalan yang bermula\nsebagai jiran akhirnya merubah mereka kepada kekasih.\nTapi bila Izznie serahkan seluruh hidupnya pada Jong Hyun. Berita Lee Jong Hyun\nbermain cinta bersama Idol Hanna Lee mendapat liputan meluas hingga ke media\ninternasional. Tanpa tunggu penjelasan, Izznie balik ke Malaysia. Hidupnya berubah 360\ndarjah. Nak tunggu penjelasan apa. Nak jumpa Lee Jong Hyun pun susah.\nTiga tahun berlalu, Izznie kini bertugas sebagai seorang wartawan hiburan. Mama nak\njodohkan dia dengan Hafiz anak ustazah mana entah. Laju saja Izznie menolak kerana\nkisah silamnya.\nTiba suatu hari Tuan Loqman ketua jabatan minta Izznie membuat liputan khas sebuah\nkumpulan yang sekarang ni sangat terkenal di dunia. Kumpulan Wazzup. Izznie tolak\nsebab dia tak nak jumpa Lee Jong Hyun tapi Tuan Loqman paksa jugak. Dengan bagi\njaminan kenaikan gaji. Izznie paksa rela.\nTour Konsert in Malaysia. Hari yang ditunggu pun tiba. Izznie tak boleh tipu rasa hati\nbila dia masih lagi sayangkan Lee Jong Hyun. Masa konsert tu, Lee Jong Hyun nyanyi\nsatu lagu khas yang dia cipta untuk Izznie ?still waiting for you?.\nBerbunga balikkah cinta Izznie untuk Lee Jong Hyun di Malaysia? Atau Izznie tetap ikut\nkata mamanya untuk belajar mencintai Hafiz walaupun hatinya tak rela?"
  },
  {
    "no": 28,
    "author": "Zati Mohd",
    "title": "YANG MENCINTAIKU",
    "genre": "Novel Melayu",
    "description": "CURANG! Curang itulah sebuah pilihan bukanlah takdir yang sudah tertulis.\nPerkahwinan tanpa zuriat bukanlah suatu ujian yang mudah untuk semua pasangan.\nDihina, dicaci dan dicemuh adalah asam garam untuk mereka yang telah lama berkahwin\ntapi tidak dikurniakan zuriat.\nAkibat daripada masalah kesihatan yang dialami oleh Mia. Dia dijadikan alasan untuk\ndicurangi oleh Amir. Bahkan kecurangan Amir mendapat sokongan dari rakan-rakannya\nsendiri.\nHidup bermadu bukanlah sesuatu yang mudah. Bagi Mia untuk isteri pertama mengalah\nsudah tidak relevan di zaman moden ini. Dia bangkit kembali, segala harta, kemewahan\nyang disaji buat Amir di ambil semula. Berkali-kali dia meminta cerai Amir tidak mahu\nceraikannya akhirnya dia menuntut fasakh.\n\"Abang takkan ceraikan Mia. Abang tak dapat Mia. Tak ada siapa pun boleh dapat Mia.\nAbang akan gantung Mia tak bertali.\" - AMIR\n\"Sampai hati abang.. dah lah abang seksa hati dan perasaan Mia.. sekarang abang nak\nsekat pulak hak Mia. Apa dosa Mia dengan abang?\" MIA\nPerkenalannya dengan Azri duda anak 3 yang kematian isteri membuka ruang di hati\nuntuk dicintai. Kasih sayangnya tumpah pada 3 anak yatim itu.\n\"You deserve to be happy with your own way.\" AZRI.\nSelusuri kisah hidup seorang wanita yang bernama Mia di dalam YANG\nMENCINTAIKU."
  },
  {
    "no": 29,
    "author": "Zati Mohd",
    "title": "LIZZY",
    "genre": "Novel Melayu",
    "description": "Sebuah kisah cinta yang penuh pengorbanan.\nTiga tahun sudah berlalu, Lizzy kembali semula ke negaranya untuk mencari Rayyan.\nBila sudah dirasa keadaan kembali normal dan kes jenayahnya ditutup dia kembali\nmenjadi Lizzy yang baru. Hubungannya dengan Rayyan makin hari makin\nmencambahkan benih - benih cinta.\nDalam masa yang sama perkenalan antara Lizzy dan Kim sepupu Rayyan juga semakin\nerat.\n?Tolong aku hantarkan makanan ini untuk Lizzy. Aku ada kerja la malam ni.? Bekas\nmakanan terisi burger di suakan kepada Kim.\nHinggalah suatu hari, Rayyan didapati hilang selama tiga hari. Operasi mencari dan\nmenyelamat segera di jalankan. Janji Lizzy pada Rayyan adalah untuk tidak mengulangi\naktivitinya tiga tahun lepas. Kini, dia terpaksa ingkar. Mana mungkin dia terpaksa\nmelihat sahaja tunangnya hilang tanpa di jejak.\n?Rayyan.. awak dekat mana, kita akan berkahwin lagi dua minggu sahaja Rayyan.\nTolonglah jangan buat saya macam ni.? Jaket hitam dikenakan pada badan.\nMelihat susuk tubuh Lizzy yang murung. Kim tidak sampai hati.\n?Izinkan saya untuk menggantikan tempat Rayyan menjadi suami awak.? Pandangan\nmata Kim tepat membunuh anak mata Lizzy.\nApa yang terjadi pada Rayyan? Mampukah Lizzy tidak menjadi seorang pendendam\nseperti tiga tahun lalu. Dan apakah Kim berjaya mendapatkan cinta Lizzy. Dan siapa\ndalang di sebalik kes penculikan Rayyan. Semuanya akan terjawab dalam.."
  },
  {
    "no": 30,
    "author": "Zati Mohd",
    "title": "NOAH ALEXANDRO",
    "genre": "Novel Melayu",
    "description": "Noah Alexandro punya segalanya. Harta, pangkat, wajah, semua cukup lengkap kecuali\nsatu CINTA.\nAsyiqah atau lebih mesra dengan panggilan Iqa, tak punya apa-apa. Harta langsung tak\nada. Pangkat? Bayang pun tak nampak. Wajah? Kirim salam ajelah tapi dia punya satu\nhati yang penuh dengan kasih sayang.\nMereka dipertemukan kerana satu perkara. Terdesak.\nNoah terdesak perlukan tunang untuk diperkenalkan kepada keluarganya di Sabah,\nmanakala Iqa perlukan kerja untuk membayar segala hutang untuk keperluan hidup.\n\"Saya bayar awak 3000 sebulan tak termasuk gaji yang awak terima sekarang. Jadi\ntunang saya. Tapi ada syaratnya..awak hanya bekerja sebagai tunang saya. No hard\nfeeling. Maknanya awak tak boleh jatuh cinta dengan saya. Sebab awak bekerja sebagai\ntunang saya.\"\n\"Okay saya setuju. Jadi tunang aje kan?\"\nKontrak dipersetujui antara mereka. Tanpa sedar ada hati yang mula jatuh cinta.\nMereka mula bermain tarik tali. Mulut menidak tapi hati semakin mekar dengan rasa\ncinta.\nMampu cinta antara Noah Alexandro dan Asyiqah menjadi satu?"
  },
  {
    "no": 31,
    "author": "Zati Mohd",
    "title": "PADA SUATU HARI",
    "genre": "Novel Melayu",
    "description": "ROSA gadis cantik dan bijak dizaman moden dibagunkan balik pada zaman silam 1730.\nTerperangkap pada zaman dahulu kala. Menjadikan dia sebagai 'MAWAR' anak kepada\nbendahara.\nMawar anak gadis kepada bendahara dalam istana. Seorang yang lembab, senang di buli.\nNamun kebangkitan Rosa sebagai Mawar merubah segalanya. Seorang yang kasar, ceria,\nsenang bergaul.\nPertemuan tanpa sengaja yang sering terjadi antara Mawar dan putera Belawa anak isteri\nkedua dari mahajara Tiwahung menjadikan mereka sering berjumpa.\n\"Kau siapa ha?\" - Mawar aka Rosa.\n\"Kau tak kenal siapa aku?\" Jejaka kacak yang duduk diatas kuda tu jungkit kening.\n\"Ish.. tak ada masa nak kenal kau.. masalah aku pun banyak tak settle lagi.\"\nJejaka itu senyum.\n\"Jauh berjalan sampai dalam istana..\" jejaka itu peluk tubuh sambil berdiri depan Rosa.\n\"Cari ayah.\"\n\"Cari ayah atau cari saya?\" Dia senyum.\nOh shit! Kat mana-mana pun dia ada.\n\"Ayah kenalkan ini Putera Belawa.\"\nWhat? Putera? O-m-g\nDari pertemuan ke pertemuan itu wujud rasa cinta di hati mereka.\n\"Saya tak sanggup berpisah dengan awak Mawar. Jadi isteri saya?\" Putera Belawa.\nSehinggalah pada suatu hari, putera sulung Dekamatra yang tidak puas hati dengan\nPutera Belawa telah meracun Belawa dan jadikan Mawar sebagai isteri no 3 dia. Kerana\nsumpah setia. Mawar dan Belawa berjanji untuk jumpa pada kelahiran seterusnya.\n2019\nPertemuan tak dijangka antara Rosa (Mawar) dan Luth Mikael (Belawa) membawa kisah\nbaru di zaman milenia. Bagaimana kisah hidup meraka? Adakah persis kisah Mawar dan\nBelawa di zaman dahulu?\n\"Tepi sikit nak lalu.\" Luth Mikael.\n\"Awak..awak.. Putera Belawa?\"\n\"Saya Luth Mikael. Bila masa pulak jadi Belawa?\" Dia tergelak kecil.\n\"Tapi saya macam pernah jumpa awak tapi tak ingat dekat mana..\" dia sambung lagi.\nMampukah mereka bersatu semula menuntut janji-janji yang telah dibina pada suatu\nketika dahulu? Semuanya bakal terjawab dalam naskah pada suatu hari."
  },
  {
    "no": 32,
    "author": "Zati Mohd",
    "title": "TOLONG CINTAI AKU",
    "genre": "Novel Melayu",
    "description": "Setiap hari disebalik pintu dia menanti kepulangan suaminya. Bila terdengar deruman\nenjin motorsikal laju kakinya berlari. Dan kekecewaan mula muncul.\nBaru seminggu bernikah Alesya kematian suami tercinta Akmal. Hakikat itu tidak dapat\nditerima oleh dirinya.\nKesunyian, kehilangan, kerinduan yang amat dalam itu yang dirasainya saat ini. Saban\nwaktu Alesya menanti kepulangan Akmal.\nAkibat daripada tidak tahan melihat menantu tersayang sedih. Halijah meminta anak\nlelakinya iaitu Afiq abang kepada Akmal untuk menyamar menjadi suami kepada Alesya\nkerana muka Akmal dan Afiq seiras.\n\"Ibu ni merepek aje minta orang buat macam tu.. tak nak lah.. orang tak gila lagi ibu nak\njadi Akmal.\"\nNamun saban hari pujukan Halijah didengari dan Afiq setuju untuk menjadi watak\nutama..."
  },
  {
    "no": 33,
    "author": "Zati Mohd",
    "title": "JATUH CINTA LAGI",
    "genre": "Novel Melayu",
    "description": "Ini kisah hidup aku. Sera seorang penulis novel merangkap penulis skrip yang\nmemegang gelaran ?janda?.\nBerkahwin dan menyintai lelaki bernama Seung Hyun. Perkahwinan tanpa restu. Impian\naku adalah menjadi suri rumah tangga hancur berkecai. Bila kematangan tidak pernah\nmenguasai kami. Dan kata sepakat memutuskan untuk kami bercerai.\nMenyesal? Sudah tentu. Tapi gelaran ini akan aku bawa sampai bila-bila. Namun\nkeadaan merubah segalanya bila aku kembali berjumpa dengan dia. Choi Seung Hyun.\nMampukah aku seorang novelis merangkap penulis skrip jatuh cinta lagi dengan bekas\nsuami aku seorang Hallyu star terkenal di Korea."
  },
  {
    "no": 34,
    "author": "Zati Mohd",
    "title": "OH SEPHIA",
    "genre": "Novel Melayu",
    "description": "Sephia dicurangi berkali-kali namun dia masih setia dengan Kamal. Si lelaki buaya darat\nyang malas nak bekerja dan hanya habiskan duit perempuan.\nHinggalah suatu hari, Sephia dikejutkan dengan berita namanya di jadikan sebagai\npenjamin oleh Kamal yang membuat hutang disebuah agensi. Hidupnya tak tenang.\nHinggalah dia terpaksa lepaskan butiknya bagi membayar hutang Kamal.\nSephia jatuh miskin. Keretanya ditarik, rumah berbulan tidak berbayar. Api dipotong.\nHinggalah dia terpaksa bekerja sebagai clearner di salah sebuah hotel mewah.\nDisitu dia berjumpa dengan Anas Naufal. Lelaki yang paling dia benci dulu. Tapi apa\nboleh buat Anas Naufal pemilik hotel tersebut. Maka bermulalah episod benci, geram,\nsakit hati dan macam-macam lagi yang dilalui oleh Sephia.\nHingga Sephia terlupa. Hatinya makin jatuh cinta dengan Anas Naufal. Dalam benci ada\ncinta. Macam mana tu?"
  },
  {
    "no": 35,
    "author": "Zati Mohd",
    "title": "TIDAK AKAN HILANG CINTAKU",
    "genre": "Novel Melayu",
    "description": "Hidup dari tenang, gembira dan bahagia. Berubah menjadi mimpi buruk bila aku\njumpa dengan Fareeq Danial anak kepada bos aku iaitu Dato Zahar. Tak fasal fasal\njadi PA sementara si Fareeq tu.\nSikit pun dia tak bagi aku hidup dengan tenang.\n\"Darling awak tolong booking meja dekat W hotel saya nak dinner dengan Mawar\npelakon tu. Make sure saya nak yang paling romantik.\"\nNama aku Aileen Darlina tapi bila dengan Fareeq dia tukar jadi Aileen Darling. Apa\nbendalah dia ni.\n\"Darling orderkan saya dua puluh kuntum bunga ros merah. Saya nak pergi birthday\nparty Atikah model Sephora tu.\"\nDari kerja pejabat sampai hal peribadi aku kena uruskan. Suatu hari aku dapat\npanggilan kecemasan. Ibu jatuh sakit dan aku terpaksa balik kampung haritu jugak.\nAtas ihsan si Fareeq ni dia hantar aku balik ke Baling.\nDua hari di kampung aku nampak sisi lain si Fareeq. Hormat orang tua, baik dengan\norang kampung dan yang paling penting ibu senang dengan Fareeq. Ehhh sudah,\nbanyak sangat memuji ni.\nDan siapa sangka jodoh aku dah tertulis. Aku kena tangkap basah dengan Fareeq.\nKelakar! Tapi sebab berita dah tersebar. Dari baling ibu ke KL.. Dato Zahar terpaksa\nbuat keputusan. Kami kena nikah. Fareeq menolak dan aku lagilah tak nak!\nFaliq pula buat keputusan gila.\n\"Kalau abang tak nak biar Faliq yang ganti. Faliq nak kahwin dengan Aileen.\"\nAku dalam dilema. Fareeq atau Faliq. Dan keputusan dah dibuat.\nDari PA kepada isteri. Aku yakin Fareeq takkan jatuh cinta dengan aku. Dan Faliq\npulak masih dengan cintanya kepada aku. Arghhhhh! Sakit kepala."
  },
  {
    "no": 36,
    "author": "Zati Mohd",
    "title": "KAU YANG AKU MAHU",
    "genre": "Novel Melayu",
    "description": "Lagi lima tahun kita jumpa okay Eira.\"\nItu ayat terakhir dari Iqbal kekasih zaman sekolah aku. Dia janji untuk setia bila\npulang dari luar negara. Aku pegang kata-katanya.\nTahun pertama kami berhubung macam biasa, masuk beberapa bulan lepas tu kadang\nkadang saja kami berhubung. Dan akhirnya sepi tanpa berita aku yang beriya tunggu\ndepan komputer sambil on Skype.\nDari lima tahun melarat ke tujuh tahun dan akhirnya sepuluh tahun.. aku masih tak\ndapat mencari Iqbal. Facebook tak ada, instagram pun tak nampak rupa tapi Iqbal\nsentiasa aku sematkan dalam hati.\nHinggalah suatu hari, aku dapat job besar majlis pertunangan anak salah seorang ahli\nperniagaan terhebat di Malaysia. Kayla. Kayla bertunang dengan Iqbal.\nYe Iqbal kekasih aku yang aku tunggu lamaaaa gila tu. Amarah aku mencanak. Aku\ntunggu dia berpuluh tahun dia pulak sedap sedap bertunang dengan orang lain.\nAku rancang plan, Khai bukan Khai Bahar okay abang kepada Kayla dan kawan baik\nkepada Iqbal. Rancangan aku hanya nak sakitkan hati Iqbal tak guna tu.\nJadi apa aku buat? Aku mengorat Khai. Tapi mamat tu jual mahal. Hampir rosak plan\naku, aku bagitau aku suka dia, aku jatuh cinta pandang pertama dengan Khai. Bila\nKhai nampak aku dia lari, ah aku tak peduli aku ligan Khai. Runsing dia dengan aku.\nMungkin dia menyampah sampailah dia cakap..\n\"Kalau nak jatuh cinta.. jatuh cinta ajelah.. tak payahlah hari-hari datang sini.\" Khai\nmendengus kasar.\n\"Awak jadi boyfriend saya tau.\"\n\"Yelah..yelah pergi balik..\"\nDan Khai buat kerja sebagai boyfriend aku. Selalu aku cakap dengan diri sendiri \"Eira\nkau nak sakitkan hati Iqbal aje, jangan nak jatuh cinta dengan si Khai ni.\"\nTapi boleh ke aku tahan perasaan dari jatuh cinta dengan Khai? Ahhhhhh tidakkkkkk!"
  },
  {
    "no": 37,
    "author": "Zati Mohd",
    "title": "BUNGA ? BUNGA CINTA",
    "genre": "Novel Melayu",
    "description": "Kata orang anak perempuan adalah cinta pertama bapaknya. Tapi bukan aku. Sejak\numur aku lapan tahun. Mama dan abah bercerai. Punca abah dah jatuh cinta dengan\nwanita lain sebab mama terlalu sibuk. Sibuk dengan aktiviti yang bukan penting pun,\nsampai rumah tangga terabai.\nMasa tu aku diberi pilihan nak tinggal dengan siapa. Dan aku pilih tinggal dengan\ntokayah. Atok sebelah abah. Mama pulak lepas bercerai dia mula cari kebebasan.\nPergi tinggal dibandar besar.\nHidup aku sunyi tanpa kasih sayang mama dan abah. Masa umur aku sepuluh tahun,\nabah kahwin dengan makcik Sophea. Dan punya anak perempuan bernama Sara. Sakit\nhati aku bila abah balik dengan keluarga barunya, aku bagaikan tak wujud. Abah\nlebihkan Sara dan aku hanya melihat.\nSampai umur aku dua belas tahun, tokayah meninggal dan rumah tokayah abah jual\natas alasan faraid dan anak-anak tokayah semua nak duit.\nAku? Masih lagi tiada hala tuju. Tempat bergantung dah hilang. Tiada lagi rasa untuk\ndisayangai.\nAbah ambik aku duduk dengan dia. Tapi perasaan aku penuh dengan kebencian. Aku\nbagaikan hanya orang luar yang menumpang dirumah abah.\nSampai aku buat keputusan untuk ke asrama semasa umur aku tiga belas tahun. Dan\nmasa itu tak balik rumah langsung."
  },
  {
    "no": 38,
    "author": "Zati Mohd",
    "title": "BAHAGIA",
    "genre": "Novel Melayu",
    "description": "Mak abang tu kenapa ha? Bila balik jumpa dia aje suruh abang kahwin lain? Jangan\nsampai saya cari madu dekat mak abang tu.. saya kalau cakap saya buat..\" aku bagi\namaran tegas dekat suami aku.\nMak mentua pun kalau asyik suruh laki aku cari bini lain. Siapa tahan?\n\"Awak ni dengan mak pun nak gaduh.. orang tua memang macam tu.. janganlah\nlayan.\" Emir main main dengan remote tv.\n\"Habis yang abang tu pun takde function ke? Mak abang cakap apa diam je. Defend\nsikit bini abang ni. Ke abang suka kahwin lain? Haaa buat la kahwin lain.. abang\nkeluar sehelai sepinggang dari rumah ni. Boxer pun saya tak bagi bawak.. togel je\nkeluar rumah.\"\n\"Ya Allah ya tuhan.. tak ada pasai abang nak kahwin lain.. awak sorang pun dah\nserabut abang.\"\nHaaa tau pun bini sorang rasa serabut"
  },
  {
    "no": 39,
    "author": "Zati Mohd",
    "title": "HELLO MR CEO",
    "genre": "Novel Melayu",
    "description": "Apabila diupah menjadi pelakon untuk musnahkan hubungan antaran Eiman Rifqee\ndan Nisha. Aulia setuju. Kerja selesai bayaran pun dapat. Tapi Aulia lupa dia deal\ndengan salah orang.\nAulia Insyirah cari pasal dengan salah orang. Tak semena-semana Eiman pinang Aulia\nhanya kerana Aulia dah malukan dia.\n\"Lepas kau malukan aku.. kau buat semua family aku keliru pasal aku dah kahwin ke\nbelum. Kau nak blah macam tu je? Aku tak kira.. kau kena bertanggungjawab. Aku\nnak kita kahwin lagi dua bulan.\" Garang dan tegas nada Eiman.\n\"Eeee encik Eiman bukan mengandung pun nak suruh saya bertanggungjawab bagai..\nsaya ni ada masa depan tahu tak.. saya nak kerja, kumpul duit beli kereta pulak. Kalau\nsaya kahwin habis lah masa depan saya. Lagi pun encik Eiman ni siapa? Saya bukan\nkenal pun.\" Aku sandarkan badan dekat badan.\nTempoh tiga hari, habis macam tu aje tapi Aulia buat syarat.\n\"Pertama, saya tak nak duduk serumah dengan awak. Kedua, saya nak buat hal\nsendiri. Ketiga, lepas kahwin awak hal awak.. saya hal saya. Keempat awak boleh\nceraikan saya bila bila masa awak suka.\"\nEiman setuju. Apalah sangat setakat perjanjian entah apa-apa Aulia ni.\nAkhirnya mereka dinikahkan, tapi buat hal masing-masinglah. Tapi hati manusia itu\nTuhan yang pegang. Semakin hari semakin dekat dan mereka mulai mencintai satu\nsama lain.\nNamum dalam sesuatu hubungan ada pasang surutnya. Aulia salah faham.. Eiman\npulak masih dalam fasa tak reti nak pujuk bini.\n\"Kita cerai ajelah.\" Aku tahan air mata.\nEiman diam.\nApa keputusan Eiman? Nak pujuk Aulia dia takut.. nak lepaskan Aulia.. dia sayang\ngila gila punya. Nak buat apa ni?"
  },
  {
    "no": 40,
    "author": "Zati Mohd",
    "title": "KEKASIH LEBARAN",
    "genre": "Novel Melayu",
    "description": "Arash Zulkarnain terdesak, raya hampir tiba tapi dia masih dengan status bujang.\nGadis yang dia nampak adalah Dahlia. Ya Dahlia akaun executive yang mejanya tak\njauh mana dengan bilik Arash Zulkarnain.\nNurin Dahlia atau lebih mesra dengan panggilan Dahlia. Raya tahun ni pertama kali\ndia raya sendiri. Mama dan papa beraya di tanah suci, kakak dan abangnya masingmasing\nberaya di rumah mentua, boyfriend pulak tak balik Malaysia. Sendu betul\nrayanya tahun ni.\nPermintaan tak masuk akal buat Dahlia pening kepala dengan bos barunya. Dia diberi\ntugas, okay lebih tepat dia kena menyamar sebagai kekasih Arash Zulkarnain di hari\nlebaran selama tujuh hari.\nSemakin Dahlia menolak semakin kuat pujuk rayu Arash dan akhirnya Dahlia\nmengalah. Raya kedua dia dah menapak di Pulau Pinang.\n\"Nanti dekat rumah keluarga saya jangan nak panggil Encik Arash pulak. Panggil saya\nawak. Lagi best kalau panggil Bie atau sayang. Kalau nak nampak yakin panggil\nabang.\"\nAku kerutkan wajah. \"Bie? Sayang? Abang? Tak nak lah..\"\nDan kini tugas Dahlia bermula sebagai kekasih lebaran. Dia diperkenalkan dengan\nkeluarga Arash. Tapi itu bukan masalah besar tapi yang jadi lintang pukang bila..\n\"Ni cincin tanda.. maktok dah chup Dahlia jadi cucu menantu maktok.\"\nHalamak.. nak tak nak terpaksa Dahlia terima. Berlakon kan.\nTujuh hari meninggalkan kenangan manis dalam hidup Dahlia. Dan disitu dia nampak\nsweetnya seorang Arash Zulkarnain.\nTujuh hari tamat.. tapi Dahlia berat hati nak pulangkan cincin dekat Arash Zulkarnain.\n\"Nah cincin ni balik..\" aku letak cincin atas mejanya.\n\"Ada abang.. erk saya mintak pulangkan ke?\" Arash masih teruskan kerjanya tanpa\npedulikan aku.\nDahlia dalam dilema, tiba-tiba boyfriendnya muncul. Pening.. pening.. jadi apa\nkeputusan Dahlia?"
  },
  {
    "no": 41,
    "author": "Zati Mohd",
    "title": "TIKET KE NERAKA",
    "genre": "Novel Melayu",
    "description": "Bagi Azmi pekerjaannya yang sekarang adalah syubhah dan dengan senang hati dia\nberhenti kerja sebagai penjawat awam dan ingin memulakan business sendiri.\nIna terbeban, baru tiga bulan nikah suaminya dah berhenti kerja. Dah tu janji nak cari\nrumah sewa terpaksa pulak duduk dengan mentua.\nDari gaji yang sebelum ni cukup untuk diri Ina kini dah jadi tak cukup. Sehinggakan\nduit ansuran Coway yang Ina bayar untuk emaknya pun jadi isu bagi Azmi.\n\"Enam puluh lima ringgit Coway yang awak bayar bulan- bulan boleh simpan untuk\nanak kita nanti. Membazir saja.\"\nSetiap hari Azmi makan tidur makan tidur. Tak ada duit mintak bini. Sampaikan mak\nAzmi naik menyampah. Nak marah anak sendiri. Habis siapa tempat dia nak luahkan\nmarahnya kalau bukan Ina.\n\"Kau ingat tiga ratus yang kau bagi tu cukup ke? Bil elektrik saja pun dah dua ratus.\nTambah lagi. Takkan orang tua macam aku nak bela kau pulak!\"\nIna tak tahan hidup tertekan. Dari cakap baik-baik kini dia dah pandai naik suara dekat\nAzmi. Hormat? Dah makin hilang. Yang ada hanya rasa benci.."
  },
  {
    "no": 42,
    "author": "Zati Mohd",
    "title": "ATAS NAMA CINTA",
    "genre": "Novel Melayu",
    "description": "Menjadi saksi utama kes pembunuhan berprofile tinggi membuatkan hidup Yara rasa\ndiburu. Dia diberi pilihan tutup mulut atau mati.\nKerana mahu melindungi saksi. Ean Maleek terpaksa melindungi Yara untuk dua\nminggu. Kata sepakat dibuat, Yara ditempatkan di kampungnya sementara waktu.\nMenyamar jadi kekasih Ean Maleek untuk dua minggu? Nak selamat punya fasal dan\ntak ada cara lain Yara setuju. Dan akhirnya Yara tiba dikampung Ean.\nDua minggu di kampung, Yara selesa.. dari hidup di bandar dia mula belajar cara\nhidup seperti di kampung. Bagi Ean pulak Yara ada satu tarikan yang membuatkan dia\nmula tak senang duduk bila Yara tiada.\nHingga suatu hari, Yara diculik.. Ean cuak. Misi mencari Yara bermula. Dari hasil\nsiasatan Yara diculik oleh orang Tan Sri. Ean tekad kalau apa-apa jadi pada Yara dia\ntakkan maafkan dirinya."
  },
  {
    "no": 43,
    "author": "Zati Mohd",
    "title": "CINTA PERTAMA",
    "genre": "Novel Melayu",
    "description": "Kerana terikat dengan hubungan keluarga mereka menyatu. Mulanya Afiq Hadeef\ncakap nak lari pergi Manchester dan perkahwinan ini takkan terjadi tapi lain cerita bila\nAfiq Hadeef muncul masa akad nikah, dengan alasan pasport kena bawak sorok. Nak\ntak nak kena kahwin jugak.\nBagi Anis Farhana, tidak rasa cinta buat Afiq Hadeef membuatkan hidupnya biasa\nsaja. Tidur bilik asing asing. Hal hidup pun asing asing. Tapi kerana teringat dengan\nstatus dia mula anggap Afiq kawan baiknya. Kerana Afiq dah ada kekasih Anis tak\nmahu ganggu. Dah serupa perampas dia rasa.\nTapi kalau kekasih Afiq selalu mengelak dari jumpa, Anis jadi teman pengganti.\n\"Jom teman aku tengok wayang, awek aku last minit tak jadi pulak.\"\n\"Nak ikut aku hiking tak? Aku call awek aku tak angkat.\"\nTanpa sedar, Anis jatuh cinta. Layanan baik dari Afiq membuatkan hati wanitanya\ncepat cair. Namun kerana Anis tahu cintanya takkan terbalas. Dia simpan rasa itu.\nSuatu hari dia dikejutkan dengan khabar Afiq dah putus. Jadi kesempatan ini Anis\nambik atau biarkan saja?"
},
  {
    "no": 43,
    "author": "Zati Mohd",
    "title": "CINTA PERTAMA",
    "genre": "Novel Melayu",
    "description": "Kerana terikat dengan hubungan keluarga mereka menyatu. Mulanya Afiq Hadeef\ncakap nak lari pergi Manchester dan perkahwinan ini takkan terjadi tapi lain cerita bila\nAfiq Hadeef muncul masa akad nikah, dengan alasan pasport kena bawak sorok. Nak\ntak nak kena kahwin jugak.\nBagi Anis Farhana, tidak rasa cinta buat Afiq Hadeef membuatkan hidupnya biasa\nsaja. Tidur bilik asing asing. Hal hidup pun asing asing. Tapi kerana teringat dengan\nstatus dia mula anggap Afiq kawan baiknya. Kerana Afiq dah ada kekasih Anis tak\nmahu ganggu. Dah serupa perampas dia rasa.\nTapi kalau kekasih Afiq selalu mengelak dari jumpa, Anis jadi teman pengganti.\n\"Jom teman aku tengok wayang, awek aku last minit tak jadi pulak.\"\n\"Nak ikut aku hiking tak? Aku call awek aku tak angkat.\"\nTanpa sedar, Anis jatuh cinta. Layanan baik dari Afiq membuatkan hati wanitanya\ncepat cair. Namun kerana Anis tahu cintanya takkan terbalas. Dia simpan rasa itu.\nSuatu hari dia dikejutkan dengan khabar Afiq dah putus. Jadi kesempatan ini Anis\nambik atau biarkan saja?"
  },
  {
    "no": 44,
    "author": "Zati Mohd",
    "title": "PATAH HATI",
    "genre": "Novel Melayu",
    "description": "Patah hati Bella apabila mengetahui si kekasih hati bermain cinta dengan wanita lain\ndengan alasan wanita itu adalah pilihan emaknya. Dalam masa yang sama, teman baik\nBella iaitu Suraya mahu jodohkan Bella dengan abangnya. Dapatkah hati Bella yang\npatah itu dirawat semula?"
  },
  {
    "no": 45,
    "author": "Zati Mohd",
    "title": "TENTANG CINTA",
    "genre": "Novel Melayu",
    "description": "Detik pertemuan pertama mereka apabila Ben Ashriq menerima tugasan pertama, dia\ndiminta untuk menculik Nada Tarina anak kepada Tuan Rafour. Dan Nada menikmati\ndetik-detik penculikannya.\n\"Saya nak makan dalam sungai.\" Nada sengih.\n\"Dalam rumah ni ada meja makan yang kau nak makan dekat dalam sungai macam\ndalam instagram tu kenapa? Dah satu hal pulak aku nak melayan.\"\n\"Ehhh sedar sikit awak tu tengah culik saya tahu tak. Jadi awak kenalah ikut cakap\nsaya.\"\nPertemuan kedua, di sebuah kafe.\n\"Awak boleh tolong saya tak? Jadi suami saya. Saya tak kenal lelaki lain, saya kenal\nawak aje.\"\nHanya satu jalan untuk keluar dari rumah besar milik Tuan Rafour iaitu kahwin.\n\"Apa aku dapat kahwin dengan kau?\"\n\"Apa saja yang awak nak.\" Nada bagi kata putus.\nBagi Ben Ashriq ini peluangnya. Peluang untuk dia kenal rapat dengan Tuan Rafour.\nPerjanjian dipersetujui. Dan ini tentang cinta antara Ben Ashriq dan juga Nada Tarina.\nAntara cinta dan pergolakan hidup."
  },
  {
    "no": 46,
    "author": "Zati Mohd",
    "title": "SEKEPING HATI DIBAWA BERLARI",
    "genre": "Novel Melayu",
    "description": "Kerana trauma dengan kehidupan, Alyana pilih untuk terus membujang hingga tua.\nNamun siapa sangka diusia awal 30an dia dijodohkan dengan cucu kawan maktok.\nRaykal.\n\"Sorry apa nama kau tadi?\" Raykal pandang aku lama.\n\"Nurin Nealofa Fazura Anna Aishwarya Fatimah binti Abdul Kadir.\" Okay saja aku\ntipu nama aku.\nPuas menolak, puas merayu agar dia pilih jalan hidup sendiri. Maktok tetap mendesak.\nPilihan terakhir. Dia mintak Raykal pergi bawak diri ke mana-mana asalkan tak\nmuncul di hari pertunangan mereka.\nAlyana silap. Raykal tiba dengan sepersalinan baju melayu sedondon. Tampan hingga\nmenambat hati semua yg hadir. Kehadiran Raykal membuatkan Alyana menyampah.\n\"Kita bertunang ni syarat aje tau, lagi tiga bulan saya nak putuskan pertunangan kita.\"\nAku jungkit kening.\n\"Terserah. Aku follow the flow.\" Raykal masukkan kedua tangan di dalam poket\nseluar.\nFollow the flow yang tak berapa nak menjadi bilamana mereka sering dipertemukan\nbila maktok dan nenel Raykal buat rancangan.\n\"Yana dah cuba tapi tak boleh lah maktok, Yana nak putuskan pertunangan ni.\"\nTerpaksa aku jujur dengan maktok.\nMaktok diam.\nNamun setelah maktok pujuk, Alyana terpaksa menikahi Raykal. Lelaki yang dia\nhanya tahu nama. Umur berapa, kerja apa.. semua tak penting buat Alyana.\n\"Biar aku tolong kau hilangkan trauma tu, aku janji takkan duakan kau macam ayah\nkau buat dekat mak kau. Aku janji.\" Raykal senyum.\n\"Saya tak percaya.\" Susah untuk aku hilangkan rasa takut ni.\n\"Kalau aku berjaya robohkan tembok trauma kau apa aku dapat?\"\nRaykal mintak hadiah ke?\n\"Kau nak apa PS5? Holiday?\" Aku tanya dia.\nLaju dia geleng. \"Tu..\" dia letak jari telunjuk di dada aku. \"Hati kau.\"\n\"Kau nak hati aku buat apa? Jual?\" Muka aku dah merah tahan malu.\nNamun dalam membina kepercayaan Alyana kehadiran seseorang membuatkan\ntembok trauma kembali meninggi.\n\"Apasal tak cakap dia tu kekasih kau?\" Aku rasa nak lari balik rumah maktok\nsekarang.\nMampukah Raykal pecahkan tembok trauma yang dimiliki Alyana tentang kehidupan\nberumahtangga? Semuanya di dalam sekeping hati dibawa berlari."
  },
  {
    "no": 47,
    "author": "Zati Mohd",
    "title": "AKU BUKAN BONEKA",
    "genre": "Novel Melayu",
    "description": "Kata orang yang menjadi mangsa rumah tangga itu adalah wanita, namun mereka\nlupa.. lelaki juga sama..\nPerkahwinan yang diimpikan bahagia oleh Faris musnah apabila campur tangan\nkeluarga mentuanya. Segala apa yang dilakukan Faris segalanya di bantah.\n\"Abah nak kau tinggal dengan abah.. rumah kau tu bagi aje kaklong sewa.. kau duduk\nsini Faris.\"\n\"Anita kalau boleh abang.. Anita tak nak anak lagi tau.. Anita tak ready.\"\n\"Abangcik pinjam kereta kau.. pinjam sekejap aje.\"\n\"Kaklong tak cukup duit nak bayar sewa.. tangguh dulu ye.\"\nFaris terbeban. Antara dayus dan hormat. Antara cinta dan ambil kesempatan.\nAkhirnya dia memilih untuk pergi..\nNamun, pergi dari hidup Anita sekeluarga bukan juga membawa bahagia. Tapi dia\nterbeban dengan hutang. Dia di isyitiharkan bankrup. Faris tidak punya jalan kecuali\nsatu bunuh diri. Baginya itu adalah jalan penamat.\nNamun begitukah kesudahan kisah Faris atau mungkin ada sinar cahaya yang\nmembantu?"
  },
  {
    "no": 48,
    "author": "Zati Mohd",
    "title": "CINTA UNTUK MELODI",
    "genre": "Novel Melayu",
    "description": "Bukan menjadi anak kesayangan itu perit. Sejak umurnya 16 tahun, Melodi mula\nmembanting tulang empat kerat demi kelangsungan hidup.\nAda emak hanya sayangkan abangnya. Bila umur mula meningkat ke 18 tahun.\nMelodi dipaksa bekerja untuk menampung hidup ibu dan abangnya si biawak hidup.\nSetiap hari Melodi mengambil upah menjual nasi lemak, bihun goreng, mee goreng\nserta kuih muih untuk diletak di merata gerai. Manakala bila tiada kelas Melodi\nmengambil upah sebagai pembantu rumah separuh masa.\nAyden, kehidupan yang serba lengkap serta mendapat cukup kasih sayang menjadikan\nhidupnya sentiasa bahagia.\nHinggalah suatu ketika, takdir menemukan mereka. Melodi dan Ayden terpaksa\ndisatukan atas nama suami isteri.\nTiada cinta. Status perkahwinan mereka terpaksa dirahsiakan demi nama baik\nkeduanya di kampus tempat mereka belajar.\n\"Aku tak suka kau rapat dengan Taufik, kau isteri aku.\" -Ayden\n\"Apasal? Awak cemburu? Saya bercinta dengan Taufik masa semester 1 lagi. Saya tak\nnak awak menyibuk dalam hidup saya.\" -Melodi.\nTanpa sedar, hadir satu perasaan antara mereka. Cinta.\n\"Habis apa keputusan awak? Cerai? Awak nak ceraikan saya?\" - Melodi\n\"Aku ikut kau aje.\" - Ayden\nWujudkah perasaan cinta untuk Melodi dalam diri Ayden?"
  },
  {
    "no": 49,
    "author": "Zati Mohd",
    "title": "HEY MR CRUSH",
    "genre": "Novel Melayu",
    "description": "Adira Safeeya dah lama crush dengan Emir Rayyan sejak pertemuan pertama mereka\ndi rumah Adira Safeeya dua tahun lalu dan kebetulan sekarang ini mereka satu\nUniversiti, makin berbunga bunga rasa cinta Adira Safeeya buat Emir Rayyan.\nEmir Rayyan lelaki yang agak terkenal di Universiti. Dia kacak, budak bola sepak,\nbudak pandai dan menjadi kegilaan para gadis di universitinya.\n\"Kau ni memang crush sangat ke dekat Emir tu?\" Linda siku aku bila kami sama-sama\nlepak dekat cafe lepas habis kelas.\n\"Aku ni dah jatuh cinta tergolek-golek dekat dia tau.. setiap malam aku mesti mimpi\ndia.. tengok la tu.. dia minum pun handsome.\" Tak berkelip mata aku pandang Emir\nyang tengah lepak dengan kawan-kawan dia.\nHinggalah pada suatu hari. Kerana janji kedua orang tua mereka. Emir Rayyan dan\nAdira Safeeya ditunangkan. Emir menolak tapi Adira terima.\n\"Aku nak kita rahsiakan hal pertunangan kita..\" Emir Rayyan ketuk jarinya di atas\nmeja.\n\"Okay boleh aje.. saya tak kisah janji kita bertunang.\" Pucuk dicita ulam mendatang.\nRezeki jangan ditolak. Aku sengih.\nIni peluang untuk Adira Safeeya dekat dengan Mr Crushnya. Setiap hari dia ambil\npeluang untuk dekat dengan Emir.\nTanpa diduga.. Emir minta mereka putuskan pertunangan. Kerana dia tidak mencintai\nAdira Safeeya. Hubungan fake menjadikan Emir tidak selesa.\nLima tahun berlalu.. mereka bertemu semula.. dan kalini Emir yang mengejar Adira.\nMasihkan ada rasa cinta dalam diri Adira buat Mr Crush nya? Atau mungkin Adira\ntelah lama buang jauh jauh nama Emir."
  },
  {
    "no": 50,
    "author": "Zati Mohd",
    "title": "HEY MR BAD GUY",
    "genre": "Novel Melayu",
    "description": "Pertemuan yang tak dijangka.. pertama di Kay's cafe, kedua ketika di Viandra\nUniversiti.\nLily Qaisara - menjadi pelajar baru di Viandra Universiti taklah semudah yang dia\nsangka. Ada saja masalah bila terserempak dengan Qaiser Adrien.\nQaiser Adrien - Auranya luar biasa. Beku. Dingin. Namun sejak kemunculan Lily\nbagaikan satu magnet untuk dia terus memburu gadis itu.\nDan malam itu, segalanya merubah hidup Lily. Dia diculik hanya kerana Qaiser.\nKetika Lily dalam bahaya Qaiser hulurkan tangan.\n\"Be my wife. And i will take care the rest.\" - Qaiser\n\"Pardon?\" - Lily\nKerana tanggungjawab Qaiser menjaga Lily sepenuhnya tanpa mereka sedar ada cinta\nyang sedang mekar.\n\"Seronok nampak tergedik-gedik dengan si Laura tu.. dah lah pakai baju tak cukup\nkain. Terbuka sana terbuka sini. Yang awak tu pun bukan main lagi sedap mata\nmemandang.\" - Lily\n\"Jangan jatuh cinta dengan aku. Aku bukan lelaki yang baik.\" Qaiser\nSiapa Lily pada Qaiser? Dan siapa Qaiser yang sebenarnya?"
  },
  {
    "no": 51,
    "author": "Zati Mohd",
    "title": "BAHAGIAKU DERITAMU",
    "genre": "Novel Melayu",
    "description": "Apa anda rasa bila dituduh menyihir keluarga mentua sendiri?\nItulah yang terjadi pada Nisa. Dari mula dia berkahwin dengan Anuar ada saja yang\ntak kena. Demam sikit jumpa bomoh hinggakan semasa Nisa mengandung pun dia\nhampir dituduh dirogol jin hanya kerana hormon dia berubah.\nKeadaan semakin gila bilamana manusia lebih mempercayai benda lain selain Tuhan.\nNisa dituduh menyihir ibu mentuanya. Tanpa bukti yang munasabah. Nisa telah\ndiceraikan. Ipar duai dan biras semua menyokong tindakan Anuar.\nBukan saja Nisa malah seluruh keluarga Nisa pun dituduh bermain bomoh!\nNisa tekad melangkah pergi, dia harus bangkit semula. Wanita bukan lemah. Dia\nbangun untuk buktikan siapa Nisa sebenarnya. Anuar gila talak. Dia mahu Nisa\nsemula. Anuar janji untuk tidak mudah terpengaruh dengan keluarganya. Adakah Nisa\nakan menerima Anuar kembali?"
  },
  {
    "no": 52,
    "author": "Zati Mohd",
    "title": "SUJUD CINTA TERAKHIR",
    "genre": "Novel Melayu",
    "description": "Namaku Sofia. Perempuan simpanan kepada Farid yang bersatus suami orang. Farid\nyang penyayang dan Farid yang suka mengikuti segala kemahuan aku. Aku\ndimanjakan dengan wang ringgit dan harta benda. Rumah, kereta, Prada, LV, Dior\nminta saja semua Farid tunaikan. Dan lagi best bila Farid berjanji akan mengahwini\naku. Itu janjinya.\nPerjalanan yang aku rasa bukan 'level' aku untuk ke Aceh, mempertemukan aku\ndengan Ustaz Aiman salah seorang pelajar Malaysia di Aceh yang menjadi AJK dalam\nprogram Rentas Kasih anjuran Universiti aku. Pertama kali bertentang mata\ndengannya buat aku jadi gugup, berdebar.. entahlah ada daya tarikan dari seketul\nAiman. Wajahnya bersih senyumannya manis. Gempa bumi yang terjadi di Aceh\nmembuatkan aku melihat lebih dalam sisi seorang Aiman. Tanpa sedar aku jatuh cinta.\nAh gila!\nAku tekad nak tinggalkan Farid. Ketika aku buat keputusan ini. Diri aku viral. Gambar\naku disebarkan di media sosial sebagai tajuk utama 'babi penyondol' oleh isteri Farid.\nAku dihina, dicaci dan dimaki. Abah yang sememangnya membenci aku terus\nbertambah bencinya buat aku. Aku malu! Demi menebus harga diri aku, Farid akan\nmenikahi aku dan jadikan aku isteri kedua. Tapi aku tak cintakan Farid. Aku menolak.\nFarid mengugut aku. Jadi adakah aku harus menerima Farid atau tekad mencari\nAiman? Korang rasa?"
  },
  {
    "no": 53,
    "author": "Zati Mohd",
    "title": "IZINKAN AKU PERGI",
    "genre": "Novel Melayu",
    "description": "DIkala rumahtangga yang diimpikan bahagia hingga ke syurga hadir wanita lain\nmenjadi perosak. Kehadiran Milea di dalam rumahtangga Azura dan Haziq\nmenjadikan hidup Azura huru hara.\nDalam diam Haziq menjalinkan hubungan cinta dengan Milea, kerana Milea disahkan\nmengandung Haziq mengahwini Milea. Mereka bernikah di siam. Dalam terpaksa\nHaziq terpaksa memberitahu Azura kehadiran Milea.\n\"Sampai hati abang buat saya macam ni. Baru 2 tahun kita nikah abang.\" Aku tak\nmampu mengeluarkan lagi kata-kata.\nSungguh hati aku sakit. Sakit sangat.\n\"Abang minta maaf Zura. Kami dah terlanjur lagipun ni zuriat yang abang nak..\"\nHancur hati Azura. Ya kekurangan dirinya memberi kelebihan buat suami untuk\ncurang.\n\"Terima kasih kak izinkan Milea tumpang rumah akak sampai beranak. Milea janji tak\nkacau akak dan abang ya.\"\nJanji tinggal janji.. bila..\n\"Abang jom pergi makan Milea nak sangat makan Nandos\"\n\"Abang.. malam ni teman Milea erh.. baby nak cakap dengan papa dia.\"\n\"Abang.. tak sedaplah kak Zura masak.. eee bluerkkk.\"\nDan akhirnya Azura pasrah.. melangkah pergi bukan bermakna mengalah. Tapi\nmemberi peluang untuk diri sendiri di hargai.\nMembawa diri hingga ke Phuket. Mempertemukan Azura dan Kashaf.\n\"Saya Kashaf.. bujang, single dan kacak.\"\nMampukah si jejaka kacak ini merawat luka di hati Azura?"
  },
  {
    "no": 54,
    "author": "Zati Mohd",
    "title": "DIHATIMU BUKAN ADA AKU",
    "genre": "Novel Melayu",
    "description": "Salahkah untuk si isteri cemburu dengan birasnya sendiri bilamana si suami memberi\nperhatian sepenuhnya kepada isteri si adik?\nItulah yang terjadi pada Sha apabila suaminya E sering menghabiskan masa bersama\nisteri adiknya iaitu Zura. Bila ditegur..\n\"Itukan adik ipar saya apalah awak nak cemburu sangat.\"\n\"Kesian si Zura tu Que asyik kerja tak ada masa nak bawa dia keluar beli barang.\"\n\"Zura masakkan untuk saya.. dia panggil balik rumah mak.\"\nSha tak tahan bilamana perhatian yang seharusnya dia dapat beralih arah kepada Zura.\nSatu persatu masalah timbul bila munculnya si Zura ini dalam hidup Sha dan Ezzudin.\n\"Abang E belikan gelang ni katanya hadiah harijadi. Tapi tak adalah besar macam kak\nSha.\"\nNantikan.. DIHATIMU BUKAN ADA AKU"
  },
  {
    "no": 55,
    "author": "Zati Mohd",
    "title": "MY EVERYTHING",
    "genre": "Novel Melayu",
    "description": "Qayra anak kepada seorang tauke penyeludup senjata haram. Pada dasarnya Tuan\nAbdol adalah pemilik hotel lima bintang yang terkenal di negaranya namun disisi\ngelap dia adalah penyeludup senjata haram.\nQayra yang manis, cantik, bijak dan yang paling penting the sexy diva.. mendapat\ngelaran sebagai the party queen kerana tiap bulan gemar menganjurkan parti tapi\npartinya 'bersih' tiada arak dan seks.\nArjuna atau 'Mr President' orang terpenting kepada Tuan Abdol, rakan kongsi The\nAbdol Resort and Hotel dan sleeping partner untuk penyeludupan senjata haram.\nDalam masa yang sama 'body guard' kepada Qayra.\n\"Tu kau punya prince charming dah datang.\" Beberapa rakan yang lain dah tersengih\nmacam kerang busuk.\nQayra angkat kepala dan pandang wajah Arjuna yang serius gila tu.\nDalam samar-samar cahaya lampu di kelab malam ini pun dia dapat perhati wajah\nArjuna.\n\"Balik!\" Tangan Qayra di tarik oleh Arjuna.\n\"Tak nak lah!\" Qayra tegas, masih keraskan diri dekat atas kerusi.\n\"Balik sekarang Qayra, apahal degil sangat ni!\" Arjuna mendegus kasar.\nHinggalah suatu masa, mereka terpaksa di 'kuarantin' bersama. Kerana urusniaga\nsenjata haram dibatalkan dengan negara luar, maka Qayra menjadi sasaran.\n\"Ayah akan tempatkan Qayra dekat Abdol Resort di pulau Mantan bersama-sama\nArjuna.\"\n\"No way! Qayra tak nak stay dengan mamat ni. I hate him.\"\nMampukah Arjuna untuk menjaga keselamatan Qayra? Dan bagaimana pula dengan\nQayra bila 24 jam terpaksa menghadap wajah tampan si Arjuna. Segalanya akan\nterjawab dalam MY EVERYTHING."
  },
  {
    "no": 56,
    "author": "Zati Mohd",
    "title": "KETIKA AKU JATUH CINTA",
    "genre": "Novel Melayu",
    "description": "Apa rasa apabila pengantin lelaki tidak hadir di majlis pernikahan. Marah? Kecewa?\nDikhianati? Malu? Maruah tercalar?\nItulah yang dirasakan oleh Ammara apabila Faris tidak hadir ke majlis pernikahan\nmereka. Tanpa penjelasan Faris menghilangkan diri. Hanya sebuah mesej 'im sorry for\neverything' sebagai pengganti diri.\n8 tahun berlalu..\nKini Ammara dipertemukan kembali dengan Faris.\n\"Kenalkan ini bos baru awak.. Faris ni Ammara PA kamu.\"\nMenjadi PA kepada Faris membuatkan hidup Ammara kucar kacir. Bila dia sering\nmendesak Faris dengan sebuah penjelasan, Faris membalas dengan mendiamkan diri.\nTak habis rasa sakit hati terhadap Faris kini muncul Sakinah.. tunang Faris.\n\"Apa kata kalau awak yang tolong saya cari barang kahwin.. awak PA Faris kan?\nMesti dia bagi saya pinjam PA dia sekejap. Jom.\"\nDulu Faris meninggalkan Ammara di majlis pernikahannya kini, Ammara pulak\nmenjadi wedding planner tak bertauliah buat Faris.\n\"Awak masih cintakan saya kan?\" -Faris\n\"Hello.. saya dah move on okay.. apalah sangat tak jadi nikah dengan awak.\" -\nAmmara\n\"Faris tu cinta pertama saya. Saya sayangkan dia sangat-sangat.\" Sakinah\nMelepaskan Faris terlalu sukar untuk dilakukan. Namun melihat Faris bahagia adalah\ndendam dalam hidupnya.\nAmmara.. loving you like a losing game. Jadi jangan pernah mengalah bak kata\nbudak-budak PUBG 'Winner Winner Chicken Dinner'"
  },
  {
    "no": 57,
    "author": "Zati Mohd",
    "title": "THE BACHELOR",
    "genre": "Novel Melayu",
    "description": "Renata Illiyin - Dingin, dia punya dingin sebeku iceberg.\nHenry - Nakal, dia punya nakal sampai Renata pun meluat nak layan.\nMereka berdua bertemu dalam rancangan THE BACHELOR. Henry jejaka yang perlu\nmemilih si gadis untuk dijadikan pasangan hidup.\nMatanya tak lepas memandang Renata, gadis iceberg yang susah nak mesra dengan\nmana-mana jejaka termasuk dia.\n\"Awak ni lesbian erh?\"\nRenata yang tengah bersiap untuk photoshoot pusing 360 darjah.\n\"Ulang balik apa awak cakap tadi.. rasa macam saya ni pekak pulak.\"\nKejap! Aku tak salah dengarkan? Renata pandang tepat anak mata Henry macam nak\nmakan.\n\"Awak ni lesbian ke? L-e-s-b-i-a-n.\" Henry eja satu-satu perkataan lesbian tu.\nOmg! Anak siapa ni? Tolong ambik sebelum kena lempang.\n\"Apa sebab awak cakap saya lesbian?\" Renata peluk tubuh.\n\"Sebab awak tak layan lelaki. Nak senyum pun payah. Saya yang ulang alik depan\nawak, langsung awak tak kisah. Kalau perempuan lain rajin pulak tegur saya.\" Henry\ntarik kerusi duduk merapati Renata.\nRenata buat muka annoying.\n\"Saya bukan tergolong dalam perempuan macam tu. Lagipun harga diri saya terlalu\nmahal, Encik Henry yang kacak gila ni pun tak mampu nak beli saya.\" Renata senyum\ngaya mengejek.\n\"Really.. kalau saya mampu beli harga diri awak tu.. apa awak janjikan dekat saya?\"\nHenry dekatkan wajahnya pada Renata.\nAyatnya lembut dan perlahan.\n\"Saya janjikan seluruh hidup saya untuk Encik Henry.\" Renata kenyitkan matanya.\nHaaa nampak macam lesbian lagi ke? Kali ni kita guna watak playgirl. Biar Henry\njatuh tersungkur. Auch!\nNamun bila Henry dah jatuh cinta, dia ditinggalkan begitu saja. Gadis iceberg itu\nbenar-benar buat dia kecewa. Sedingin itukah hati Renata terhadap dia.\nBenarkan Renata tidak mencintai Henry? Dan adakah Henry akan melepas Renata\npergi begitu saja. Semuanya dalam THE BACHELOR."
  },
  {
    "no": 58,
    "author": "Zati Mohd",
    "title": "DIA KESAYANGAN DARIEN",
    "genre": "Novel Melayu",
    "description": "BERKAHWIN atas dasar cinta? Tak!\nBerkahwin atas dasar sayang? Tak!\nBerkahwin atas dasar paksaan? Ya!\nMalam pertama yang tak seindah orang lain. Aku Dikurung dirumah agam mewah\nmilik ahli keluarga Darien. Makan di hantar oleh pembantu rumah. Aku hanya\ndibenarkan menikmati angin segar hanya diri balkoni.\nDarien masuk bersama jaket kulit hitam dan berseluar jeans.\n?Sampai bila kau nak kurung aku Darien?? satu jelingan tajam menikam seluruh\nwajah Darien.\nKebencian yang makin membuak-buak. Kalau boleh aku bunuh Darien. Sudah pasti\ndah lama tubuh Darien aku tikam-tikam.\n?Sampai aku rasa bosan dengan kau.? Darien buka baju.\nAku pusing belakang apabila Darien buka seluar pula.\n?Perempuan lain semua gila nak tengok tubuh aku.. kau berpaling kenapa??\n?Tu perempuan lain. Bukan aku!?\n?Lambat laun kau mesti gilakan aku jugak.? Tubuh aku dipeluk dari belakang.\n?Pergi mampus!? Tangan Darien aku tolak kasar.\nMati hidup balik pun aku takkan jatuh cinta dengan kau!"
  },
  {
    "no": 59,
    "author": "Zati Mohd",
    "title": "TERUNA MISTERI",
    "genre": "Novel Melayu",
    "description": "Seorang writer yang nama pasaran dia \"teruna\" menjadi kegilaan para remaja dengan\nimej misteri, seksi, cool, hebat, gaya mutu keunggulan.\nTapi.. pada Qisha dia tak kisah wujud atau tak Teruna sebab dia memang tak minat\nmembaca. Teruna ke duda ke bujang trang tang tang lantak lah langsung dia tak kisah.\nTapi yang di kisah bilaaaa si Faizul curang dengan Killa pendek.\nEeeee.. rasa geram pulak bila rahsia curang Faizul dengan Killa pendek sampai dekat\ntelingan dia.\nMasa kesedihan Qisha melanda suatu hari di ruang pintu Qisha terdengar suara lelaki\nmenyanyi bersama petikan gitar. Siap lelaki tu menjerit lagi\n\"Jiran-jiran boleh request lagu apa nak..esok saya menyanyi untuk semua. Tapi tak\nboleh buka pintu ya. Letak tajuk lagu di depan pintu rumah anda\"\nQisha tertarik. Dia pun request lagu.. hahaha adoi.. suara lelaki tu buat Qisha cair.\nSampai suatu hari..\n\"Mama nak jodohkan Qisha dengan anak kawan mama dia baru balik dari London, dia\nkerja sana.. Qisha okey?\"\nHurm. Nak terima ke tak?"
  },
  {
    "no": 60,
    "author": "Zati Mohd",
    "title": "DEAR BESTFRIEND",
    "genre": "Novel Melayu",
    "description": "Crush dengan bestfriend sendiri? Itulah perasaan Carl ketika ini. Menyintai rakan\nbaiknya sendiri secara senyap-senyap. Bagi Nadine nak jatuh cinta dengan Carl itu\nmustahil.\nMelindungi, menyanyangi dan menjaga Nadine adalah tanggungjawab Carl. Namun\ntanpa sedar Nadine turut sama menyintai Carl dalam diam.\nMekarkah kisah cinta mereka?"
  },
  {
    "no": 61,
    "author": "Zati Mohd",
    "title": "DALAM SANGKAR CINTA",
    "genre": "Novel Melayu",
    "description": "Kerana cinta aku butakan semua apa yang Ikhwan buat. Tujuh tahun perkahwinan\nyang kadang kala bertelagah aku hanya anggap biasa. Hingga suatu hari, Ikhwan\nkantoi bermain cinta dengan kekasih lama.\n?Dia ex girlfriend abang, abang minta maaf.. hati abang masih ada pada dia.?\nAku terduduk, jatuh dan tersungkur. Inilah titik hidup aku yang paling teruk sekali.\n?Kalau macam tu ceraikan saya.? Aku bagi kata putus.\n?Tak.. abang takkan lepaskan sayang. Abang masih perlukan awak dan anak-anak.?\nTamak. Itu perangai Ikhwan, aku dia mahu.. perempuan itu pun dia mahu. Jujur hati\naku sakit. Hati aku tawar. Tujuh tahun yang aku korbankan hanyalah sia-sia."
  },
  {
    "no": 62,
    "author": "Zati Mohd",
    "title": "RETAK MENANTI BELAH",
    "genre": "Novel Melayu",
    "description": "Perkenalan hanya sebulan membawa dirinya ke alam perkahwinan. Setahun pertama,\nsemuanya indah namun bila masuk tahun kedua. Rumah tangganya sukar dikawal.\n?Jom kita pindah duduk rumah mak awak.? Azrul bersahaja dan nampak tenang.\n?Rumah yang awak beli ni kenapa? Kenapa nak pindah keluar pulak?? Aku tak puas\nhati.\n?Bapak dengan adik beradik saya nak tumpang duduk sini. Adik beradik saya lelaki,\ntakkan awak nak duduk dengan diorang. Sekejap aje. Dua minggu.?\nDalam terpaksa akhirnya aku reda. Melangkah keluar dari rumah sendiri hanya kerana\nuntuk keselesaan yang lain.\nMula kata dua minggu kini melarat ke dua bulan. Azrul pula dah tak bagi aku nafkah\nalasan adik beradiknya perlu di bantu.\nDuduk di rumah keluarga sendiri, sedikit sebanyak mula rasa menyusahkan.\n?Mak.. kaklong tak cukup duit nak bagi mak bulan ni. Sebab nak cover bayar hutang.?\nterpaksa aku tebalkan muka bagitahu mak.\n?Tak apalah kak long, apa mak makan.. kau makanlah. Mak tak boleh masak sedap\nsedap macam laki kau bersungut tu. Kita bukan orang senang.?\nAku telan air liur. Mak dengar?\nAtirah tak puas hati, dia mula mengungkap kebenaran. Rumah itu milik siapa\nsebenarnya? Kemana semua duit Azrul?"
  },
    {
    "no": 63,
    "author": "Zati Mohd",
    "title": "DIMATAMU AKU, DIHATIMU DIA",
    "genre": "Novel Melayu",
    "description": "Suhana mula curiga apabila suaminya Firdaus membelanjakan wang syarikat dengan\nbegitu mewah sekali. Bahkan Firdaus selalu travel atas urusan perniagaan.\nHinggalah suatu hari, Suhana mendapat tahu mengenai hubungan sulit suaminya\ndengan Amelia. Suhana memberi Firdaus pilihan. Antara keluarga ataupun Amelia.\nNamun, Firdaus tetap dengan keputusannya untuk memiliki keduanya.\nSuhana harus bijak. Strategi diatur. Dia akan musnahkan impian Firdaus untuk terus\nmemiliki dirinya. Firdaus harus membayar kebahagiaan dirinya yang telah hancur\nberkecai."
  },
  {
  "no": 64,
  "author": "Zati Mohd",
  "title": "HAQ ANAQI",
  "genre": "Novel Melayu",
  "description": "Kerana cinta ditolak oleh Lalisa.. Haq Anaqi tekad untuk buktikan pada wanita itu dia jugak mampu dicintai.. bahkan dia akan buktikan bahawa kekasihnya nanti akan dilayan bagaikan puteri. Pertemuannya dengan Nelysa Haura membuka peluang pada dirinya untuk menjadikan gadis itu sebagai pelakon utama drama yang bakal dia cipta. Kata sepakat dibuat.. bermula episod drama cinta arahan Haq Anaqi. Tanpa sedar muncul rasa cinta yang sebenar namun hati Haq menolak rasa itu. Hinggalah suatu hari, Lalisa membawa berita bahawa dia telah putus tunang dan meminta Haq untuk memberi peluang buat dirinya semula. Dan disitu tamatlah sudah drama cinta Haq dan Nelysa. Masing-masing membawa diri. Tapi bagi Haq melupakan Nelysa itu sukar. Antara Lalisa dan Nelysa Haura dia perlu memilih."
},
{
  "no": 65,
  "author": "Zati Mohd",
  "title": "NELYSA HAURA",
  "genre": "Novel Melayu",
  "description": "Macam mana rasa kalau boyfriend kita ada kawan baik perempuan lepastu berkepit 24 jam. Kadang-kadang kita pulak rasa macam perampas. Itulah rasa Nelysa Haura bila Haziq banyak berkepit dengan Erika aka best friend forever. Kerana tak sengaja terlanggar kereta AMG milik Haq Anaqi dia terperangkap dalam drama cinta lelaki itu. Terpaksa dia rahsiakan status kekasih lakonan Haq daripada pengetahuan Haziq. Saban hari bertemu Haq Anaqi sedikit sebanyak tercuit rasa dalam hati. Namun cepat saja dia menolak. Hingga suatu hari Haq Anaqi tamatkan drama antara mereka dengan alasan Lalisa sudah kembali kepada dirinya. Ada rasa terluka terhiris sedikit di dalam hati. Dapat pula berita Haziq ditangkap khalwat bersama Erika menambah lagi luka itu. Dari terhiris sedikit kini terbelah lagi. Nelysa membawa diri tapi jiwanya lebih terseksa bila memikirkan Haq Anaqi. Hinggalah dia dipertemukan kembali dengan Haq Anaqi."
},
{
  "no": 66,
  "author": "Zati Mohd",
  "title": "THE KINGDOM",
  "genre": "Novel Melayu",
  "description": "Hanya kerana mahukan tahta kerajaan Kingdom, Loth terpaksa turun ke bumi untuk mencari gadis perawan sebagai tahanannya. Dikenali sebagai the death angel panahan matanya mampu membunuh jiwa jiwa yang penuh rasa cinta. Grisella seorang gadis biasa, hidup di dalam kemiskinan kais pagi makan pagi, kais petang makan petang. Hidupnya hanya untuk si ibu yang sedang terlantar sakit. Hatinya penuh kasih sayang yang suci. Pertemuan pertama antara Loth dan Grisella, di pasar tani. Sedang Grisella membelek bunga ros putih tubuhnya di langgar dari belakang. Lelaki bertubuh tegap itu tidak pernah dia lihat. Namun pandangan pertama mula mengikat mereka. Pertemuan kedua, ketika bandar tempat Grisella tinggal mengadakan malam pesta ria semperna sambutan bulan cerah. Grisella duduk menatap bulan di pinggir sungai hingga dia terjumpa Loth terbaring penuh dengan kecederaan. Rasa kasihan yang mendalam Loth diberi rawatan. Dan Loth tawarkan Grisella untuk mengikutnya. Menjanjikan yang ibu Grisella akan sihat sepenuhnya. Grisella rela. Apa pun demi ibunya. Bermulalah detik di mana dua jiwa terikat dengan rasa cinta. Panahan mata Loth tidak mampu untuk membunuh jiwa Grisella yang sedang mencintai bahkan mampu untuk menambah lagi rasa cinta dalam dirinya. Siapakah sebenarnya Grisella buat Loth?"
},
{
  "no": 67,
  "author": "Zati Mohd",
  "title": "SEMALAM YANG HILANG",
  "genre": "Novel Melayu",
  "description": "Hidup ini ada dua antara hidup dan mati.. tapi tidak bagi Irdina dia di tengah-tengah hidup tidak mati pun tidak. Dia roh yang terkapai-kapai mencari arah jalan untuk dituju. Irdina, kemalangan ngeri yang menimpa dirinya menjadikan dia seperti sekarang. Roh yang setia di tepi jasad tanpa tahu haluan seterusnya. Airel, seorang detektif yang sedang menyiasat kes kemalangan waris tunggal Iris Jewellery. Tanpa diduga hanya dia seorang saja yang mampu melihat roh Irdina. \"Awak kena tolong saya.. saya nak balik ke dunia.. saya tak nak jadi macam ni. Awak kena siasat siapa yang nak saya mati.\" - Irdina. \"Kau boleh aje duduk dalam rumah ni mana-mana yang kau suka tapi bukan bilik aku.\" - Airel. Dengan adanya Irdina, sedikit demi sedikit kes kemalangan itu hampir terungkai. Hinggalah suatu kejadian. Dia tidak temui lagi roh Irdina. \"Bertahan, aku akan pastikan kau selamat Irdina. Aku tak izinkan kau mati.\" - Airel."
},
{
  "no": 68,
  "author": "Zati Mohd",
  "title": "SALAHKAH AKU",
  "genre": "Novel Melayu",
  "description": "Mulanya hadir dengan rasa ikhlas kini jadi satu bebanan dalam hidup Fina apabila dia yang kehulu kehilir menjaga keluarga mentuanya sedangkan yang lain hanya lepas tangan. Mak mentua yang panas baran. Bapak mentua pulak kuat mengadu apa saja Fina buat semua tak betul bukan itu saja siap tambah lagi cerita yang entah datang dari mana. Adik beradik ipar? Semua lepas tangan. Suami pula, tak habis-habis ayat \"minta tolong\". Sampai suatu hari Fina keguguran. Dia mengalami kemurungan yang teruk. Apa saja yang dia lakukan dimata keluarga mentuanya hanya keburukan. Hingga Khair termakan kata-kata mereka. Hinggalah suatu hari kehadiran Isaac membuka mata Fina bahawa dia sebenarnya dibuli. Mampukah Isaac membantu Fina keluar dari neraka dunia yang dicipta Khair dan keluarganya?"
},
{
  "no": 69,
  "author": "Zati Mohd",
  "title": "CINTA SAMPAI MATI",
  "genre": "Novel Melayu",
  "description": "Anda yang pernah membaca YANG MENCINTAIKU mesti kenal dengan Azri dan Ros. Jom baca kisah mereka di dalam Cinta Sampai Mati. Cinta pandang pertama mampu membawa kepada cinta pertama. Iya itu Azri rasakan saat matanya menatap sepasang mata bundar yang cantik milik Ros. Hatinya sudah terpikat namun kerana status Ros sebagai anak orang gaji, Azri takut cintanya ditolak. Lagipun Ros bukan tipikal gadis yang senang diayat. Lagi Azri mendekat lagi Ros menjauh. Hingga Azri tekad menyatakan rasa cintanya kepada Ros biarpun Ros akan menolak. Ros memang punya hati pada Azri tapi Ros buang jauh-jauh hanya kerana dia anak orang gaji. Pada Ros semakin dia menolak Azri semakin galak Azri mendekat. Dan Ros selalu sangat jatuh. Jatuh cinta. \"Kita tak boleh kahwin Azri. Awak anak orang kaya. Orang terkenal. Saya ni orang biasa aje. Kita memang tak layak bersama. Saya anak orang gaji. Kurang serba serbi.\" \"Ada saya kisah?\" Mampukah Azri yakinkan Ros tentang cintanya dan mampukah cinta mereka berkekalan?"
},
{
  "no": 70,
  "author": "Zati Mohd",
  "title": "ANGGAPLAH DIRIKU TAK PERNAH ADA",
  "genre": "Novel Melayu",
  "description": "Membuka pintu untuk rakan baik sendiri adalah satu kesalahan terbesar dalam hidup Lina. Kemunculan Azra pada lewat malam tu membawa malapetaka yang besar pada Lina. Suaminya digoda rakan baik sendiri. Mampukah Lina mempertahankan rumah tangganya bersama Yusof?"
},
{
  "no": 71,
  "author": "Zati Mohd",
  "title": "DAN CINTA INI",
  "genre": "Novel Melayu",
  "description": "Pernikahan Elnaura dan Lutfi a.k.a Luke ditentukan atas permintaan keluarga masing-masing. Bagi Luke pernikahannya dengan Elnaura seolah-olah memberi sinar untuknya mendapat hak di dalam Empires Group. Bagi Elnaura pula pernikahannya dengan Luke adalah jackpot untuk ayahnya melebarkan perniagaan di tanah Bali Indonesia. Dihadapan keluarga masing-masing mereka terpaksa tunjukkan kemesraan. Kerana setiap tingkah laku mereka diperhatikan. Namun kata orang tak kenal maka tak cinta. Setiap hari bersama membuka ruang cinta di hati mereka berdua. Percintaan yang mula dibina takkan terlepas dari ujian. Vincent Jeremy bekas kekasih Elnaura membuka rahsia tentang perjanjian pernikahan mereka. Elnaura terasa diperbodohkan. Hatinya hancur berkecai. Selamat tinggal Luke. Kemudian Luke kembali mencari Elnaura. Bagi Elnaura cintanya untuk Luke dah terkubur mati bersama cinta mereka yang dulu. Jadi Elnaura ni nak lagi ke dekat Luke?"
},
{
  "no": 72,
  "author": "Zati Mohd",
  "title": "HEY MR SWEET TALKER",
  "genre": "Novel Melayu",
  "description": "\"Tolong aku boleh?\" Nisa panjat atas katil. Aku yang tengah baca novel terus rasa terganggu. \"Kau nak apa perempuan?\" \"Esok tolong ambik pakcik aku dekat KLIA boleh?\" Nisa buat muka comel. Aku kerutkan wajah. Pakcik? Pakcik mana? Kisah persahabatan antara Nisa dan Maira yang seperti adik-beradik. Dari kisah tolong-menolong, susah senang bersama, hingga Maira akhirnya menjadi chef instagram popular dengan jualan cookies dan makanan viral — semuanya bermula dari usaha kecil dan dorongan sahabat baiknya. Sebuah kisah ringan, manis, penuh semangat dan sokongan."
},
{
  "no": 73,
  "author": "Zati Mohd",
  "title": "SESAL YANG TERLEWAT",
  "genre": "Novel Melayu",
  "description": "\"Saya Farhan Aziz bin Ahmad menceraikan Nur Alia binti Malik dengan talak satu.\" Tiga kali Farhan sebut talak satu. Bermakna jatuh talak tiga ke atas Alia, isterinya. Semuanya kerana mereka tidak memperolehi zuriat walaupun sudah 8 tahun berkahwin. Farhan mahu membina hidup baru dengan pilihan emaknya. Namun kuasa Allah menentukan sesuatu yang lain. Alia mengandung dua bulan. Tergamam Farhan. Tapi mahkamah sudah mengesahkan talak tiga. Tak mungkin kembali bersatu. Menyesal? Tiada gunanya. \"Lepas awak bersalin. Saya akan cari cina buta. Saya nak kita kahwin balik.\" Adakah Alia akan menerima semula Farhan?"
},
{
  "no": 74,
  "author": "Zati Mohd",
  "title": "SUAMI TANGKAP MUAT",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 75,
  "author": "Zati Mohd",
  "title": "WOLF",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 76,
  "author": "Zati Mohd",
  "title": "KINI... AKU CINTA PADAMU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 77,
  "author": "Zati Mohd",
  "title": "HANYA KAMU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 78,
  "author": "Zati Mohd",
  "title": "DI SAAT AKU TERSAKITI",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 79,
  "author": "Zati Mohd",
  "title": "WARKAH BERLAGU PILU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 80,
  "author": "Zati Mohd",
  "title": "PAKWE UPAHAN",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 81,
  "author": "Zati Mohd",
  "title": "AKULAH KEKASIHMU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 82,
  "author": "Zati Mohd",
  "title": "BUKAN YANG KETIGA",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 83,
  "author": "Dheya Wang",
  "title": "SUAMI KONTRAK UNTUK 33 HARI",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 84,
  "author": "Dheya Wang",
  "title": "TAN SRI ELZER EDRIS, SKANDEL UNTUK AKU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 85,
  "author": "Dheya Wang",
  "title": "GODAAN BEKAS ISTERI",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 86,
  "author": "Dheya Wang",
  "title": "DATO? SUGAR DADDY KEPUNYAAN AKU",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 87,
  "author": "Dheya Wang",
  "title": "ISTERI KONTRAK DATO? KAISEN EHSAN",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 88,
  "author": "Dheya Wang",
  "title": "TERKAHWIN ENCIK SOTONG?!",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 89,
  "author": "Dheya Wang",
  "title": "KU GODA KAU SAMPAI DAPAT",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 90,
  "author": "Fieyza Fadlina",
  "title": "PEMILIK HATI ZAYN ARYAN VOL1",
  "genre": "Novel Melayu",
  "description": ""
},
{
  "no": 91,
  "author": "Fieyza Fadlina",
  "title": "AMNA HANYA DAMBAKAN BAHAGIA",
  "genre": "Novel Melayu",
  "description": "Penyatuan ini bukan kehendak mereka. Kerana janji dua nenek, Ziyad dan Amna terikat dalam sebuah ikatan perkahwinan. Enam tahun, bukan satu tempoh yang singkat. Selama itu Ziyad dan Amna melayari rumah tangga yang suram dan tak berseri. Amna dengan hal sendiri, Ziyad dengan hidupnya. Kalau rasa nak balik rumah, Ziyad akan balik. Kalau tak, dia tak balik. Rezeki mereka dikurniakan sepasang cahaya mata. Ahmad Affan Ziqri , Nur Afeeya Zalfa Permata hati buat Amna. Namun layanan Ziyad sejak hari pertama perkahwinan buat Amna sentiasa sedar diri. Dia tidak diterima. Lalu talak diminta. Tapi takdir Tuhan, tiada siapa yang menidakkannya."
},
{
  "no": 92,
  "author": "Fieyza Fadlina",
  "title": "UMAR UNTUK AISYAH",
  "genre": "Novel Melayu",
  "description": "Umar Firdaus dan Zureen Aisyah. Pertemuan pertama kerana aturan kawan-kawan. Umar sudah 32 tahun masih tak kahwin-kahwin. Malangnya first date sudah kantoi dengan mami Zureen, Puan Malia. Terus mami cop Umar kekasih Zureen. Dari hubungan dingin akhirnya terpaksa kahwin. Saling tak kenal, mula renggang. Tapi selepas diuji jarak, mula ada rindu. Namun Umar tiba-tiba menjauhkan diri, alasan outstation berbulan-bulan. Adakah Umar ada orang lain?"
},
{
  "no": 93,
  "author": "Fieyza Fadlina",
  "title": "MR DUDA VS MISS CRUSH",
  "genre": "Novel Melayu",
  "description": "Miya Namiena dan Hazeem Al-Fateh dulu satu kelas tapi tak pernah berbual. Selepas 20 tahun, reunion menemukan mereka semula. Mereka jadi jiran, makin kerap bersua. Hazeem meminang tapi Namiena trauma dengan kisah lamanya. Tiba-tiba pada hari nikah, Namiena pula yang diakadkan tanpa dia tahu. Bermulalah konflik dengan bekas tunang, Viviane yang cemburu, dan Hazeem yang keras kepala."
},
{
  "no": 94,
  "author": "Fieyza Fadlina",
  "title": "BINGKISAN CINTA AYU AZZAHRA",
  "genre": "Novel Melayu",
  "description": "Dean Rifqie dan Ayu Azzahra bercinta, tapi ibu bapa Ayu menolak. Mereka kahwin tanpa restu, Ayu dihalau. Awal bahagia, tapi satu peristiwa buat Ayu lari. 7 tahun kemudian bertemu semula ketika Ayu bekerja sambilan. Dean terkejut Ayu ada anak lelaki bernama Afwa Rafique. Rahsia yang Ayu simpan mula terbongkar."
},
{
  "no": 95,
  "author": "Fieyza Fadlina",
  "title": "SYED MALEEQ DIA SUAMI AKU",
  "genre": "Novel Melayu",
  "description": "Irma Dariya dipaksa ibunya terima pinangan tanpa tahu siapa lelaki itu. Dia sangka lelaki tua, rupanya Syed Maleeq muda, kacak, dan bosnya sendiri. Bermula dengan salah faham, tapi Maleeq cuba mendekati isterinya. Dariya pula keras kepala dan cuba menolak rasa suka yang mula bercambah."
},
{
  "no": 96,
  "author": "Fieyza Fadlina",
  "title": "CINTA DI LADANG LEMBU",
  "genre": "Novel Melayu",
  "description": "Nazirah setuju dipinang dengan syarat tunangnya Aedy Saqeef bekerja di ladang keluarganya sebulan. Aedy yang biasa pejabat terpaksa belajar urus lembu kambing. Dalam tempoh itu mereka mula saling mengenal, timbul rasa sayang tapi ego dan status jadi penghalang."
},
{
  "no": 97,
  "author": "Fieyza Fadlina",
  "title": "SYAWAL TERINDAH ELHAQ",
  "genre": "Novel Melayu",
  "description": "Erisya bekerja sementara di rumah majikan. Anak majikan, Haliq Elhaq sombong tapi tiba-tiba mahu kahwin dengannya. Tanpa rela, Erisya dijadikan isteri. Hidup bersama penuh dugaan. Elhaq keras kepala tapi mula lembut bila kenal hati budi Erisya."
},
{
  "no": 98,
  "author": "Fieyza Fadlina",
  "title": "PILIHAN KEDUA AIDAN HAKEEM",
  "genre": "Novel Melayu",
  "description": "Sophia Adline dijadikan 'backup plan' oleh Aidan bila tunangnya kantoi khalwat. Terpaksa kahwin kerana maruah keluarga. Hubungan dingin tapi perlahan-lahan timbul rasa sayang. Ujian datang bila bekas tunang Aidan mahu rebut dia semula."
},
{
  "no": 99,
  "author": "Fieyza Fadlina",
  "title": "PEMILIK HATI ZAYN ARYAN VOL2",
  "genre": "Novel Melayu",
  "description": "Kisah sambungan cinta Zayn Aryan dan Jazmin Alaina yang sudah beranak dua. Cabaran mengurus anak kecil dan kerja. Kemunculan Sharon yang mahu ganggu rumah tangga mereka. Alaina marah tapi Zayn cuba selesaikan dengan sabar."
},
{
  "no": 100,
  "author": "Alyn",
  "title": "7 PENANTIAN",
  "genre": "Novel Melayu",
  "description": "Madir setia menunggu Zulaikha walaupun ditolak mentah. Selepas 7 tahun bertemu semula di perkhemahan. Ego Zulaikha tebal, tapi perasaan lama muncul semula. Dialog penuh emosi dan konflik jiwa."
}
];

Future<void> seedBooksToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  final ebooksCollection = firestore.collection('ebooks');

  for (final book in seedBooks) {
    final docRef = ebooksCollection.doc();
    batch.set(docRef, {
      ...book,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();
}
