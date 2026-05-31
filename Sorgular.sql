-- 1. Turgut Özseven’e satılan aracın aynısından başka hangi müşterilere satıldığını bulmak için kullanılacak SQL ifadesiniz yazınız.
SELECT * FROM Musteri 
WHERE Mno IN (
    SELECT Mno 
    FROM Satis 
    WHERE Aracno IN (
        SELECT Aracno 
        FROM Satis 
        WHERE Mno = (SELECT Mno FROM Musteri WHERE Madi = 'Turgut' AND Msoyadi = 'Özseven')
    )
) AND Mno <> (SELECT Mno FROM Musteri WHERE Madi = 'Turgut' AND Msoyadi = 'Özseven');

-- 2. Satış yapılan araçların bilgilerini listelemek için gerekli SQL ifadesiniz yazınız.
SELECT * FROM Arac 
WHERE Aracno IN (SELECT DISTINCT Aracno FROM Satis);

-- 3. Satış tutarı alım tutarından düşük olan araçları listelemek için gerekli SQL ifadesini yazınız.
SELECT * FROM Arac 
WHERE Aracno IN (
    SELECT s.Aracno 
    FROM Satis s
    INNER JOIN Alim a ON s.Aracno = a.Aracno
    WHERE s.Sfiyat < a.Afiyat
);

-- 4. Opel marka araç yapılan satışların ve alımların hangi müşterilerle yapıldığını bulmak için gerekli SQL ifadesini yazınız.
SELECT * FROM Musteri 
WHERE Mno IN (
    SELECT Mno FROM Satis WHERE Aracno IN (SELECT Aracno FROM Arac WHERE Marka LIKE '%Opel%')
    UNION
    SELECT Mno FROM Alim WHERE Aracno IN (SELECT Aracno FROM Arac WHERE Marka LIKE '%Opel%')
);

-- 5. Araç fiyatı 20000 den yüksek olan araçların hangi fiyata satıldığını bulmak için gerekli SQL ifadesiniz yazınız.
SELECT Aracno, Sfiyat 
FROM Satis 
WHERE Aracno IN (SELECT Aracno FROM Arac WHERE Fiyat > 20000);

-- 6. Turhal ve Amasya’ya yapılan satışların toplam tutarını azalan sırada listelemek için gerekli SQL ifadesiniz yazınız.
SELECT m.Madres, SUM(s.Sfiyat) AS ToplamTutar
FROM Satis s
INNER JOIN Musteri m ON s.Mno = m.Mno
WHERE m.Madres LIKE '%Turhal%' OR m.Madres LIKE '%Amasya%'
GROUP BY m.Madres
ORDER BY ToplamTutar DESC;

-- 7. Satış veya alım yapılmayan müşterilerin bilgilerini listelemek için gerekli SQL ifadesiniz yazınız.
SELECT * FROM Musteri 
WHERE Mno NOT IN (SELECT DISTINCT Mno FROM Satis)
  AND Mno NOT IN (SELECT DISTINCT Mno FROM Alim);

-- 8. 5.ve 6. Ayda yapılan satışların kimlere yapıldığını bulmak için gerekli SQL ifadesiniz yazınız.
SELECT * FROM Musteri 
WHERE Mno IN (
    SELECT Mno 
    FROM Satis 
    WHERE MONTH(STR_TO_DATE(Sat_tarih, '%d.%m.%Y')) IN (5, 6) -- Eğer tarih formatı string ise standarda çevirmek için
       OR MONTH(Sat_tarih) IN (5, 6) -- Standart Date tipi için
);

-- 9. Aynı marka araç alan müşterileri ve aldığı araç markasını listelemek için gerekli SQL ifadesiniz yazınız.
SELECT m.Madi, m.Msoyadi, a.Marka
FROM Alim al
INNER JOIN Musteri m ON al.Mno = m.Mno
INNER JOIN Arac a ON al.Aracno = a.Aracno
WHERE a.Marka IN (
    SELECT a2.Marka 
    FROM Alim al2
    INNER JOIN Arac a2 ON al2.Aracno = a2.Aracno
    GROUP BY a2.Marka
    HAVING COUNT(DISTINCT al2.Mno) > 1
);

-- 10. En yüksek fiyata satılan aracın marka, fiyat ve kime satıldığı bilgisini listelemek için gerekli SQL ifadesiniz yazınız.
SELECT a.Marka, s.Sfiyat, m.Madi, m.Msoyadi
FROM Satis s
INNER JOIN Arac a ON s.Aracno = a.Aracno
INNER JOIN Musteri m ON s.Mno = m.Mno
WHERE s.Sfiyat = (SELECT MAX(Sfiyat) FROM Satis);
