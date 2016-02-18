module Faker
  class BankAccount < Base
    class << self
      def routing_number(fraction_note=false)
        if fraction_note
          compile_fraction(valid_routing_number)
        else
          valid_routing_number
        end
      end

      def account_number
        return rand.to_s[2..11]
      end

      def iban
        return iban_nums.sample.scan(/..../).join(' ')
      end

      def swift
        return swift_codes.sample
      end

      def insitution_name
        return names.sample
      end

      private

      def checksum(num_string)
        num_array = num_string.split('').map(&:to_i)
        digit = (7 * (num_array[0] + num_array[3] + num_array[6]) + 3 * (num_array[1] + num_array[4] + num_array[7]) + 9 * (num_array[2] + num_array[5])) % 10
        return digit == num_array[8]
      end

      def compile_routing_number
        digit_one_two = ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
        ((21..32).to_a + (61..72).to_a + [80]).each { |x| digit_one_two << x.to_s }
        routing_num = digit_one_two.sample + rand_numstring + rand_numstring + rand_numstring + rand_numstring + rand_numstring + rand_numstring + rand_numstring
        return routing_num
      end

      def valid_routing_number
        for i in 0..500000
          micr = compile_routing_number
          if checksum(micr)
            break
          end
        end
        return micr
      end

      def compile_fraction(routing_num)
        prefix = (1..50).to_a.map(&:to_s).sample
        numerator = routing_num.split('')[5..8].join.to_i.to_s
        denominator = routing_num.split('')[0..4].join.to_i.to_s
        return prefix + '-' + numerator + '/' + denominator 
      end

      def rand_numstring
        return (0..9).to_a.map(&:to_s).sample
      end

      def names
        ['Industrial & Commercial Bank of China Limited', 'China Construction Bank Corporation','Agricultural Bank of China Limited', 'BNP Paribas SA','Bank of China Limited','Barclays Bank PLC','JPMorgan Chase Bank National Association','Deutsche Bank AG','Crédit Agricole SA', 'Japan Post Bank Co LTD.','China Development Bank Corporation','The Royal Bank of Scotland PLC','The Bank of Tokyo-Mitsubishi UFJ LTD','Société Générale','Bank of America NA','Wells Fargo Bank NA','Banco Santander SA','BPCE','Sumitomo Mitsui Banking Corporation','Citibank NA','Lloyds Bank PLC','Mizuho Bank LTD','HSBC Bank PLC','UBS AG','UniCredit SpA', 'Postal Savings Bank of China Co LTD','Bank of Communications Co LTD','ING Bank NV','Credit Suisse AG','The Hongkong and Shanghai Banking Corporation Limited','The Toronto-Dominion Bank','Rabobank Nederland','Royal Bank of Canada','Nordea Bank AB (publ)','The Norinchukin Bank','Intesa Sanpaolo SpA','Crédit Agricole Corporate and Investment Bank','Banco Bilbao Vizcaya Argentaria SA','China Merchants Bank Co LTD','Standard Chartered PLC','Natixis SA','Industrial Bank Co LTD','Shanghai Pudong Development Bank Co. LTD.','Commerzbank AG','Commonweath Bank of Australia','National Australia Bank LTD','China Citic Bank Corporation Ltd. (CNCB)','The Bank of Nova Scotia','China Minsheng Banking Corporation Limited','Australia and New Zealand Banking Group Limited']
      end

      def swift_codes
        ['CMNLUS41','CPPCUS31','FCABUS31','CETYUS66','PMFAUS66','PMFAUS66HKG','SRCEUS31','VIMAUS61','BRPPUS61','NOHTUS61','MMMCUS44','MOASUS31','SCCOUS31','AACMUS41','ABCTUS31','AFSBUS33','ABFGUS41','ANTSUS33','ABTTUS44','ABBVUS44','ABENUS31','ABENUS3N','ANFCUS33','ABAIUS31','ABEEUS31','ABMSUS61','FTSBUS33SFI','FTSBUS33','HGASUS31','ABMRUS31','ABRSUS41','ACEEUS31','ACSUUS31','ACSEUS31','ACISUS51','ADYNUS44','ACFIUS31','ACIXUS31','ACNLUS31','ACFOUS31','ACPYUS33','ACTLUS61','ADTRUS31','ADCLUS31','ADMDUS41','ADMIUS41','ADPGUS33','ADIPUS31','ADCMUS31','AINYUS31','KYOCJPJ1', 'SOLAJPJ1','SIEGJPJ1','LBFLJPJ1','LGDTJPJ1','LIQJJPJ1','LOCYJPJTNDP','LOCYJPJT','LTSCJPJ1','LUCSJPJ1','MACQJPJ1','MAEEJPJ1','MFCTJPJT','RUDAJPJ1','MAREJPJ1','MARCJPJ1NGY','MTBJJPJTAGT','MTBJJPJT','MATEJPJ1','TMTDJPJ1','ICBCJPJT','MYAMJPJ1','MESCJPJ1','MELNJPJT','DAIXJPJT','MLCOJPJX','MENCJPJ1','MBTCJPJT','MFGLJPJ1','MCHIJPJT','MIMSJPJ1','MIEBJPJT','MIKIJPJ1','HSINJPJK','MINXJPJ1','MISSJPJ1','IBXHCNBABJB','RCXMCNBA','XISCCNB1','HHRCCNBX','YMBKCNBD','YMBKCNBQ','YBRCCNBJ','YTCBCNSD','ZFRBCNBQ','YHJJCNB1','YZBKCN2N','ZDRCCNBZ','CZCBCN2X','FYBKCNSH','HNBCCNBJ','YHBKCNBH','HCRCCNBJ','ZJJRCNBZ','ZJMTCNSH','PHRCCNSH','QTBKCNBQ','ZJRCCN2N','ZSROCNBZ','SXHXCNBS','SZBKCNBQ','ZJTLCNBH','ZLBKCNBH','TLRBCN2A','WLBKCNSH','LCBKCNSH','OHBKCNSH','HXCBCN2H','ZXBKCN2X','YWBKCN2X','YONGKANG','YRCBCNBH','ZJPTCNBZ','ZJRBCNBH','ZXBCCNSH','TRSYDEFF','AGGBDE51','GENODED1AAC','AABSDE31','ABGMDE31','ABCADEFFKTO','WWBADE3A','ABKSDEF1','FTSBDEFAMYO','WUERDE66','GENODE51AGR','ABOCDEFF','AGBMDE21','AUSKDEFF','AKBKDEFF','AKFBDE31','AKBADES1','ALLUDE81','GENODEF1KEV','ADIMDEF1','VENRFRP1','GSTIFRP1','PATFFRP1','SOCLFRP1','AMATFRP1','TSIGFR22','AMDEFRP1','ASMRFRP1','IVPRFR21','PLFIFRP1','TGCLGB21','IIIGGB22','SHEMGB21','TOCUGB21','EDSOGB21','VARTGB21','BEECGB21','CPRTGB22','AAPEGB21','ABUSGB21','AASBBRS1','ACSTBRS1', 'ADDRBRSP','AGCVBRR1','KZBURU51','CMABRUMM','ABSLRUMM','ELKARU3SMOS','ORSKRU44','ABSMITM1','GIRDITM1','AGLRIT21','RMMAITR1','AETSITM1','AASVIND1','ABBLINBB','ACBLINBB','ADCBINBB','AJGSINB1','ASSOINB1','ACMCCAT1','ACFXCAW1','ACKFCAT1','ACCTCA61','ACMTCAMM','CPANAU21','WEAEAU31','ABWHAU21','MOFCAU51','ABEMAU21','PRDVESM1','ABABESM1','ATECESM1','EQSAESM1','AARBESM1','CAGLESMM','ABOCKRSE','AIKRKRS1','AITMKRS1','ACBOMXM10G2','ACBOMXM1','ACVLMXMM','ACAOMXM1','AFINMXM1','ARTGIDJA','BNPAIDJA','CENAIDJA','CTCBIDJABDG','CTCBIDJA','ADABTRIS','POYNTRI1','YAMGTRI1','AKBKTRIS002','TRNINL21','TRNGNL21','TAAINL21','AFSRNL21','AALBNL22','AMETSAJ1','INMASARI','RJHISARI','AMDISAJE','FNECCHG1','XIDECHZ1','KBAGCH22','ABBCCHZZ','ACIAARB1','AEIBARB1','BAZVARBA','AAKFSEM1','INUFSES1','SEFSSEG1','ABVOSEGG','ABBFSES1','ABNGNGLA','AFXMNGLA','AMNGNGLA','ADHLNGLA','BBSONGL1','SPAYPLP1','AIPOPLP1','ALBPPLP1BMW','SUNVNOK1','AASANO21','ABSRNOK1','AGSRNOK1','AANSNO21','AARBBEB1','EBATBEBB','ABERBE21','FNCOVECA','ASDCVEC1','ARAFVEC1','ACONVEC1','GEINATW1','WOHAAT21','PSSAATWW','AGRXATWW','AAIAATW1','ACSCTHB1','ADKSTHB1','ADVNTHB1','ASPCTHB1','ABNAAEAAIPC','ABNAAEAA','ABPPAEA1','ADCBAEAACMD']
      end

      def iban_nums
        ['AL47212110090000000235698741','DZ4000400174401001050486','AD1200012030200359100100','AO06000600000100037131174','AT611904300234573201','AZ21NABZ00000000137010001944','BH29BMAG1299123456BH00','BA391290079401028494','BE68539007547034','BJ11B00610100400271101192591','BR9700360305000010009795493P1','BG80BNBG96611020345678','BF1030134020015400945000643','BI43201011067444','CM2110003001000500000605306','CV64000300004547069110176','CR0515202001026284066','HR1210010051863000160','CY17002001280000001200527600','CZ6508000000192000145399','DK5000400440116243','DO28BAGR00000001212453611324','TL380080012345678910157','EE382200221020145685','FO1464600009692713','FI2112345600000785','FR1420041010050500013M02606','GT82TRAJ01020000001210029690','GE29NB0000000101904917','DE89370400440532013000','GI75NWBK000000007099453','GR1601101250000000012300695','GL8964710001000206','HU42117730161111101800000000','IS140159260076545510730339','IR580540105180021273113007','IE29AIBK93115212345678','IL620108000000099999999','IT60X0542811101000000123456','CI05A00060174100178530011852','JO94CBJO0010000000000131000302','KZ176010251000042993','KW74NBOK0000000000001000372151','LV80BANK0000435195001','LB30099900000001001925579115','LI21088100002324013AA','LT121000011101001000','LU280019400644750000','MK07300000000042425','MG4600005030010101914016056','MT84MALT011000012345MTLCAST001S','MR1300012000010000002037372','MU17BOMM0101101030300200000MUR','ML03D00890170001002120000447','MD24AG000225100013104168','MC5813488000010051108001292','ME25505000012345678951','MZ59000100000011834194157','NL91ABNA0417164300','NO9386011117947','PK24SCBL0000001171495101','PS92PALS000000000400123456702','PL27114020040000300201355387','PT50000201231234567890154','QA58DOHB00001234567890ABCDEFG','XK051212012345678906','RO49AAAA1B31007593840000','SM86U0322509800000000270100','SA0380000000608010167519','SN12K00100152000025690007542','RS35260005601001611379','SK3112000000198742637541','SI56191000000123438','ES9121000418450200051332','SE3550000000054910000003','CH9300762011623852957','TN5914207207100707129648','TR330006100519786457841326', 'AE260211000000230064016','GB29NWBK60161331926819','VG96VPVG0000012345678901','AL47212110090000000235698741','AD1200012030200359100100','AT611904300234573201','AZ21NABZ00000000137010001944','BH67BMAG00001299123456','BE68539007547034','BA391290079401028494','BR7724891749412660603618210F3','BG80BNBG96611020345678','CR0515202001026284066','HR1210010051863000160','CY17002001280000001200527600','CZ6508000000192000145399','DK5000400440116243','DO28BAGR00000001212453611324','EE382200221020145685','FO6264600001631634','FI2112345600000785','FR1420041010050500013M02606','GE29NB0000000101904917','DE89370400440532013000','GI75NWBK000000007099453','GR1601101250000000012300695','GL8964710001000206','GT82TRAJ01020000001210029690','HU42117730161111101800000000','IS140159260076545510730339','IE29AIBK93115212345678','IL620108000000099999999','IT60X0542811101000000123456','JO94CBJO0010000000000131000302','KZ86125KZT5004100100','KW81CBKU0000000000001234560101','LV80BANK0000435195001','LB62099900000001001901229114','LI21088100002324013AA','LT121000011101001000','LU280019400644750000','MK07250120000058984','MT84MALT011000012345MTLCAST001S','MR1300020001010000123456753','MU17BOMM0101101030300200000MUR','MD24AG000225100013104168','MC5811222000010123456789030','ME25505000012345678951','NL91ABNA0417164300','NO9386011117947','PK36SCBL0000001123456702','PL61109010140000071219812874','PS92PALS000000000400123456702','PT50000201231234567890154','QA58DOHB00001234567890ABCDEFG','XK051212012345678906','RO49AAAA1B31007593840000','LC62HEMM000100010012001200023015','SM86U0322509800000000270100','SA0380000000608010167519','RS35260005601001611379','SK3112000000198742637541','SI56263300012039086','ES9121000418450200051332','SE4550000000058398257466','CH9300762011623852957','TL380080012345678910157','TN5910006035183598478831','TR330006100519786457841326','AE070331234567890123456','GB29NWBK60161331926819','VG96VPVG0000012345678901','YY24KIHB12476423125915947930915268','ZZ25VLQT3823322332065880113137764']
      end
    end
  end
end


# Faker::BankAccount.routing_number
# # => '1291131673'
# Faker::BankAccount.routing_number(true) # true to use the rare "fraction" notation
# # => '11-3167/1210'
# Faker::BankAccount.account_number
# # => '0114584906'
# Faker::BankAccount.iban
# # => 'GR16 0110 1250 0000 0001 2300 695'
# Faker::BankAccount.swift
# # => 'DEUTDFF'
# Faker::BankAccount.institution_name
# # => 'Ontario Agriculture Bank'
# # => 'First Bank of Osaka'
# # => 'Commerce Bank of Stockholm'
# # => 'Great American Sperm Bank'


