-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Računalo: localhost
-- Vrijeme generiranja: Lip 13, 2014 u 04:09 PM
-- Verzija poslužitelja: 5.5.35
-- PHP verzija: 5.5.10-1~dotdeb.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza podataka: `mts2`
--

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_categories`
--

CREATE TABLE IF NOT EXISTS `s2_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_title` varchar(255) NOT NULL,
  `category_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Izbacivanje podataka za tablicu `s2_categories`
--

INSERT INTO `s2_categories` (`category_id`, `category_title`, `category_desc`) VALUES
(1, 'Kultura', 'Upoznajte hrvatsku prošlost i istražite bogatstvo njezine kulturno-povijesne baštine.'),
(2, 'Priroda', 'Upoznajte hrvatske nacionalne parkove i parkove prirode.'),
(3, 'Sport', 'Za one koji žele aktivniji godišnji odmor, postoje brojne mogućnosti za sportske i rekreacijske aktivnosti u Hrvatskoj');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_comments`
--

CREATE TABLE IF NOT EXISTS `s2_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_lid` int(11) NOT NULL,
  `comment_author` int(11) NOT NULL,
  `comment_text` text NOT NULL,
  `comment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`),
  KEY `comment_location_idx` (`comment_lid`),
  KEY `comment_authorid_idx` (`comment_author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_locations`
--

CREATE TABLE IF NOT EXISTS `s2_locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) NOT NULL,
  `location_desc` varchar(255) DEFAULT NULL,
  `location_text` text NOT NULL,
  `location_cat` int(11) NOT NULL,
  `location_author` int(11) NOT NULL,
  `location_rating` float(3,2) DEFAULT '0.00',
  `location_image` varchar(255) DEFAULT NULL,
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `page_id_UNIQUE` (`location_id`),
  KEY `location_owner_idx` (`location_author`),
  KEY `location_category_idx` (`location_cat`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Izbacivanje podataka za tablicu `s2_locations`
--

INSERT INTO `s2_locations` (`location_id`, `location_name`, `location_desc`, `location_text`, `location_cat`, `location_author`, `location_rating`, `location_image`, `location_lat`, `location_lng`) VALUES
(1, 'Dubrovnik', 'Grad jedinstvene političke i kulturne povijesti, svjetski poznate spomenične baštine i ljepote.', 'Dubrovnik, grad je na samom jugu Hrvatske i Dalmacije. Dubrovnik je grad jedinstvene političke i kulturne povijesti, , svjetski poznate spomenične baštine i ljepote, te jedan od najatraktivnijih i najpoznatijih gradova Sredozemlja. Bijeli grad u kamenu opasan gotovo 2km dugačkim dubrovačkim zidinama, kulama, tornjevima, podijeljen Stradunom (glavna ulica u Dubrovniku), a štiti ga Sv.Vlaho, glavni zaštitnik Dubrovnika i UNESCO. Dubrovnik je grad, koji je dugo vremena kroz povijest zadržao neovisnost kao pomorska republika. Osim zidina za to je zaslužna i tvrđava Ravelin iz XVI st., danas multifunkcionalni kulturni centar u Dubrovniku. Svake se godine u Dubrovniku održavaju Dubrovačke ljetne igre. Posjetiti svakako valja Dubrovački muzej, gdje je i pomorski i etnografski muzej. Dubrovnik je grad prelijepih šljunčanih plaža ali i divljih južno dalmatinskih grebena i grad koji Vas sigurno neće ostaviti ravnodušnim. ', 1, 1, 0.00, '/uploads/1-1.jpg', '42.65000000', '18.08333300'),
(2, 'Poreč', 'Jedan od istarskih gradića duge povijesti', '                Poreč, još jedan od istarskih gradića duge povijesti, točnije 2000 godina, smjestio se na zapadnoj obali Istre, između rijeke Mirne na sjeveru i Vrsara na jugu, točnije u jednoj uvali prirodno zaštićenoj nasuprotnim otokom Sv.Nikola. Sam grad još uvijek njeguje rimsku ostavštinu, a najvažnije ulice castrum Poreča, Dekumanova i ulica Karda Maximusa, konzervirane su i sačuvane u izvornom obliku, ali ne i sadržaju, gdje danas ipak prevladava turistička ponuda, koja je dobila svoj snažniji zamah 70-ih godina prošlog stoljeća. Od bogate gotičke i barokne ostavštine, najvažnija je Eufrazijeva Bazilika iz V st., a koja je zaštićena i od strane UNESCO-a 1997. godine.  Stari je grad sačuvao raspored ulica starorimskog castruma. Glavne su ulice Dekumanus i Cardo Maximus još sačuvane u izvornom drevnom obliku. Marafor je bio rimski trg (forum) s dva hrama. Jedan od njih, podignut u 1. stoljeću, posvećen je rimskom bogu Neptunu, širok je 30 m, a dug 11 m. Sačuvano je par kuća iz romaničkog razdoblja (Romanička kuća na Maraforu), kao i nekoliko divnih mletačkih gotičkih palača. Istarska sabornica, izvorno franjevačka gotička crkva iz 13. stoljeća, preuređena je u baroknom stilu u 18. stoljeću. Kompleks Eufrazijeve bazilike iz 5. stoljeća, koji je na mjestu izvorne crkve prvi put proširen u 6. stoljeću pod Bizantom i biskupom Eufrazijem, predstavlja najvažniji i najvrjedniji kulturni spomenik Poreča, a UNESCO ju je 1997. zaštitio kao spomenik svjetske baštine. Grad je bio opasan obrambenim zidinama od 12. do 19. stoljeća.Bogat turističkom tradicijom, Poreč nudi obilje turističkih sadržaja i raznovrsnost turističkih smještaja. Najveći smještajni kapaciteti Poreča, hoteli, apartmani i bungalovi, razvili su se oko dviju najljepših uvala, Plavoj i Zelenoj Laguni, gdje je i koncentriran najveći dio sadržaja vezanih za morske radosti kao što su kupanje, izležavanje na pijesku, ispijanje napitaka u beach barovima, skijanje na vodi, ronjenje, surfanje, izleti brodicama i sl. Za gurmane, Poreč ima izuzetnu ponudu koja ide od ribljih restorana, konoba, pizzeria i sl., a za one koji traže i noćni provod tu je i više noćnih lokala, disco barova itd. Za izletnike tu je i jama Baderine, koju je svakako vrijedno pogledati, te Limski kanal.               ', 1, 1, 0.00, '/uploads/1-2.jpg', '45.22597200', '13.59925000'),
(3, 'Rab', 'Čisto i bistro more, sugestivna priroda, te gostoprimstvo stanovnika otoka Raba prepoznatljiva su obilježja.', '                Otok Rab smješten je u Kvarnerskom zaljevu između otoka Krka na sjeverozapadu i otoka Paga na jugoistoku. Na otoku Rabu nekoliko je manjih mjesta, koja su uglavnom smještena ne njegovoj južnoj strani. To zbog toga što je sjeverni dio otoka izložen buri, dok je dio okrenut na jug ugodnije klime, te se u tom dijelu nalazi i možda najljepša šuma crnike na Mediteranu. Na otoku Rabu nalazi se nekoliko manjih mjesta, sela i zaseoka. Jedno od njih je istoimeno mjesto Rab poznato po svoja 4 zvonika, koja su na neki način postala simbol grada Raba, dok je njegov zaštitnik Sv. Kristofor. Grad Rab krase srednjovjekovne zidine kojima je ograđen, kao i gotička bazilika Sv. Marije čije motive rapske žene prenose na poznatu rapsku čipku. Čisto i bistro more, sugestivna priroda, te gostoprimstvo stanovnika otoka Raba prepoznatljiva su obilježja koji će vaš boravak na Rabu učiniti posebnim. Rab je otok različitosti i suprotnosti. Na sjeveru brdski masiv i ogoljeli okoliš od bure, na jugu pješčane plaže, sljunčane ili pak stjenovite. Tako će svatko na Rabu pronaći neki vlastiti kutak za sebe. Posebna atrakcija na Rabu su Viteški turniri samostreličara koji se održavaju u čast zaštitnika grada Raba sv. Kristofora čiji se relikvij čuva u Gradskom muzeju Sakralne umjetnosti. Po završetku turnira i svečanog zatvaranja ´Rapske fjere´ je ponoćni vatromet. Rab je tipični srednjevjekovni grad okružen rimskim zidinama. Rab se rodio i razvio se oko središnjeg trga gdje se nalazi bazilika Santa Maria čiji su prozori inspiracija poznatoj paškoj čipki. Lopar je mali turistički gradić na Rabu poznat po brojnim pješćanim plažama, njih čak 22. Najveća i najpoznatija strong>plaža u Loparu je 1,5 km duga &#34;Rajska plaža&#34; uz koju je smještena većina hotela i apartmana, te poznato turističko naselje &#34;San marino&#34; sa najvećim autokampom na otoku. Osim rajske plaže preporučujemo i plažu &#34;Sahara&#34; i &#34;Ciganka&#34;, a ima i puno manjih plaža u brojnim uvalama i sve su pješćane. U samom mjestu Lopar nalazi se crkva Sv.Ivana Krstitelja, zaštitnika župe Lopar, a na obližnjem brežuljku u borovoj šumi smjestila se crkva Blažene Djevice Marije iz 14. stoljeća. Lopar je poznat i po rapskim samostreličarima koji ljeti na brojnim manifestacijama privlače interes turista. Lopar je pogodan za odmor obiteljima s djecom i mladima željnim aktivnog provoda, sporta i zabave.              ', 1, 1, 0.00, '/uploads/1-4.jpg', '44.75832500', '14.75982000'),
(4, 'Split', 'Glavno urbano, kulturno i prometno središte Dalmacije', '                Split je glavno urbano, kulturno i prometno središte Dalmacije iz kojega vode putovi kopnom i morem u brojna ljetovališta širom Dalmacije. Grad s 1700 godina postojanja uz mnoštvo arheoloških, povijesnih i kulturnih spomenika, među kojima posebno mjesto svakako zauzima čuvena Dioklecijanova palača, dio svjetske baštine UNESCO-a. Dioklecijanova palača je antička palača cara Dioklecijana. Oko 300. godine podigao ju je rimski car Dioklecijan i u njoj boravio nakon povlačenja s prijestolja (305.) do smrti (316.). Sagrađena je u uvali poluotoka 5 km jugozapadno od Salone, glavnoga grada provincije Dalmacije. Ostatci palače danas su dio povijesne jezgre Splita koja je upisana na UNESCO-v popis mjesta svjetske baštine u Europi još 1979. godine. Ispred Splita proteže se Brački kanal, a iza njega uzdižu se planine Kozjak i Mosor i pogled na otoke redom, Brač, Hvar, Paklenjake, Šoltu, Korčulu, sve poznate dalmatinske otoke.Split je i najvažnije središte Dalmacije koje od nedavno, osim zračne luke kraj Trogira i trajektne luke za brodske veze s otocima i autoputom je povezano sa sjeverom Hrvatske. Turistička ponuda Splita interesantna je, posebna i zanimljiva i zbog splitske zelene tržnice. To je srce grada Splita, motivi izobilja raznih vrsta, okusa, mirisa, boja. Za one koji žele osjetiti na neki način duh grada Splita, njegova zelena tržnica je svakako nezaobilazno mjesto.               ', 1, 1, 0.00, '/uploads/1-3.jpg', '43.50712700', '16.44060200'),
(5, 'Brijuni', 'Brijuni su otočje i nacionalni park u Jadranskom moru, na hrvatskom dijelu Jadrana', '                Brijuni su otočje i nacionalni park u Jadranskom moru, na hrvatskom dijelu Jadrana. Nalaze se koji kilometar zapadno od istarske obale, nasuprot mjesta Fažana, te se sastoje od 14 otoka i otočića ukupne površine 33,9 km kvadratna (površina otoka i akvatorija; na brijunski akvatorij otpada 80% ukupne površine). Dva najveća otoka su Veliki Brijun 7 km2 i Mali Brijun 1,7 km2, a manji su Sveti Marko, Gaz, Okrugljak, Šupin, Šupinić, Galija, Grunj, Vanga, Madona, Vrsar, Kozada i Sveti Jerolim. Brijuni imaju bogatu povijest: prvi, zasada nama poznati tragovi ljudskog djelovanja na Brijunima, sežu u treće tisućljeće prije Krista, kada su na Brijunima živjeli etnički nepoznati stanovnici koji su se bavili ratarstvom, stočarstvom, lovom i ribolovom, a oružje i oruđe izrađivali su od kamena, kostiju i pruća... Za vrijeme velike Egejske seobe naroda u prvom tisućljeću prije Krista na Brijune dolazi ilirsko pleme Histri, po kojima je kasnije Istra i dobila ime. Nakon kojih su došli Rimljani, a od VI. do VIII. st. otočjem su (kao i Istrom) vladali Bizantinci. Na Brijunima postoje mnogi kulturno-povijesni ostaci od kojih su najpoznatiji i najsačuvaniji: rimski ladanjski dvorac iz I.-II. st. s termama, Venerinim hramom, zatim Bizantski kastrum, te bazilika Sv. Marije iz V.-VI. stoljeća, crkva Sv. Germana iz XV. stoljeća. Zahvaljujući svojoj razvedenoj obali, povijesti, raznovrsnoj flori i fauni, zbog čega Brijune znaju zvati &#34;raj na Zemlji&#34;, Brijuni su 27. listopada 1983. godine proglašeni nacionalnim parkom i omiljena su turistička destinacija. Razvedenost obala, raznolikost podloga, batimetrijska konfiguracija te specifični hidrodinamički uvjeti se odražavaju i u velikoj raznolikosti litoralnih biocenoza - životnih zajednica - koje su karakteristične za sjeverno - jadransku regiju i još uvijek nepromijenjene izvan utjecaja izravnih izvora onečišćenja. Brijunski akvatorij značajan je kao mrijestilište riba te reprezentativna oaza (morski park) za tipične morske organizme sjevernog Jadrana, odnosno njihovih naselja i zajednica. Od morskih organizama koji su zaštićeni zakonom o  zaštiti prirode u podmorju Brijuna utvrđena je prisutnost periske (Pinna nobilis) i prstaca (Lithophaga lithophaga). Od zaštićnih morskih kralježnjaka povremeno more oko Brijuna posjećuju kornjače i dupini                            ', 2, 1, 0.00, '/uploads/1-brijuni3.jpg', '44.91277800', '13.76388900'),
(6, 'Kornati', 'Ukupna površina parka je oko 220 km² a sastoji se od 89 otoka, otočića i hridi.', '                Nacionalni park Kornati čini veći dio grupe otoka Kornati u hrvatskom dijelu Jadrana u srednjoj Dalmaciji, zapadno od Šibenika, u Šibensko-kninskoj županiji. Nacionalnim parkom je proglašen 1980. i tada je stavljen pod zaštitu. Ukupna površina parka je oko 220 km² a sastoji se od 89 otoka, otočića i hridi. Od površine parka, samo oko 1/4 je kopno, dok je preostali dio morski ekosustav.Obiluje prirodnim i kulturnim posebnostima. Okomite litice &#34;krune&#34; kornatskih otoka okrenute prema otvorenom moru najpopularniji su fenomen ovoga parka. One su i staništa rijetkih vrsta. Svijet kornatskoga podmorja otkriva pak neke druge zadivljujuće priče. A dobro je znati i to da je kopneni dio Parka u privatnom vlasništvu. . Ovaj najrazvedeniji otočni ekosustav u Jadranskom moru, koji uključuje čak 12% svih otoka hrvatskog Jadrana (1264 otoka, od čega je 67 napučenih), a tek 1% ukupne hrvatske morske površine, odavno plijeni pozornost brojnih nautičara, ronilaca, planinara i drugih zaljubljenika u prirodu i ono što priroda nudi. U područje parka može se doći vlastitim (ili iznajmljenim) plovilom, ili u organizaciji jednog od mnogobrojnih brodara i/ili turističkih agencija diljem Jadrana koji organiziraju izlete u područje parka.              ', 2, 1, 0.00, '/uploads/1-kornati1.jpg', '43.79666700', '15.33222200'),
(7, 'Krka', 'Krka je postao nacionalni park 24. siječnja 1985. godine i sedmi je po redu nacionalni park u Hrvatskoj.', '                Krka je sedmi nacionalni park u Hrvatskoj poznat po velikom broju jezera i slapova. Dobio je ime po rijeci Krki koja je dio parka. Nacionalni park je lociran u središnjoj Dalmaciji nizvodno od Miljevaca, a samo par kilometara sjeveroistočno od grada Šibenika. Obuhvaća područje uz rijeku Krku koja izvire u podnožju planine Dinare kod Knina, teče kroz kanjon dug 75 km, protječe kroz Prokljansko jezero, te utječe u Šibenski zaljev. Prostire na 142 kvadratna kilometra, od kojih 25,6 kvadratnih kilometara čini vodena površina. Rijeka Krka danas ima 7 sedrenih slapova i njezine ljepote predstavljaju prirodni krški fenomen, koji se preporučuje posjetiti u proljeće i ljeti jer je tada u punom sjaju, a možete se i osvježiti u čistoj vodi. Krka je postao nacionalni park 24. siječnja 1985. godine i sedmi je po redu nacionalni park u Hrvatskoj. Poznat je po velikom broju jezera i slapova. Hidroelektrana Jaruga ispod slapa Skradinskog buka je druga najstarija hidroelektrana u svijetu i prva u Europi. Sagrađena je 28. kolovoza 1895., samo tri dana nakon prve svjetske hidroelektrane na slapovima Niagare.              ', 2, 1, 0.00, '/uploads/1-krka2.jpg', '43.85888900', '15.97611100'),
(8, 'Plitvička jezera', 'Prelijepa jezera u Gorskom kotaru s jako visokom cijenom karata', '                Nacionalni park Plitvička jezera osobita je geološka i hidrogeološka krška pojava. Kompleks Plitvičkih jezera proglašen je nacionalnim parkom 8. travnja 1949. godine. To je najveći, najstariji i najposjećeniji hrvatski nacionalni park. Predstavlja šumovit planinski kraj u kojem je nanizano 16 manjih i većih jezera kristalne modrozelene boje. Jezera dobivaju vodu od brojnih rječica i potoka, a međusobno su spojena kaskadama i slapovima. Sedrene barijere, koje su nastale u razdoblju od desetak tisuća godina, jedna su od temeljnih osobitosti Parka. Poseban zemljopisni položaj i specifične klimatske značajke pridonijeli su nastanku mnogih prirodnih fenomena i bogatoj biološkoj raznolikosti. Sedreni sedimenti oblikovani su od pleistocena do danas u vrtačama i depresijama između okolnih planina. Gornja jezera na jugu pretežno se sastoje od dolomita, a Donja jezera na sjeveru od vapnenačkih stijena. kupna površina je 29.685 hektara, od čega jezera čine 200 ha, šume 13.320 ha, a ostalo su travnjaci i ostale površine. Prosječna nadmorska visina je 600 m. Najniža točka je 367 m na Koranskom mostu, a najviša 1279 m na Seliškom vrhu.              ', 2, 1, 0.00, '/uploads/1-pjezera2.jpg', '44.87166700', '15.59972200'),
(9, 'Cetina', 'Pripada Jadranskom slijevu, a nalazi se u Splitsko-dalmatinskoj županiji', '                Cetina je rijeka koja pripada Jadranskom slijevu, a nalazi se u Splitsko-dalmatinskoj županiji. Duga je 105 km i ulijeva se u Jadransko more kod Omiša.  Cetina izvire na nadmorskoj visini od 385 m u sjeverozapadnim obroncima Dinare blizu sela Cetina, 7 km sjeverno od Vrlike, a po kojem je rijeka i dobila ime. Izvor Cetine je jezero duboko preko stotinu metara. Tijekom ljetne turističke sezone, u donjem toku Cetine (od Slimena do Radmanovih mlinica kod Omiša), svakodnevno se, dva puta dnevno u trajanju od 3 do 4 sata odvija rafting. Sami rafting traje između 3 i 4 sata, na 12 km dugom dijelu rijeke. Start se nalazi u selu Penšići, a staza prolazi kroz slikovite usjeke, zaigrane vodopade i brzace te završava u Radmanovim Mlinicama. Tu možete predahnuti i uživati u čudesnom prirodnom ambijentu koji je svojim svježim zrakom i specifičnim reljefom, tako različit od obližnje jadranske obale. U Omišu osim raftinga, posebno je razvijeno i slobodno penjane, doslovno u samom centru grada se nalaze penjački smjerovi, a brojka od preko četrdeset smjerova na ukupno sedam penjališta će pružiti užitak i najzahtjevnijim penjačima.                            ', 3, 1, 0.00, '/uploads/1-cetina1.jpg', '43.45172200', '16.69647200'),
(10, 'Paklenica', 'Drugi nacionalni park u Hrvatskoj, proglašen još 19. listopada 1949. godine, tek nekoliko mjeseci nakon NP Plitvička jezera', '                Nacionalni park Paklenica je po proglašenju drugi nacionalni park u Hrvatskoj, proglašen još 19. listopada 1949. godine, tek nekoliko mjeseci nakon NP Plitvička jezera. Temeljni fenomeni NP Paklenica su šume i geomorfološke osobitosti parka. U gotovo nešumskom južnom dijelu Velebita u Paklenici se javlja izrazito bogatstvo šumskih zajednica, a posebno mjesto zauzimaju šume crnog bora po čijoj je smoli (Paklini) koja se je iz njih u prošlosti vadila Paklenica i dobila ime, te bukve i bora krivulja. Od geomorfoloških osobina najzanimljiviji, a ujedno i najimpresivniji su kanjoni Male i Velike Paklenice koji se usjecaju duboko u utrobu Velebita. Paklenicu godišnje posjeti preko 100.000 posjetitelja, a najvjerniji posjetitelji su penjači koje se od proljeće do jeseni može vidjeti na stjenama Paklenice, posebice na najvećoj hrvatskoj stjeni Anića kuku (712 m). NP Paklenica zauzima površinu od 96 km2. Najviši vrhovi su Vaganski vrh (1757 m) i Sveto brdo (1753 m). U nacionalnom parku postoji i nekoliko špilja i jama od kojih su najpoznatije i najveće špilja Manita peć iznad kanjona Velike Paklenice i Jama Vodarica između kanjona Velike i Male Paklenice. Zbog toga velika je zainteresiranost ljubitelja penjanja za sami park.              ', 3, 1, 0.00, '/uploads/1-paklenica1.jpg', '44.34157900', '15.47694800'),
(11, 'Premantura', 'Najjužnije mjesto istarskog poluotoka, u sastavu općine Medulin', '                Premantura, najjužnije mjesto istarskog poluotoka, u sastavu općine Medulin, oko 10 km južno od Pule. Premantura je izrazito turističko mjesto s oko 850 stanovnika koje tijekom turističke sezone, zahvaljujući kampovima i blizini parku prirode &#34;Kamenjak&#34;, postaje jedno od glavnih odredišta turista. Premanturci su okruženi prirodom kakvom se malo tko može pohvaliti. Južno od sela nalazi se Rt Kamenjak – zaštićeni krajolik dug 9,5 kilometara, širok oko 1,5 s ukupno 30 kilometara razvedene obale. More nije nigdje takve plavozelene boje, tako čisto kao na ovom krajnjem jugu Istre. Stjenovite plaže izmjenjuju se sa šljunčanim uvalama. Na razmjerno malom području raste 530 biljnih vrsta, od čega 20 vrsta orhideja, među kojima ima i nekoliko endemičnih. Stoga na rtu nema kampova, hotela niti bilo kakve gradnje. Glavnina premanturske smještajne ponude koncentrirana je na četiri dobro opremljena kampa. S prirodom u dnevnom boravku najbolje možete doživjeti ovaj jedinstven krajolik. Domaćini nude smještaj i u apartmanima privatnih kuća. Želite li robinzonsku pustolovinu? Jedinstvena je ponuda - svjetionik na otočiću Porer, koji se unajmljuje ljeti. Nađete li se na Kamenjaku, obavezno posjetite njegov najjužniji dio gdje su poseban događaj noćni skokovi s visokih stijena u more i skakač koji u ruci nosi baklju. Premantura je doživljaj, a ne jedno od mjesta odmora. Zbog povoljnih vjetrova u sportovima na moru uživa se ljeti, pa sve do kasne jeseni. Početkom studenog održava se atraktivan susret surfera - Hallowin. Onima koji žele zaroniti u duboko plavetnilo pomoći će ronilačka središta u mjestu. Ovo je jedna od rijetkih destinacija koja raspolaže plažom uređenom za slijepe osobe. Svakako valja istaći da tu mogu ljetovati i osobe kojima je neophodna dijaliza budući da u mjestu postoji privatna klinika za dijalizu. No jedna od najznačajnihij aktivnosti  Prematura je windsurfing.              ', 3, 1, 0.00, '/uploads/1-premantura.jpg', '44.80111100', '13.90888900'),
(12, 'Umag', 'Stara jezgra Umaga leži na poluotoku, između dva plitka zaljeva', '                Umag je mali gradić i luka na sjeverozapadnom dijelu Istre. Stara jezgra Umaga leži na poluotoku, između dva plitka zaljeva. Sjeverni, prostraniji zaljev zaštićen je lukobranom i pretvoren u luku. Sjeverni, prostraniji zaljev zaštićen je lukobranom i pretvoren u luku. Novi dio grada okrenut je prema otvorenom zaljevu pa se spaja s turističkom četvrti na sjeverozapadu. Marina Umag je u sjevernom dijelu luke. U turističkom smislu Umag je bogat turističkim naseljima, ali i brojnim hotelima. Svaki od ovih turističkih centara obiluje sportskim terenima i raznim sportskim sadržajima za ronjenje, jedriličarenje, skijanje na vodi, surfanje, tenis, kašarku, nogomet, odbojku, rukomet, ali i mogućnosti za jahanje konja. Najzanimljivije su od svih možda Igre bez granica na pijesku. Umag je također i zona uzgoja kvalitetnih vina što potvrđuju i brojne kantine na umaškom području. Umag je grad pun različitosti između modernog i tradicionalnog. Među starim zidinama grada nalazi se kaštel sa crkvicom Sv. Marije iz XVIII st.                            ', 3, 1, 0.00, '/uploads/1-umag2.jpg', '45.43333300', '13.51666700');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_ratings`
--

CREATE TABLE IF NOT EXISTS `s2_ratings` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_lid` int(11) NOT NULL,
  `rating_uid` int(11) NOT NULL,
  `rating_vote` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `rating_id_UNIQUE` (`rating_id`),
  KEY `rating_location_idx` (`rating_lid`),
  KEY `rating_ratedby_idx` (`rating_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_roles`
--

CREATE TABLE IF NOT EXISTS `s2_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  `role_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_id_UNIQUE` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Izbacivanje podataka za tablicu `s2_roles`
--

INSERT INTO `s2_roles` (`role_id`, `role_name`, `role_desc`) VALUES
(1, 'ADMIN', 'Administrator stranice'),
(2, 'USER', 'Korisnik stranice');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `s2_users`
--

CREATE TABLE IF NOT EXISTS `s2_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_role` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  UNIQUE KEY `user_email_UNIQUE` (`user_email`),
  KEY `user_auth_idx` (`user_role`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Izbacivanje podataka za tablicu `s2_users`
--

INSERT INTO `s2_users` (`user_id`, `user_name`, `user_password`, `user_email`, `user_role`) VALUES
(1, 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'atomasevi@tvz.hr', 1),
(2, 'user', '5f4dcc3b5aa765d61d8327deb882cf99', 'user@tvz.hr', 2);

--
-- Ograničenja za izbačene tablice
--

--
-- Ograničenja za tablicu `s2_comments`
--
ALTER TABLE `s2_comments`
  ADD CONSTRAINT `comment_authorid` FOREIGN KEY (`comment_author`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `comment_location` FOREIGN KEY (`comment_lid`) REFERENCES `s2_locations` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_locations`
--
ALTER TABLE `s2_locations`
  ADD CONSTRAINT `location_category` FOREIGN KEY (`location_cat`) REFERENCES `s2_categories` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `location_owner` FOREIGN KEY (`location_author`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_ratings`
--
ALTER TABLE `s2_ratings`
  ADD CONSTRAINT `rating_location` FOREIGN KEY (`rating_lid`) REFERENCES `s2_locations` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rating_ratedby` FOREIGN KEY (`rating_uid`) REFERENCES `s2_users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `s2_users`
--
ALTER TABLE `s2_users`
  ADD CONSTRAINT `user_auth` FOREIGN KEY (`user_role`) REFERENCES `s2_roles` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
