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
