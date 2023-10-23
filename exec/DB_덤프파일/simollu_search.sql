-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 43.200.152.213    Database: simollu
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search` (
  `search_seq` bigint NOT NULL AUTO_INCREMENT,
  `search_word` varchar(255) DEFAULT NULL,
  `search_regist_date` bigint DEFAULT NULL,
  PRIMARY KEY (`search_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=815 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search`
--

LOCK TABLES `search` WRITE;
/*!40000 ALTER TABLE `search` DISABLE KEYS */;
INSERT INTO `search` VALUES (270,'베트남음식',1683794667460),(271,'베트음식',1683794670584),(272,'베트꽁음식',1683794677069),(273,'베트꽁음식',1683795135459),(274,'베트꽁음식',1683849146294),(275,'베트남음식',1683849190998),(276,'베트남음식',1683849981657),(277,'베트남음식',1683850142344),(278,'베트남음식',1683850528913),(279,'동래정',1683850631177),(280,'동래정',1683850640474),(281,'베트남음식',1683851534264),(282,'이소민',1683851539139),(283,'이소민',1683851539938),(284,'이소민',1683851540913),(285,'이소민',1683851541729),(286,'이소민',1683851542736),(287,'이소민',1683851543910),(288,'이소민',1683860381312),(289,'이소민',1683860386271),(290,'이소민',1683860390168),(291,'이소민',1683860397060),(292,'이소민',1683860403521),(293,'이소민',1683860407688),(294,'동동쓰',1683860508819),(295,'입민정',1683860513459),(296,'손민정',1683860518070),(297,'김민정',1683860522167),(298,'동민정',1683860525638),(299,'언민정',1683860530427),(300,'동래정',1683860885942),(301,'동래정',1683863962211),(302,'한식',1683863968304),(303,'고기',1683863987396),(304,'돼지고기구이',1683863994216),(305,'동래정',1683864031371),(306,'언민정',1683865105453),(307,'동래정',1683866208590),(308,'동래정',1683866615992),(309,'동래정',1683866797043),(310,'초밥',1683867783789),(311,'디저트',1683868022489),(312,'케익',1683868434793),(313,'피자',1683868445759),(314,'패스트푸드',1683868461240),(315,'브런치',1683868471522),(316,'분식',1683868492197),(317,'다이어트',1683868505521),(318,'카페',1683868531176),(319,'김밥',1683868578337),(320,'베이커리',1683868587835),(321,'동래정',1683868622142),(322,'미도인',1683869146823),(323,'중식당',1683877671017),(324,'분식',1683877733677),(325,'패스트푸드',1683877745486),(326,'류센소',1683877902006),(327,'류센소',1683878325594),(328,'동래정',1683878373050),(329,'동래정',1683878922272),(331,'류센소',1683879190337),(332,'류센소',1683879627718),(333,'한식',1683879700127),(334,'갓덴스시',1683879739095),(335,'갓덴스시',1683879791283),(336,'류센소',1683880069632),(337,'류센소',1683881294110),(338,'류센소',1683881503439),(339,'동래정',1684036853519),(340,'동래정',1684078177609),(341,'류센소',1684078323083),(342,'류센소',1684078511164),(343,'류센소',1684080447815),(344,'류센소',1684081188355),(345,'한식',1684109543209),(346,'동래정',1684109591806),(347,'동래정',1684109605574),(348,'동래정',1684109690235),(349,'동래정',1684109910594),(350,'한식',1684109963265),(351,'동래정',1684109982744),(352,'피자',1684114522827),(353,'동래정',1684114533436),(354,'한식',1684115568341),(355,'피자',1684115602405),(356,'동래정',1684115683083),(357,'한식',1684115877397),(358,'피자',1684115921662),(359,'동래정',1684115928486),(360,'한식',1684115938909),(361,'동래정',1684115946413),(362,'동래정',1684115969170),(363,'동래정',1684115993017),(364,'한식',1684116076003),(365,'동래정',1684116084211),(366,'피자',1684116089053),(367,'일식',1684116093945),(368,'김밥',1684116108992),(369,'김밥',1684116245252),(370,'한식',1684117280767),(371,'한식',1684117346065),(372,'한식',1684117353837),(373,'한식',1684117353837),(374,'한식',1684117354036),(375,'한식',1684117354124),(376,'한식',1684117354127),(377,'한식',1684117354360),(378,'한식',1684117354509),(379,'한식',1684117354648),(380,'한식',1684117354837),(381,'한식',1684117354838),(382,'한식',1684117356718),(383,'한식',1684117361644),(384,'한식',1684117536499),(385,'한식',1684117733783),(386,'일식',1684123870793),(387,'한식',1684123884672),(388,'동래정',1684123978894),(389,'동래정',1684123987546),(390,'동래정',1684124029981),(396,'동래정',1684125310501),(398,'한식',1684127975224),(399,'한식',1684127986782),(400,'김밥',1684129044232),(401,'동래정',1684130963756),(402,'동래정',1684130971230),(403,'동래정',1684131059847),(419,'동래정',1684134255782),(420,'김밥',1684134281790),(421,'중식당',1684134316655),(422,'일식',1684134322903),(423,'브런치',1684134327285),(424,'한식',1684135020679),(425,'동래정',1684135044240),(426,'동래정',1684135061171),(427,'동래정',1684136115267),(428,'김밥',1684136128552),(429,'',1684136168450),(430,'김밥',1684136174372),(431,'동래정',1684136292988),(432,'김밥',1684136313860),(433,'양식',1684136354743),(434,'일식',1684136367210),(435,'김밥',1684136528900),(436,'다이어트',1684136557068),(437,'돼지고기구이',1684136567032),(438,'김밥',1684136724129),(439,'돼지고기구이',1684137440786),(440,'동래정',1684137562580),(441,'양식',1684137708943),(442,'패스트푸드',1684137918302),(443,'베이커리',1684137924960),(445,'다이어트',1684137956493),(446,'베트남음식',1684138030938),(447,'똥럐쩡',1684138074809),(448,'동래정',1684138241011),(449,'동래정',1684139016443),(450,'동래정',1684139219829),(451,'동래정',1684140522709),(452,'동래정',1684201596541),(453,'양식',1684201665690),(454,'다이어트',1684201673360),(455,'김밥',1684201678500),(456,'다이어트',1684201682622),(457,'돼지고기구이',1684201686076),(458,'동래정',1684201700657),(459,'동래정',1684201727252),(461,'동래정',1684201946573),(464,'동래정',1684201996858),(465,'동래정',1684201998115),(466,'동래정',1684202000148),(469,'동래정',1684202083583),(473,'동래정',1684202258093),(477,'동래정',1684202712828),(478,'동래정',1684202733934),(480,'동래정',1684202907619),(481,'동래정',1684202985481),(482,'동래정',1684203578902),(483,'동래정',1684203919269),(484,'동래정',1684210705442),(485,'동래정',1684210814368),(486,'동래정',1684211501245),(487,'동래정',1684211506287),(488,'동래정',1684211572309),(490,'베트남음식',1684211906079),(491,'',1684211926105),(492,'동래',1684211930627),(493,'신동궁',1684212115813),(494,'신동궁',1684212151181),(495,'신동궁',1684212169117),(496,'동래정',1684212404721),(497,'동래정',1684212873394),(501,'동래',1684214361112),(502,'동래정',1684215292321),(503,'동래정',1684215292513),(504,'동래정',1684215313307),(505,'동래정',1684215313475),(506,'동래',1684215797730),(507,'동래',1684215854565),(508,'동래정',1684215965925),(509,'동래정',1684215975305),(510,'피자',1684216077415),(511,'피자',1684216212775),(512,'오리지널시카고피자',1684216343572),(513,'동래정',1684216580302),(514,'오리지널시카고피자',1684216737366),(515,'오리지널시카고피자',1684216741431),(516,'오리지널시카고피자',1684216743899),(517,'오리지널시카고피자',1684216745395),(518,'오리지널시카고피자',1684216746453),(519,'오리지널시카고피자',1684216747551),(520,'오리지널시카고피자',1684216749078),(521,'오리지널시카고피자',1684216750395),(522,'동래정',1684217191412),(523,'패스트푸드',1684217252057),(524,'브런치',1684217255224),(525,'분식',1684217264645),(526,'황소곱창',1684217753149),(527,'동래정',1684217965975),(528,'동래정',1684217994861),(529,'황소곱창',1684218458964),(530,'황소곱창',1684218466150),(531,'황소곱창',1684218524476),(532,'동래정',1684218761312),(533,'황소곱창',1684219097286),(534,'김밥',1684219199592),(535,'동래정',1684219350690),(536,'동래정',1684219418932),(537,'동래정',1684224470586),(538,'동래정',1684234250091),(539,'황소곱창',1684234313957),(540,'피자',1684234552199),(541,'동래정',1684234660088),(542,'동래정',1684234831530),(543,'동래정',1684234934237),(544,'동래정',1684235518508),(545,'동래정',1684235683274),(546,'동래정',1684236132446),(547,'피자',1684236151193),(548,'김밥',1684236403913),(549,'김밥',1684236601213),(550,'보승회관',1684236739007),(551,'오토김밥',1684236993491),(552,'떡도리탕',1684237469991),(553,'갓덴',1684237525757),(554,'동래정',1684237625530),(555,'한식',1684237636297),(556,'카페',1684237662049),(557,'양식',1684238061654),(558,'동래정',1684238207050),(559,'갓덴스시',1684238377265),(560,'dd',1684257935803),(562,'동래',1684271418229),(563,'동래',1684271577725),(564,'동래',1684272042579),(565,'동래정',1684281178779),(566,'황소곱창',1684281457830),(567,'동래정',1684281519078),(568,'동래정',1684283032828),(569,'햄버거',1684283043778),(570,'동래정',1684283286555),(571,'햄버거',1684283462410),(572,'동래정',1684283771959),(573,'동래정',1684283947268),(574,'동래정',1684284339035),(575,'오토김밥',1684285003622),(576,'돼지고기구이',1684285024563),(577,'동래정',1684285312057),(578,'동래정',1684285563176),(579,'동래정',1684285580601),(580,'동래정',1684285583624),(581,'동래정',1684285656877),(582,'동래정',1684286120057),(583,'동래정',1684286124116),(593,'동래정',1684286544815),(594,'동래정',1684286716409),(595,'땀땀',1684288619836),(596,'동래정',1684288880412),(597,'동래정',1684289161901),(598,'땀땀',1684289259896),(599,'동래정',1684289300260),(600,'땀땀',1684289308137),(601,'동래정',1684289341611),(602,'솥뚜껑',1684289443748),(603,'동래정',1684289487940),(604,'동래정',1684290048784),(605,'솥뚜껑',1684293787415),(606,'동래정',1684293872871),(607,'호보식당',1684293940330),(608,'호보식당',1684293961259),(609,'호보식당',1684294011608),(610,'동래정',1684294305689),(614,'동래정',1684294930255),(615,'호보식당',1684294936590),(616,'호보식당',1684294957091),(617,'동래정',1684294971512),(618,'호보식당',1684294985395),(619,'호보',1684295739860),(620,'동래정',1684297057108),(621,'동래정',1684297146025),(622,'일식',1684298327461),(623,'동래정',1684300240614),(624,'동래정',1684300281125),(625,'동래정',1684301913065),(626,'동래정',1684307572381),(627,'동래정',1684307989962),(628,'동래정',1684308052758),(629,'동래정',1684312101118),(630,'동래정',1684313268617),(632,'바스버거',1684318102294),(633,'동래정',1684318350627),(634,'떡도리탕',1684321085234),(635,'떡도리탕',1684321470387),(636,'동래',1684322125991),(637,'동래정',1684322581514),(638,'동래',1684324101316),(639,'동래',1684324102302),(640,'동래',1684324107329),(641,'동래',1684324490221),(642,'동래',1684324643451),(643,'동래',1684324645151),(644,'동래',1684324647439),(645,'동래정',1684325683785),(646,'동래',1684327869376),(647,'오토김밥',1684336565044),(648,'오토김밥',1684336566120),(649,'동래',1684336872519),(650,'한식',1684337266160),(651,'돼지고기구이',1684337269813),(652,'동래정',1684368355174),(653,'동래정',1684368361148),(654,'동래정',1684368972261),(655,'동래정',1684369142053),(656,'동래',1684369730953),(657,'동래정',1684369776101),(658,'동래정',1684369927937),(659,'동래정',1684370060379),(660,'동래정',1684370411362),(661,'동래정',1684370411615),(662,'동래정',1684370566919),(663,'동래정',1684370790817),(664,'동래정',1684371588402),(665,'동래정',1684371702768),(666,'동래정',1684373367596),(667,'동래정',1684375095217),(668,'동래정',1684375692591),(669,'동래정',1684376398443),(670,'동래정',1684376993279),(671,'이소민',1684383115398),(672,'이소민',1684383119185),(673,'이소민',1684383121656),(674,'나루토',1684383154142),(675,'동래정',1684383687319),(676,'김밥',1684384101234),(677,'동래정',1684384709344),(678,'갓덴스시',1684385577892),(679,'갓덴스시',1684385577894),(680,'갓덴스시',1684385577928),(681,'갓덴스시',1684386188415),(682,'돼지고기구이',1684386367031),(683,'카페',1684386409432),(684,'돼지고기구이',1684386417141),(685,'동래',1684386589949),(688,'동래',1684386789632),(689,'동래정',1684386794967),(695,'나루토',1684386864480),(696,'바스버거',1684387037164),(697,'나루토',1684387418594),(699,'나루토',1684387870921),(700,'동래정',1684388103451),(701,'바스버거',1684388127207),(702,'바스버거',1684388266133),(703,'동래정',1684388463687),(704,'바스버거',1684388489364),(705,'갓덴스시',1684388612299),(706,'동래정',1684389686384),(707,'동래정',1684391813282),(708,'동래정',1684395866573),(709,'동래정',1684396285074),(710,'동래정',1684396842946),(711,'동래정',1684396968562),(712,'동래정',1684397031432),(713,'일식',1684397606476),(714,'김밥',1684397612558),(715,'동래정',1684397619363),(716,'동래정',1684398255281),(717,'r',1684398304900),(718,'',1684398310816),(719,'동래정',1684398537360),(720,'갓덴스시',1684399684108),(721,'동래정',1684404629348),(722,'갓덴스시',1684404639108),(723,'동래정',1684405387212),(724,'동래정',1684411205178),(725,'동래정',1684411478415),(726,'동래정',1684411715460),(727,'동래정',1684411715642),(728,'동래정',1684411725231),(729,'동래정',1684411828419),(730,'동래정',1684411884401),(731,'동래정',1684411943069),(732,'동래정',1684412354011),(733,'동래정',1684412446186),(734,'동래정',1684412539009),(735,'동래정',1684412612037),(736,'동래정',1684412673755),(737,'갓덴스시',1684413029092),(738,'동래정',1684413288509),(739,'김밥',1684413554782),(740,'피자',1684413562723),(741,'동래정',1684413564228),(742,'피자',1684413568543),(743,'피자',1684413577074),(744,'피자',1684413582474),(745,'김밥',1684413605703),(746,'동래정',1684413611954),(747,'김밥',1684413634772),(748,'동래정',1684413643004),(749,'동래정',1684414488323),(750,'스시',1684414772673),(751,'동래정',1684414781670),(752,'동래정',1684415420981),(753,'동래정',1684415519994),(754,'동래정',1684416111643),(755,'동래정',1684416776746),(756,'김밥',1684416814030),(757,'일식',1684416951105),(758,'브런치',1684416953362),(759,'양식',1684416955421),(760,'한식',1684416957651),(761,'피자',1684416959903),(762,'김밥',1684416961955),(763,'한식',1684417426466),(764,'다이어트',1684417435386),(765,'육류',1684417449457),(766,'돼지고기구이',1684417457648),(767,'김밥',1684417471358),(768,'양식',1684417477465),(769,'한식',1684417481615),(770,'동래정',1684417497965),(771,'동래정',1684418685169),(772,'동래정',1684420143896),(773,'',1684420751447),(774,'',1684420751476),(775,'',1684420753427),(776,'바게트',1684420833252),(777,'김밥',1684421048430),(778,'동래정',1684421097184),(779,'김밥',1684421179351),(780,'동래정',1684421188972),(781,'동래정',1684422176883),(782,'동래정',1684422193708),(783,'동래정',1684422245956),(784,'김밥',1684424885113),(785,'동래정',1684424898248),(786,'김밥',1684425927773),(787,'동래정',1684425942484),(788,'동래정',1684427118714),(789,'김밥',1684427519993),(790,'동래정',1684427619503),(792,'동래정',1684428261771),(793,'동래정',1684428265140),(794,'동래정',1684428332506),(795,'동래정',1684428338309),(796,'김밥',1684431810915),(797,'동래정',1684431826035),(798,'김밥',1684433882394),(799,'동래정',1684433898054),(800,'김밥',1684434615004),(801,'동래정',1684434630572),(802,'동래정',1684438750754),(803,'동래정',1684450548868),(804,'동래정',1684450569341),(805,'동래정',1684453515701),(806,'김밥',1684454427285),(807,'동래정',1684454716635),(808,'동래정',1684454873914),(809,'김밥',1684455757874),(810,'동래정',1684455774504),(811,'김밥',1684458773698),(812,'동래정',1684458789870),(813,'동래정',1684460004524),(814,'동래정',1684460096886);
/*!40000 ALTER TABLE `search` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:55:55
