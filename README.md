# VTYS-ODEv
1) TRANSACTION nedir?
- Veritabanı yönetim sistemlerinde (DBMS) bir veya birden fazla veritabanı işlem durumunun mantıksalbir bütün olarak ele alan yapıdır.

2) Örnek veritabanı üzerinde KİTAPLAR ve KİTAP_YAZAR tabloları üzerinde değişiklikler yapılmak isteniyor. Bu işlem için nasıl bir transaction tanımlanabilir?
-BEGIN TRANSACTION; -- Transaction başlatılır

BEGIN TRY
    -- 1. Tablo üzerinde değişiklik (Örn: KİTAPLAR tablosuna yeni kitap ekleme)
    INSERT INTO KİTAPLAR (KitapID, KitapAdi, YayinYili) 
    VALUES (101, 'Veritabanı Sistemleri', 2026);

    -- 2. Tablo üzerinde değişiklik (Örn: İlgili yazar bilgisini KİTAP_YAZAR tablosuna ekleme)
    INSERT INTO KİTAP_YAZAR (KitapID, YazarID) 
    VALUES (101, 5);

    -- Her iki işlem de başarılı olursa değişiklikler kalıcılaştırılır
    COMMIT TRANSACTION; 
    PRINT 'İşlem başarıyla tamamlandı ve kaydedildi.';
END TRY
BEGIN CATCH
    -- Herhangi bir hata oluşursa yapılan tüm değişiklikler geri alınır
    ROLLBACK TRANSACTION; 
    PRINT 'Hata oluştu, tüm işlemler geri alındı (Rollback).';
END CATCH;

3) Transaction ile veri kurtarma ve yedekleme/geri yükleme arasında nasıl bir ilişki olduğunu araştırınız.
- Kurtarma İlişkisi: veritabanı yeniden başlatıldığında ARIES benzeri kurtarma algoritmaları çalışır. Bu aşamada transaction log'lar taranır.Yedekleme (Backup) ve geri yükleme (Restore): olası büyük sistem çökmelerinde (donanım arızası, afet vb.) sistemi o ana döndürmeyi amaçlar.

4) Bir transaction içerisinde savepoint'ler oluşturulur ve transaction işlemi ROLLBACK ile sonlandırılırsa oluşturulan savepoint'lerin bir önemi var mıdır?
- Hayır, yoktur.ROLLBACK komutu transaction'ın en başına dönülmesini sağlar ve o ana kadar yapılan tüm geçici değişiklikleri iptal eder.

5) Bir transaction içerisindeki savepoint'ler COMMIT savepoint ile veritabanına yansıtılır ve transaction ROLLBACK ile sonlanırsa yapılan değişiklikler veritabanına yansıtılır mı?
-Hayır, yansıtılmaz. Transaction'ı onaylayan tek komut COMMIT

BEGIN TRANSACTION
UPDATE KITAPLAR SET s_sayisi=0
UPDATE KITAPLAR SET kitap_adi='Deneme'
SELECT * FROM KITAPLAR
ROLLBACK

BEGIN TRANSACTION
SAVE TRANSACTION deneme
UPDATE KITAPLAR SET s_sayisi=0
SELECT * FROM KITAPLAR
ROLLBACK TRANSACTION deneme
SELECT * FROM KITAPLAR
UPDATE KITAPLAR SET kitap_adi='Deneme'
SELECT * FROM KITAPLAR
ROLLBACK
SELECT * FROM KITAPLAR

-- Sayısal değişken
DECLARE @Sayi INT

-- Karakter değişken
DECLARE @Karakter VARCHAR(20)

-- Tek satırda birden fazla değişken
DECLARE @Deger1 INT, @deger2 VARCHAR(20)

-- SET ile sabit veya değişken bazlı atama
DECLARE @sayi1 INT, @sayi2 INT, @toplam INT
SET @sayi1 = 10
SET @sayi2 = 15
SET @toplam = @sayi1 + @sayi2

-- SELECT ile veritabanından sorgu sonucu değer atama
DECLARE @enyuksekmaas MONEY
SELECT @enyuksekmaas = MAX(maas) FROM personel

-- SELECT ile sabit değer atama
DECLARE @enyuksekmaas MONEY
SELECT @enyuksekmaas = 1500

DECLARE @maxsayfa INT
SELECT @maxsayfa = MAX(s_sayisi) FROM KITAPLAR
SELECT @maxsayfa AS "Max Sayfa Sayısı"

DECLARE @maxsayfa INT
SELECT @maxsayfa = MAX(s_sayisi) FROM KITAPLAR
SELECT @maxsayfa AS "Max Sayfa Sayısı"



DECLARE @Deger INT
SET @Deger = 15
GO
SELECT @Deger -- Bu satır hata verir (değer yığın dışında kalmıştır)

-- Veritabanı seçimi
USE kutuphane

-- PRINT ve SELECT çıktı farkı
SELECT 'Deneme Mesajı'
PRINT 'Deneme Mesajı

DECLARE @Deger1 INT, @deger2 INT, @toplam INT
SET @Deger1 = 125
SET @deger2 = 56
SET @toplam = @Deger1 + @deger2

PRINT 'Toplam Sonucu'
PRINT @toplam

-- Tablo tipi değişken tanımlama ve veri ekleme
DECLARE @personel TABLE(
no INT IDENTITY(1,1),
adsoyad VARCHAR(50) NOT NULL,
telefon VARCHAR(15)
)

INSERT INTO @personel VALUES('Turgut Özseven', '35612')
INSERT INTO @personel VALUES('Ahmet Kaçar', '35613')

SELECT * FROM @personel ORDER BY adsoyad

--INSERT Operasyonunda OUTPUT:
DECLARE @eklenenler TABLE(
ad VARCHAR(20),
soyad VARCHAR(20),
maas MONEY
)

INSERT INTO personel
OUTPUT INSERTED.ad, INSERTED.soyad, INSERTED.maas
INTO @eklenenler
VALUES ('33', 'Turgut', 'Özseven', '', 1500, '', '')

SELECT * FROM @eklenenler

--DELETE Operasyonunda OUTPUT:
DECLARE @silinenler TABLE(
ad VARCHAR(20),
soyad VARCHAR(20),
maas MONEY
)

DELETE FROM personel
OUTPUT DELETED.ad, DELETED.soyad, DELETED.maas
INTO @silinenler
WHERE maas < 1300

SELECT * FROM @silinenler

-- EXISTS ile koşul kontrolü
IF EXISTS (SELECT * FROM personel WHERE maas > 2000)
PRINT 'Maaşı 2000 den fazla olan personel var.'

-- MIN maaş kontrolü
IF (SELECT MIN(maas) FROM personel) >= 1500
PRINT 'Maaşı 1500 den küçük olan personel yok.'
ELSE
SELECT ad, soyad, maas FROM personel WHERE maas < 1500

-Cinsiyet Dönüşümü
USE personel
GO
SELECT ad, soyad, gorev, cinsiyet =
CASE cinsiyet
WHEN 1 THEN 'Erkek'
WHEN 0 THEN 'Bayan'
END
FROM personel
GO

--Notları 5'lik Sisteme Çevirme
USE okul
GO
SELECT ogr_no, ders, notu, 'notu' =
CASE
WHEN notu > 84 THEN 5
WHEN notu > 69 AND notu < 85 THEN 4
WHEN notu > 54 AND notu < 70 THEN 3
WHEN notu > 44 AND notu < 55 THEN 2
WHEN notu > 24 AND notu < 45 THEN 1
ELSE 0
END
FROM ogr_notlar
GO


--Sayıların Karesini Alma
DECLARE @sayac INT
SET @sayac = 1
WHILE @sayac <= 5
BEGIN
PRINT CAST(@sayac AS varchar(10)) + ' karesi : ' + CAST(@sayac * @sayac AS varchar(10))
SET @sayac = @sayac + 1
END

--Ortalama Maaşa Göre Zam Yapma
SELECT 'Ortalama Maaş = ' + CAST(AVG(maas) AS varchar(20)) FROM personel

WHILE (SELECT AVG(maas) FROM personel) < 3000
BEGIN
UPDATE personel SET maas = maas * 20 / 100 + maas
SELECT ad + ' ' + soyad, maas FROM personel
END

SELECT 'Son Ortalama Maaş = ' + CAST(AVG(maas) AS varchar(20)) FROM personel

--CONTINUE Örneği (3 Değerini Atlatma)
DECLARE @sayac INT
SET @sayac = 1
WHILE @sayac <= 5
BEGIN
IF @sayac = 3
BEGIN
SET @sayac = @sayac + 1
CONTINUE
END
PRINT CAST(@sayac AS varchar(10)) + ' karesi : ' + CAST(@sayac * @sayac AS varchar(10))
SET @sayac = @sayac + 1
END

--BREAK Örneği (Ortalama Düşürme ve Limit Kontrolü)
SELECT 'Ortalama Maaş = ' + CAST(AVG(maas) AS varchar(20)) FROM personel

WHILE (SELECT AVG(maas) FROM personel) > 2000
BEGIN
UPDATE personel SET maas = maas - maas * 20 / 100
SELECT ad + ' ' + soyad, maas FROM personel
IF (SELECT MAX(maas) FROM personel) <= 2500
BREAK
END

SELECT 'Son Ortalama Maaş ' + CAST(AVG(maas) AS varchar(20)) FROM personel


DECLARE @sayac SMALLINT
SET @sayac = 1

yenile:
PRINT 'Sayaç değeri : ' + CAST(@sayac AS varchar(1))
SET @sayac = @sayac + 1

WHILE @sayac <= 4
GOTO yenile

--RETURN Örneği:
DECLARE @Deger INT
DECLARE @deger2 INT
SET @deger2 = 123

IF @Deger IS NULL
BEGIN
PRINT 'deger Değişkeni NULL'
RETURN
END
ELSE
BEGIN
PRINT @Deger
END

IF @deger2 IS NOT NULL
PRINT @deger2

--WAITFOR Örneği
-- 10 saniye bekledikten sonra sorguyu çalıştırır
WAITFOR DELAY '00:00:10'
SELECT * FROM personel

--Sıfıra Bölme Hatasını Yakalama
BEGIN TRY
SELECT 1/0
END TRY
BEGIN CATCH
SELECT
ERROR_NUMBER() AS Hata_No,
ERROR_SEVERITY() AS Öncelik,
ERROR_LINE() AS Hata_Satırı,
ERROR_MESSAGE() AS Hata_Mesajı
END CATCH

--İlişkili Tablo Silme Hata Denetimi Uygulaması
-- 1. Tabloların oluşturulması
CREATE TABLE urunler(
urun_no INT NOT NULL,
ad NVARCHAR(10),
CONSTRAINT PK_urunler PRIMARY KEY (urun_no)
)

CREATE TABLE fiyat(
urun_no INT NULL,
fiyat MONEY NULL
)

-- 2. İlişkinin kurulması
ALTER TABLE fiyat WITH CHECK
ADD CONSTRAINT FK_fiyat_urunler FOREIGN KEY(urun_no)
REFERENCES urunler (urun_no)

-- 3. TRY...CATCH ile silme kontrolü
BEGIN TRY
DECLARE @urunno VARCHAR(20)
SET @urunno = 3
DELETE FROM urunler WHERE urun_no = @urunno
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 547
PRINT 'Öncelikle ' + @urunno + ' nolu ürünün fiyat bilgisini silin'
ELSE
PRINT ERROR_NUMBER()
END CATCH


BEGIN TRY
BEGIN TRANSACTION
BEGIN TRY
BEGIN TRANSACTION
SAVE TRANSACTION baslangic
UPDATE KITAPLAR SET s_sayisi = 0
COMMIT
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION baslangic
PRINT 'Hata 1.Güncellemede ' + ERROR_MESSAGE()
END CATCH

UPDATE KITAPLAR SET kitap_adi = 'Deneme'
COMMIT
END TRY
BEGIN CATCH
ROLLBACK
PRINT 'Hata 2.Güncellemede ' + ERROR_MESSAGE()
END CATCH

-- Yöntem 1: Doğrudan Değişkenle Birleştirip Çalıştırma
DECLARE @tablo VARCHAR(20)
SET @tablo = 'KITAPLAR'
EXECUTE('SELECT * FROM ' + @tablo)

-- Yöntem 2: Sorgu Metnini Ayrı Değişkende Oluşturup Çalıştırma
DECLARE @tablo VARCHAR(20)
DECLARE @Sorgu VARCHAR(MAX)
SET @tablo = 'KITAPLAR'
SET @Sorgu = 'SELECT * FROM ' + @tablo
EXECUTE(@Sorgu)


